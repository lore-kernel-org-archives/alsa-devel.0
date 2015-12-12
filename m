From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: fix no frame clk in
 master mode
Date: Fri, 11 Dec 2015 20:47:36 -0800
Message-ID: <20151212044735.GA3564@Asurada-CZ80>
References: <af420592483389f5420c573b2b23f187a32baea3.1449717000.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 9015826549F
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 05:47:59 +0100 (CET)
Received: by pfnn128 with SMTP id n128so76210756pfn.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:47:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <af420592483389f5420c573b2b23f187a32baea3.1449717000.git.zidan.wang@freescale.com>
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

On Thu, Dec 10, 2015 at 11:21:25AM +0800, Zidan Wang wrote:

> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 8832901..a55a7de 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -564,6 +564,17 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
>  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> +
> +			if (!sai->is_slave_mode) {

It'd be nicer to add a simple comment to describe the errata here.
Users may have no idea about this abrupt reset as we do.

You may add my ack to your next version:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> +				/* Software Reset for both Tx and Rx */
> +				regmap_write(sai->regmap,
> +					     FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> +				regmap_write(sai->regmap,
> +					     FSL_SAI_RCSR, FSL_SAI_CSR_SR);
> +				/* Clear SR bit to finish the reset */
> +				regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
> +				regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> +			}
