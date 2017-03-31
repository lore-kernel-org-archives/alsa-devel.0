From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Fri, 31 Mar 2017 16:53:30 -0700
Message-ID: <20170331235329.GA7627@Asurada-Nvidia>
References: <1490998503-1191-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AFEB2668F6
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 01:53:32 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id o123so20439621pga.1
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 16:53:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490998503-1191-1-git-send-email-festevam@gmail.com>
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
Cc: alsa-devel@alsa-project.org, arnaud.mouiche@invoxia.com, timur@tabi.org, caleb@crome.org, Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org, max.krummenacher@toradex.com, mpa@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 31, 2017 at 07:15:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit f8fdf5375e2005f2 ("ASoC: fsl-ssi: add SSIEN errata work around")
> implemented  the workaround for the following erratum found on i.MX35
> errata document:
> 
> ENGcm06222: SSI:Transmission does not take place in bit length early
> frame sync configuration
> 
> and also for ENGcm06222 from the same document.
> 
> However it has been only applied for AC97 mode. Apply it to I2S mode
> as well so that it can fix audio channel swap during playback start.
> 
> The channel swap can be noticed in about 10% of the times an audio track
> starts.
> 
> With the recommended workaround in place no more channel swap
> happened after running audio start/stop sequence in more than
> 2000 times.
> 
> Tested on a mx6dl-wandboard.

Hmm..so this bug also exists for imx6? I googled it and found that
only imx25 and imx35 ring the bell. I forgot if they keep the same
version for imx6 though.

> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index fde08660..17f92b8 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -93,6 +93,9 @@
>  		CCSR_SSI_SIER_TLS_EN | CCSR_SSI_SIER_TFS_EN | \
>  		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TFRC_EN)
>  
> +#define FSLSSI_SSIEN_WORKAROUND (CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | \
> +				 CCSR_SSI_SCR_RE)

Enable RE??

>  enum fsl_ssi_type {
>  	FSL_SSI_MCP8610,
>  	FSL_SSI_MX21,
> @@ -559,7 +562,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>  			int i;
>  			int max_loop = 100;
>  			regmap_update_bits(regs, CCSR_SSI_SCR,
> -					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
> +					   FSLSSI_SSIEN_WORKAROUND,
> +					   FSLSSI_SSIEN_WORKAROUND);
>  			for (i = 0; i < max_loop; i++) {
>  				u32 sfcsr;
>  				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);

If this change is made, the whole "if (enable)" part here seems
to be meaningless (or even worse) as it aimed to set TE later
than SSIEN so as to offset the delay from DMA TX.

Check: https://patchwork.kernel.org/patch/9091051/

If this errata is mandatory, we probably should revert that the
commit and find other solution/workaround for Arnaud and Caleb.
