From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Correct FSL_SAI_CR2_MSEL_MASK
	definition
Date: Wed, 3 Jun 2015 11:47:15 -0700
Message-ID: <20150603184714.GA8196@Asurada>
References: <1433335861-31474-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id CF463260703
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 20:47:24 +0200 (CEST)
Received: by qkx62 with SMTP id 62so10912557qkx.3
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2015 11:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433335861-31474-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

Hello Iwai-san,

On Wed, Jun 03, 2015 at 02:51:01PM +0200, Takashi Iwai wrote:
> The bit mask FSL_SAI_CR2_MSEL_MASK is defined as (0xff << 26) and this
> obviously overflows the 32bit integer.  Also this clears other bits
> than the needed ones (FSL_SAI_CR2_MSEL_XXX) wrongly.
> 
> This patch fixes the definition only to mask bits 26 and 27.

An identical fix was included in the Commit c3ecef21c3f26bf47
(ASoC: fsl_sai: add sai master mode support) by Zidan Wang.
And it's already in the linux-next tree.

Thank you
Nicolin

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=84351
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/fsl/fsl_sai.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 34667209b607..0e33a17ddd01 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -72,7 +72,7 @@
>  
>  /* SAI Transmit and Recieve Configuration 2 Register */
>  #define FSL_SAI_CR2_SYNC	BIT(30)
> -#define FSL_SAI_CR2_MSEL_MASK	(0xff << 26)
> +#define FSL_SAI_CR2_MSEL_MASK	(0x03 << 26)
>  #define FSL_SAI_CR2_MSEL_BUS	0
>  #define FSL_SAI_CR2_MSEL_MCLK1	BIT(26)
>  #define FSL_SAI_CR2_MSEL_MCLK2	BIT(27)
> -- 
> 2.4.2
> 
