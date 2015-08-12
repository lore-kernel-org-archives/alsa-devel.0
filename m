From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix no frame clk in master
 mode
Date: Tue, 11 Aug 2015 20:53:25 -0700
Message-ID: <20150812035317.GA3194@Asurada-CZ80>
References: <2ec370890aca1bf5e8b796d7ebbfc95a0161980e.1439345935.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B6172605E8
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:53:30 +0200 (CEST)
Received: by pawu10 with SMTP id u10so5001077paw.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 20:53:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2ec370890aca1bf5e8b796d7ebbfc95a0161980e.1439345935.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2015 at 10:25:45AM +0800, Zidan Wang wrote:
> After several open/close sai test with ctrl+c, there will be I/O error.
> The SAI can't work anymore, can't recover. There will be no frame clock.
> With adding the software reset in trigger stop, the issue can be fixed.

It doesn't look like a decent fix to me. Is it the only fix that
IC team suggests? And why put this reset in the trigger function.
Your MEGA fast patch has already included a software reset in the
PM runtime functions. When dealing with CTRL+C test cases, that
software reset should have worked as well.

Nicolin

> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 5c737f1..6a947dc 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -504,6 +504,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
>  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> +
> +			/* Software Reset for both Tx and Rx */
> +			regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> +			regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
> +			/* Clear SR bit to finish the reset */
> +			regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
> +			regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
>  		}
>  		break;
>  	default:
> -- 
> 1.9.1
> 
