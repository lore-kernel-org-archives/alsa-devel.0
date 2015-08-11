From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl-sai: add 32 bit word length
 support
Date: Tue, 11 Aug 2015 00:02:32 -0700
Message-ID: <20150811070231.GA10536@Asurada>
References: <69f72120dad256225cbe771207e0f6b84a8f93df.1439262749.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 06E182604BD
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 09:02:41 +0200 (CEST)
Received: by pabyb7 with SMTP id yb7so123835543pab.0
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 00:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <69f72120dad256225cbe771207e0f6b84a8f93df.1439262749.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 11:14:26AM +0800, Zidan Wang wrote:
> Add 32 bit word length support. There are no code changes required
> in the SAI driver since it has already wirten the word width to the
> corresponding register.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 0662809..d137290 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -13,7 +13,8 @@
>  
>  #define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
>  			 SNDRV_PCM_FMTBIT_S20_3LE |\
> -			 SNDRV_PCM_FMTBIT_S24_LE)
> +			 SNDRV_PCM_FMTBIT_S24_LE |\
> +			 SNDRV_PCM_FMTBIT_S32_LE)
>  
>  /* SAI Register Map Register */
>  #define FSL_SAI_TCSR	0x00 /* SAI Transmit Control */
> -- 
> 1.9.1
> 
