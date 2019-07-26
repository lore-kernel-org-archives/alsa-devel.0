From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 32/40] soundwire: intel: add helper for initialization
Date: Fri, 26 Jul 2019 12:42:38 +0200
Message-ID: <b0f7d11d-b9db-af98-3036-ef2a165f7427@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-33-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-33-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> Move code to helper for reuse in power management routines
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/intel.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index c40ab443e723..215dc81cdf73 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -984,6 +984,15 @@ static struct sdw_master_ops sdw_intel_ops = {
>   	.post_bank_switch = intel_post_bank_switch,
>   };
>   
> +static int intel_init(struct sdw_intel *sdw)
> +{
> +	/* Initialize shim and controller */
> +	intel_link_power_up(sdw);
> +	intel_shim_init(sdw);
> +
> +	return sdw_cdns_init(&sdw->cdns);
> +}

Why don't we check polling status for _link_power_up? I've already met 
slow starting devices in the past. If polling fails and -EAGAIN is 
returned, flow of initialization should react appropriately e.g. poll 
till MAX_TIMEOUT of some sort -or- collapse.
