From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 03/40] soundwire: cadence_master: align debugfs to 8
 digits
Date: Fri, 2 Aug 2019 17:20:13 +0530
Message-ID: <20190802115013.GG12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> SQUASHME

Git trick!

commit this using:
git fixup <sha1>

where sha1 is commit where you want this to be squashed into!

then below will suuash them for you!
 
git rebase -i --autosquash 



> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 91e8bacb83e3..9f611a1fff0a 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -234,7 +234,7 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>  			    char *buf, size_t pos, unsigned int reg)
>  {
>  	return scnprintf(buf + pos, RD_BUF - pos,
> -			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
> +			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>  }
>  
>  static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
> -- 
> 2.20.1

-- 
~Vinod
