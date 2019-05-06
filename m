From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/7] soundwire: add Slave sysfs support
Date: Mon, 6 May 2019 09:42:35 -0500
Message-ID: <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4F29F89673
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:42:39 +0200 (CEST)
In-Reply-To: <20190504065444.GC9770@kroah.com>
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


>> +static struct attribute_group sdw_slave_dev_attr_group = {
>> +	.attrs	= slave_dev_attrs,
>> +};
>> +
>> +const struct attribute_group *sdw_slave_dev_attr_groups[] = {
>> +	&sdw_slave_dev_attr_group,
>> +	NULL
>> +};
> 
> ATTRIBUTE_GROUP()?

yes.

> 
> 
>> +
>> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
>> +{
>> +	struct sdw_slave_sysfs *sysfs;
>> +	unsigned int src_dpns, sink_dpns, i, j;
>> +	int err;
>> +
>> +	if (slave->sysfs) {
>> +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
>> +		err = -EIO;
>> +		goto err_ret;
>> +	}
>> +
>> +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> 
> Same question as patch 1, why a new device?

yes it's the same open. In this case, the slave devices are defined at a 
different level so it's also confusing to create a device to represent 
the slave properties. The code works but I am not sure the initial 
directions are correct.
