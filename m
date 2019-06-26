From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Recover BXT FW on
 DSP boot timeout error
Date: Wed, 26 Jun 2019 20:13:04 +0200
Message-ID: <d9bd7dcb-4780-1f05-e536-32005f2b0ab6@intel.com>
References: <20190626093851.18474-1-pawel.harlozinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2C53F8071F
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 20:13:13 +0200 (CEST)
In-Reply-To: <20190626093851.18474-1-pawel.harlozinski@linux.intel.com>
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
To: pawel.harlozinski@linux.intel.com
Cc: szymonx.mielczarek@intel.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2019-06-26 11:38, Pawel Harlozinski wrote:
> When DSP boots with timeout error, reinitialize, transfer
> and boot firmware to recover audio.
> 

This is so called "recovery". Say "why" we do it, not just "what" the 
sequence is.

> Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index 440bca7afbf1..a2844bdca1b8 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -455,13 +455,18 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)

What about its neighbour, cnl_set_dsp_D0?

>   	/* If core 1 was turned on for booting core 0, turn it off */
>   		skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
>   		if (ret == 0) {
> -			dev_err(ctx->dev, "%s: DSP boot timeout\n", __func__);
> -			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
> +			dev_warn(ctx->dev,
> +				"DSP boot timeout: Error code=0x%x: FW status=0x%x\n",

Log change (--log_level) without mention in commit msg. Maybe split this 
into separate commit? The entire log-polish thingy could be a theme for 
a patchset as this is not the only place where such changes are welcome.

>   				sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
>   				sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
> -			dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
> -			ret = -EIO;
> -			goto err;
> +
> +			ret = bxt_sst_init_fw(skl->dev, skl);
> +			dev_warn(ctx->dev, "Reload fw status: %d\n", ret);
> +			if (ret < 0) {
> +				dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
> +				ret = -EIO;
> +				goto err;
> +			}

Double message is unnecessary, routine is verbose enough. Either leave 
"always report stuff" and resign from mentioning anything at all on 
failure -or- do it only on failure explicitly.

>   		}
>   	}
>   
> 
