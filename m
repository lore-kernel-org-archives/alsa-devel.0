From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix wrong mask in some
 snd_soc_update_bits calls
Date: Fri, 21 Oct 2011 07:36:11 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722AE773@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1319162083.4352.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id C635D103A69
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 09:36:21 +0200 (CEST)
In-Reply-To: <1319162083.4352.2.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Axel Lin
> Sent: Friday, October 21, 2011 9:55 AM
> To: linux-kernel@vger.kernel.org
> Cc: Dong Aisheng-B29396; Wolfram Sang; Liam Girdwood; Mark Brown; alsa-
> devel@alsa-project.org
> Subject: [PATCH] ASoC: sgtl5000: Fix wrong mask in some
> snd_soc_update_bits calls
> 
> Ensure all mask bits are clear before setting new value.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I don't have this hardware, I'd appreciate if someone can test this patch.
> 
> Thanks,
> Axel
>  sound/soc/codecs/sgtl5000.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

It runs ok at my side.
Acked-by: Dong Aisheng <b29396@freescale.com>

> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 32b5bbd..d15695d 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -723,7 +723,9 @@ static int sgtl5000_pcm_hw_params(struct
> snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
> 
> -	snd_soc_update_bits(codec, SGTL5000_CHIP_I2S_CTRL, i2s_ctl,
> i2s_ctl);
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_I2S_CTRL,
> +			    SGTL5000_I2S_DLEN_MASK | SGTL5000_I2S_SCLKFREQ_MASK,
> +			    i2s_ctl);
> 
>  	return 0;
>  }
> @@ -1146,8 +1148,7 @@ static int sgtl5000_set_power_regs(struct
> snd_soc_codec *codec)
>  		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
> 
>  	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
> -			vag << SGTL5000_ANA_GND_SHIFT,
> -			vag << SGTL5000_ANA_GND_SHIFT);
> +			SGTL5000_ANA_GND_MASK, vag << SGTL5000_ANA_GND_SHIFT);
> 
>  	/* set line out VAG to vddio / 2, in range (0.8v, 1.675v) */
>  	vag = vddio / 2;
> @@ -1161,9 +1162,8 @@ static int sgtl5000_set_power_regs(struct
> snd_soc_codec *codec)
>  		    SGTL5000_LINE_OUT_GND_STP;
> 
>  	snd_soc_update_bits(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
> -			vag << SGTL5000_LINE_OUT_GND_SHIFT |
> -			SGTL5000_LINE_OUT_CURRENT_360u <<
> -				SGTL5000_LINE_OUT_CURRENT_SHIFT,
> +			SGTL5000_LINE_OUT_CURRENT_MASK |
> +			SGTL5000_LINE_OUT_GND_MASK,
>  			vag << SGTL5000_LINE_OUT_GND_SHIFT |
>  			SGTL5000_LINE_OUT_CURRENT_360u <<
>  				SGTL5000_LINE_OUT_CURRENT_SHIFT);
> --
> 1.7.5.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
