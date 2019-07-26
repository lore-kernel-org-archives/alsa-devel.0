From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
Date: Fri, 26 Jul 2019 10:34:38 -0500
Message-ID: <0dc45659-33cd-0dfb-946b-9303fe54ec1c@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <20190726140635.GB8767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726140635.GB8767@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static const struct file_operations intel_reg_fops = {
>> +	.open = simple_open,
>> +	.read = intel_reg_read,
>> +	.llseek = default_llseek,
>> +};
> 
> DEFINE_SIMPLE_ATTRIBUTE()?

yes

> 
>> +
>> +static void intel_debugfs_init(struct sdw_intel *sdw)
>> +{
>> +	struct dentry *root = sdw->cdns.bus.debugfs;
>> +
>> +	if (!root)
>> +		return;
>> +
>> +	sdw->fs = debugfs_create_dir("intel-sdw", root);
>> +	if (IS_ERR_OR_NULL(sdw->fs)) {
>> +		dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
> 
> No, come on, don't do that.  I've been sweeping the kernel tree to
> remove this anti-pattern.
> 
> The debugfs core will print an error if you got something wrong, just
> call the function and move on, you NEVER need to check the return value
> of a debugfs call.

Yes, sorry to make your blood pressure go up... I missed this one in the 
cleanups yesterday. will fix.
