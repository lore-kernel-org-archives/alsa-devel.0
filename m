From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 02/40] soundwire: cadence_master: add debugfs register
 dump
Date: Fri, 26 Jul 2019 10:32:13 -0500
Message-ID: <abf3b09a-113a-990e-6cf8-b269e2067990@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
 <20190726140922.GD8767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726140922.GD8767@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static const struct file_operations cdns_reg_fops = {
>> +	.open = simple_open,
>> +	.read = cdns_reg_read,
>> +	.llseek = default_llseek,
>> +};
> 
> DEFINE_SHOW_ATTRIBUTE()?

I remember looking at this but can't recall why I left it this way.
That was before my Summer break so will relook, thanks for suggesting this.
