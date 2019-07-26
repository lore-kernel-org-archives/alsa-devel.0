From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 29/40] soundwire: intel_init: add kernel module
 parameter to filter out links
Date: Fri, 26 Jul 2019 12:30:20 +0200
Message-ID: <c1d859dc-3fd6-0be7-2240-c3b1f3240c0a@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-30-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-30-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> @@ -83,6 +87,9 @@ static struct sdw_intel_ctx
>   	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
>   	caps &= GENMASK(2, 0);
>   
> +	dev_dbg(&adev->dev, "SoundWire links: BIOS count %d hardware caps %d\n",
> +		count, caps);
> +
>   	/* Check HW supported vs property value and use min of two */
>   	count = min_t(u8, caps, count);
>   

This message does not look like it belongs to current patch - no 
link_mask dependency whatsoever. There have been couple "informative" 
patches in your series, maybe schedule it with them instead (as a 
separate series)?
