From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Date: Mon, 6 May 2019 21:24:17 -0500
Message-ID: <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
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

I tried a quick hack and indeed we could simplify the code with 
something as simple as:

[attributes omitted]

static const struct attribute_group sdw_master_node_group = {
	.attrs = master_node_attrs,
	.name = "mipi-disco"
};

int sdw_sysfs_bus_init(struct sdw_bus *bus)
{
	return sysfs_create_group(&bus->dev->kobj, &sdw_master_node_group);
}

void sdw_sysfs_bus_exit(struct sdw_bus *bus)
{
	sysfs_remove_group(&bus->dev->kobj, &sdw_master_node_group);	
}

which gives me a simpler structure and doesn't require additional 
pretend-devices:

/sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# ls
clock_gears
/sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# more clock_gears
8086

The issue I have is that for the _show() functions, I don't see a way to 
go from the device argument to bus. In the example above I forced the 
output but would need a helper.

static ssize_t clock_gears_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	struct sdw_bus *bus; // this is what I need to find from dev
	ssize_t size = 0;
	int i;

	return sprintf(buf, "%d \n", 8086);
}

my brain is starting to fry, but I don't see how container_of() would 
work here since the bus structure contains a pointer to the device. I 
don't also see a way to check for all devices for the bus_type soundwire.
For the slaves we do have a macro based on container_of(), so wondering 
if we made a mistake in the bus definition? Vinod, any thoughts?
