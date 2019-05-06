From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 6/7] soundwire: cadence_master: add
 debugfs register dump
Date: Mon, 6 May 2019 09:50:26 -0500
Message-ID: <dbcb67d0-aec3-cae7-c908-81a2e40efbb5@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-7-pierre-louis.bossart@linux.intel.com>
 <20190504070346.GE9770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504070346.GE9770@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>> +{
>> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
>> +}
>> +EXPORT_SYMBOL(sdw_cdns_debugfs_init);
> 
> Don't wrap debugfs calls with export symbol without using
> EXPORT_SYMBOL_GPL() or you will get grumpy emails from me :)

Yes, that's a miss. I've already seen this comment and fixed it for SOF, 
I should have thought about it for SoundWire, my bad.
