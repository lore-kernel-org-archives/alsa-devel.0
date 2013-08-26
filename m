From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_spdif: Reduce the noise
	on comments
Date: Mon, 26 Aug 2013 14:07:29 +0800
Message-ID: <20130826060728.GB12524@MrMyself>
References: <1377292486-7591-1-git-send-email-festevam@gmail.com>
 <1377292486-7591-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 265702615B9
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 08:16:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1377292486-7591-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 23, 2013 at 06:14:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Remove the "====" pattern to let the comments cleaner and more uniform.
> 
> Also, do not use multi-line style for a single line comment. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Well, I just wanted to make it distinct.

But I'm fairly okay with this patch.

Thank you.

Acked-by: Nicolin Chen <b42378@freescale.com>

Best regards,
Nicolin Chen

> ---
> Changes since v1:
> - None
>  sound/soc/fsl/fsl_spdif.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index bf58086..34b531b 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -555,7 +555,6 @@ struct snd_soc_dai_ops fsl_spdif_dai_ops = {
>  
>  
>  /*
> - * ============================================
>   * FSL SPDIF IEC958 controller(mixer) functions
>   *
>   *	Channel status get/put control
> @@ -563,7 +562,6 @@ struct snd_soc_dai_ops fsl_spdif_dai_ops = {
>   *	Valid bit value get control
>   *	DPLL lock status get control
>   *	User bit sync mode selection control
> - * ============================================
>   */
>  
>  static int fsl_spdif_info(struct snd_kcontrol *kcontrol,
> @@ -942,11 +940,7 @@ static const struct snd_soc_component_driver fsl_spdif_component = {
>  	.name		= "fsl-spdif",
>  };
>  
> -/*
> - * ================
> - * FSL SPDIF REGMAP
> - * ================
> - */
> +/* FSL SPDIF REGMAP */
>  
>  static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
>  {
> -- 
> 1.8.1.2
> 
> 
