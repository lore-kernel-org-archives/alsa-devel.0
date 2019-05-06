From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 7/7] soundwire: intel: add debugfs
 register dump
Date: Mon, 6 May 2019 09:51:36 -0500
Message-ID: <b01b3d30-901a-f5dc-8526-32a6dad9afd0@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-8-pierre-louis.bossart@linux.intel.com>
 <20190504070458.GG9770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504070458.GG9770@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static void intel_debugfs_init(struct sdw_intel *sdw)
>> +{
>> +	struct dentry *root = sdw_bus_debugfs_get_root(sdw->cdns.bus.debugfs);
>> +
>> +	if (!root)
>> +		return;
>> +
>> +	sdw->fs = debugfs_create_dir("intel-sdw", root);
>> +	if (IS_ERR_OR_NULL(sdw->fs)) {
> 
> Again, you do not care, do not check this.

yes will check all this.
Thanks for all the comments, much appreciated.
