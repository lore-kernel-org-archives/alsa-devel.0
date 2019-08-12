From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/3] soundwire: add debugfs support
Date: Mon, 12 Aug 2019 08:24:57 -0500
Message-ID: <89e456e7-35a6-c7e9-64bd-1b30f0f019cc@linux.intel.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
 <20190810070139.GA6896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810070139.GA6896@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>>   #Cadence Objs
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 49f64b2115b9..89d5f1537d9b 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>   		}
>>   	}
>>   
>> +	bus->debugfs = sdw_bus_debugfs_init(bus);
>> +
> 
> It's "nicer" to just put that assignment into sdw_bus_debugfs_init().
> 
> That way you just call the function, no need to return anything.

ok, thanks for the suggestion.

> 
>>   	/*
>>   	 * Device numbers in SoundWire are 0 through 15. Enumeration device
>>   	 * number (0), Broadcast device number (15), Group numbers (12 and
>> @@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>>   	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>   	struct sdw_bus *bus = slave->bus;
>>   
>> +	sdw_slave_debugfs_exit(slave->debugfs);
> 
> Same here, just pass in slave:
> 	sdw_slave_debugfs_exit(slave);
> and have that function remove the debugfs entry in the structure.  That
> way, if you are really paranoid about size, you could even drop the
> debugfs structure member from non-debugfs builds without any changes to
> bus.c or other non-debugfs files.

ok makes sense. will fix in v2.
