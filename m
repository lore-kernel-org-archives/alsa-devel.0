From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-sai: don't set bclk for Tx/Rx
 Synchronous with another SAI mode
Date: Sat, 14 Nov 2015 19:12:17 -0800
Message-ID: <20151115031216.GA14878@Asurada-CZ80>
References: <b1cf60241eab0069250d00e47e80bb04ce676412.1447066811.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
 [209.85.213.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F2B260599
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 04:12:24 +0100 (CET)
Received: by igl9 with SMTP id 9so38579139igl.0
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 19:12:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b1cf60241eab0069250d00e47e80bb04ce676412.1447066811.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2015 at 07:02:29PM +0800, Zidan Wang wrote:
> In fsl_sai_set_bclk function, we should not set bclk for Tx/Rx Synchronous
> with another SAI mode.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index ffd5f9a..14c3078 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -354,13 +354,25 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
>  		return -EINVAL;
>  	}
>  
> -	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
> +	/*
> +	 * 1) For Asynchronous mode, we must set RCR2 register for capture, and
> +	 *    set TCR2 register for playback.
> +	 * 2) For Tx sync with Rx clock, we must set RCR2 register for playback
> +	 *    and capture.
> +	 * 3) For Rx sync with Tx clock, we must set TCR2 register for playback
> +	 *    and capture.
> +	 * 4) For Tx and Rx are both Synchronous with another SAI, we just
> +	 *    ignore it.
> +	 */
> +	if ((sai->synchronous[TX] && !sai->synchronous[RX]) ||
> +	    (!tx && !sai->synchronous[RX])) {
>  		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
>  				   FSL_SAI_CR2_MSEL_MASK,
>  				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
>  		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
>  				   FSL_SAI_CR2_DIV_MASK, savediv - 1);
> -	} else {
> +	} else if ((sai->synchronous[RX] && !sai->synchronous[TX]) ||
> +		   (tx && !sai->synchronous[TX])) {
>  		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
>  				   FSL_SAI_CR2_MSEL_MASK,
>  				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
> -- 
> 1.9.1
> 
