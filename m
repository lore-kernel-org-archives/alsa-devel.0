From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
Date: Fri, 26 Jul 2019 11:35:44 +0200
Message-ID: <9d5bc940-eadd-4f82-0bac-6a731369436d@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> +static void intel_debugfs_init(struct sdw_intel *sdw)
> +{
> +	struct dentry *root = sdw->cdns.bus.debugfs;
> +
> +	if (!root)
> +		return;
> +
> +	sdw->fs = debugfs_create_dir("intel-sdw", root);
> +	if (IS_ERR_OR_NULL(sdw->fs)) {
> +		dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
> +		sdw->fs = NULL;
> +		return;
> +	}
> +
> +	debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
> +			    &intel_reg_fops);
> +
> +	sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs);
> +}

I believe there should be dummy equivalent of _init and _exit if debugfs 
is not enabled (if these are defined already and I've missed it, please 
ignore).

> +static void intel_debugfs_exit(struct sdw_intel *sdw)
> +{
> +	debugfs_remove_recursive(sdw->fs);
> +}
