From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 08:43:26 -0500
Message-ID: <3a45625f-72a8-cb0c-1467-460000d1d8f7@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
 <20190725221554.GA16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FF6FF801A4
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 15:43:29 +0200 (CEST)
In-Reply-To: <20190725221554.GA16003@ubuntu>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/25/19 5:15 PM, Guennadi Liakhovetski wrote:
> Hi Pierre,
> 
> A couple of nitpicks:

Thanks for the feedback!

>>   create mode 100644 drivers/soundwire/debugfs.c
> 
> [snip]
> 
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 3048ca153f22..06ac4adb0074 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -18,6 +18,30 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>   			  u64 addr, struct sdw_slave_id *id);
>>   
>> +#ifdef CONFIG_DEBUG_FS
>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus);
>> +void sdw_bus_debugfs_exit(struct dentry *d);
>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave);
>> +void sdw_slave_debugfs_exit(struct dentry *d);
>> +void sdw_debugfs_init(void);
>> +void sdw_debugfs_exit(void);
>> +#else
>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
>> +{ return NULL; }
> 
> static?
> 
>> +
>> +void sdw_bus_debugfs_exit(struct dentry *d) {}
>> +
>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
>> +{ return NULL; }
>> +
>> +void sdw_slave_debugfs_exit(struct dentry *d) {}
>> +
>> +void sdw_debugfs_init(void) {}
>> +
>> +void sdw_debugfs_exit(void) {}
> 
> Same for all the above. You could also declare them inline, but I really hope
> the compiler will be smart enough to do that itself.

yes, I'll add static inline for all this.

>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
>> +{
>> +	struct dentry *d;
> 
> I would remove the above
> 
>> +	char name[16];
>> +
>> +	if (!sdw_debugfs_root)
>> +		return NULL;
>> +
>> +	/* create the debugfs master-N */
>> +	snprintf(name, sizeof(name), "master-%d", bus->link_id);
>> +	d = debugfs_create_dir(name, sdw_debugfs_root);
>> +
>> +	return d;
> 
> And just do
> 
> +	return debugfs_create_dir(name, sdw_debugfs_root);

yep, will do.

>> +static ssize_t sdw_sprintf(struct sdw_slave *slave,
>> +			   char *buf, size_t pos, unsigned int reg)
>> +{
>> +	int value;
>> +
>> +	value = sdw_read(slave, reg);
> 
> I personally would join the two lines above, but that's just a personal
> preference.

I prefer splitting variables and code, I just can't mentally split the two.

> 
>> +
>> +	if (value < 0)
>> +		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
>> +	else
> 
> I think it's advised to not use an else in such cases.
> 
> Thanks
> Guennadi
> 
>> +		return scnprintf(buf + pos, RD_BUF - pos,
>> +				"%3x\t%2x\n", reg, value);
>> +}

The intent was to provide a visual cue that the register is not 
implemented, which is quite useful. Not all registers are mandatory and 
not all vendors document the entire set of registers, so it's a good way 
to figure things out. The value is not used for any functional purpose, 
it's just a register dump for the integrator to look at. I'll add a note 
to explain the idea.
