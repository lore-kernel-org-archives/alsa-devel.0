From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 5/7] soundwire: add debugfs support
Date: Mon, 6 May 2019 09:48:30 -0500
Message-ID: <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A91DF80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:48:34 +0200 (CEST)
In-Reply-To: <20190504070301.GD9770@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> @@ -136,6 +139,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>>   void sdw_delete_bus_master(struct sdw_bus *bus)
>>   {
>>   	sdw_sysfs_bus_exit(bus);
>> +	if (bus->debugfs)
>> +		sdw_bus_debugfs_exit(bus->debugfs);
> 
> No need to check, just call it.

That was on my todo list, will remove.


>> +struct sdw_bus_debugfs {
>> +	struct sdw_bus *bus;
> 
> Why do you need to save this pointer?
> 
>> +	struct dentry *fs;
> 
> This really is all you need to have around, right?

will check.

>> +struct dentry *sdw_bus_debugfs_get_root(struct sdw_bus_debugfs *d)
>> +{
>> +	if (d)
>> +		return d->fs;
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(sdw_bus_debugfs_get_root);
> 
> _GPL()?

Oops, that's a big miss. will fix, thanks for spotting this.

> 
> But why is this exported at all?  No one calls this function.

I will have to check.

> 
>> +struct sdw_slave_debugfs {
>> +	struct sdw_slave *slave;
> 
> Same question as above, why do you need this pointer?

will check.

> 
> And meta-comment, if you _EVER_ save off a pointer to a reference
> counted object (like this and the above one), you HAVE to grab a
> reference to it, otherwise it can go away at any point in time as that
> is the point of reference counted objects.
> 
> So even if you do need/want this, you have to properly handle the
> reference count by incrementing/decrementing it as needed.

good comment, thank you for the guidance.

>> +struct sdw_slave_debugfs *sdw_slave_debugfs_init(struct sdw_slave *slave)
>> +{
>> +	struct sdw_bus_debugfs *master;
>> +	struct sdw_slave_debugfs *d;
>> +	char name[32];
>> +
>> +	master = slave->bus->debugfs;
>> +	if (!master)
>> +		return NULL;
>> +
>> +	d = kzalloc(sizeof(*d), GFP_KERNEL);
>> +	if (!d)
>> +		return NULL;
>> +
>> +	/* create the debugfs slave-name */
>> +	snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
>> +	d->fs = debugfs_create_dir(name, master->fs);
>> +	if (IS_ERR_OR_NULL(d->fs)) {
>> +		dev_err(&slave->dev, "slave debugfs root creation failed\n");
>> +		goto err;
>> +	}
> 
> You never care about the return value of a debugfs call.  I have a 100+
> patch series stripping all of this out of the kernel, please don't force
> me to add another one to it :)
> 
> Just call debugfs and move on, you can always put the return value of
> one call into another one just fine, and your function logic should
> never change if debugfs returns an error or not, you do not care.

Yes, it's agreed that we should not depend on debugfs or fail here. will 
fix, no worries.

>
>> +void sdw_debugfs_init(void)
>> +{
>> +	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
>> +	if (IS_ERR_OR_NULL(sdw_debugfs_root)) {
>> +		pr_warn("SoundWire: Failed to create debugfs directory\n");
>> +		sdw_debugfs_root = NULL;
>> +		return;
> 
> Same here, just call the function and return.

yep, will do.
