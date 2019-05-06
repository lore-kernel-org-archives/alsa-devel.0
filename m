From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Date: Mon, 6 May 2019 11:43:51 -0500
Message-ID: <b36e5b42-6069-0a73-8cab-7fcfc999f3a8@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504065242.GA9770@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the quick feedback Greg!

>> +static const struct attribute_group sdw_master_node_group = {
>> +	.attrs = master_node_attrs,
>> +};
>> +
>> +static const struct attribute_group *sdw_master_node_groups[] = {
>> +	&sdw_master_node_group,
>> +	NULL
>> +};
> 
> Minor nit, you can use the ATTRIBUTE_GROUPS() macro here to save you a
> few lines.

will do.

>> +
>> +static void sdw_device_release(struct device *dev)
>> +{
>> +	struct sdw_master_sysfs *master = to_sdw_device(dev);
>> +
>> +	kfree(master);
>> +}
>> +
>> +static struct device_type sdw_device_type = {
>> +	.name =	"sdw_device",
>> +	.release = sdw_device_release,
>> +};
>> +
>> +int sdw_sysfs_bus_init(struct sdw_bus *bus)
>> +{
>> +	struct sdw_master_sysfs *master;
>> +	int err;
>> +
>> +	if (bus->sysfs) {
>> +		dev_err(bus->dev, "SDW sysfs is already initialized\n");
>> +		return -EIO;
>> +	}
>> +
>> +	master = kzalloc(sizeof(*master), GFP_KERNEL);
>> +	if (!master)
>> +		return -ENOMEM;
> 
> Why are you creating a whole new device to put all of this under?  Is
> this needed?  What will the sysfs tree look like when you do this?  Why
> can't the "bus" device just get all of these attributes and no second
> device be created?

This is indeed my main question on this code (see cover letter) and why 
I tagged the series as RFC. I find it odd to create an int-sdw.0 
platform device to model the SoundWire master, and a sdw-master:0 device 
whose purpose is only to expose the properties of that master. it'd be 
simpler if all the properties were exposed one level up.

Vinod and Sanyog might be able to shed some light on this?
