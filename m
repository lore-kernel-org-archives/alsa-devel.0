From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity
	configurations
Date: Fri, 4 Apr 2014 07:37:00 +0000
Message-ID: <9cb53ac6e0e04c01bc0c6ae6a4d42557@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 708E5265582
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 09:37:04 +0200 (CEST)
In-Reply-To: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "timur@tabi.org" <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org


> Subject: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
> 
> The BCP bit in TCR4/RCR4 register rules as followings:
>   0 Bit clock is active high with drive outputs on rising edge
>     and sample inputs on falling edge.
>   1 Bit clock is active low with drive outputs on falling edge
>     and sample inputs on rising edge.
> 
> For all formats currently supported in the fsl_sai driver, they're exactly
> sending data on the falling edge and sampling on the rising edge.
> 
> However, the driver clears this BCP bit for all of them which results click
> noise when working with SGTL5000 and big noise with WM8962.
> 
> Thus this patch corrects the BCP settings for all the formats here to fix
> the nosie issue.
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---

Good catch.

Acked-by: Xiubo Li <Li.Xiubo@freescale.com>

Thanks,
--

BRs,
Xiubo


>  sound/soc/fsl/fsl_sai.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 99051c7..9bbebea 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -180,7 +180,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * that is, together with the last bit of the previous
>  		 * data word.
>  		 */
> -		val_cr2 &= ~FSL_SAI_CR2_BCP;
> +		val_cr2 |= FSL_SAI_CR2_BCP;
>  		val_cr4 |= FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP;
>  		break;
>  	case SND_SOC_DAIFMT_LEFT_J:
> @@ -188,7 +188,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * Frame high, one word length for frame sync,
>  		 * frame sync asserts with the first bit of the frame.
>  		 */
> -		val_cr2 &= ~FSL_SAI_CR2_BCP;
> +		val_cr2 |= FSL_SAI_CR2_BCP;
>  		val_cr4 &= ~(FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP);
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
> @@ -198,7 +198,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * that is, together with the last bit of the previous
>  		 * data word.
>  		 */
> -		val_cr2 &= ~FSL_SAI_CR2_BCP;
> +		val_cr2 |= FSL_SAI_CR2_BCP;
>  		val_cr4 &= ~FSL_SAI_CR4_FSP;
>  		val_cr4 |= FSL_SAI_CR4_FSE;
>  		sai->is_dsp_mode = true;
> @@ -208,7 +208,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * Frame high, one bit for frame sync,
>  		 * frame sync asserts with the first bit of the frame.
>  		 */
> -		val_cr2 &= ~FSL_SAI_CR2_BCP;
> +		val_cr2 |= FSL_SAI_CR2_BCP;
>  		val_cr4 &= ~(FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP);
>  		sai->is_dsp_mode = true;
>  		break;
> --
> 1.8.4
> 
