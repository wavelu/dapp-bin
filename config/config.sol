//sol Config
// Simple global configuration registrar.
// @authors:
//   Gav Wood <g@ethdev.com>
contract Config {
	function Config() {
		owner = msg.sender;
	}

	function register(uint id, address service) {
		if (tx.origin != owner)
			return;
		services[id] = service;
		log1(0, id);
	}

	function unregister(uint id) {
		if (msg.sender != owner && services[id] != msg.sender)
			return;
		services[id] = address(0);
		log1(0, id);
	}

	function kill() {
		if (msg.sender == owner)
			suicide(owner);
	}

	function lookup(uint service) constant returns(address a) {
		return services[service];
	}

	address owner;
	mapping (uint => address) services;
}

/*

// Solidity Interface:
contract Config{function register(uint,address){}function unregister(uint){}function lookup(uint)constant returns(address){}function kill(){}}

// Example Solidity use:
address addrConfig = 0x661005d2720d855f1d9976f88bb10c1a3398c77f;
address addrNameReg = Config(addrConfig).lookup(1);

// JS Interface:
var abiConfig = [{"constant":false,"inputs":[],"name":"kill","outputs":[]},{"constant":true,"inputs":[{"name":"service","type":"uint256"}],"name":"lookup","outputs":[{"name":"a","type":"address"}]},{"constant":false,"inputs":[{"name":"id","type":"uint256"},{"name":"service","type":"address"}],"name":"register","outputs":[]},{"constant":false,"inputs":[{"name":"id","type":"uint256"}],"name":"unregister","outputs":[]}];

// Example JS use:
var addrConfig = "0x661005d2720d855f1d9976f88bb10c1a3398c77f";
var addrNameReg;
web3.eth.contract(addrConfig, abiConfig).lookup(1).call().then(function(r){ addrNameReg = r; })

*/
