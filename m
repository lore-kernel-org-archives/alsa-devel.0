From: Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 03 Apr 2017 10:19:48 +0200
Message-ID: <1491207588.1824.5.camel@toradex.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blaine.gmane.org (unknown [195.159.176.226])
 by alsa0.perex.cz (Postfix) with ESMTP id EF877266C3C
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 10:25:19 +0200 (CEST)
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1cuxIQ-0005wI-O5
 for alsa-devel@alsa-project.org; Mon, 03 Apr 2017 10:25:06 +0200
In-Reply-To: <1491058131-31366-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2017-04-01 at 11:48 -0300, Fabio Estevam wrote:
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
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Hi

I could reproduce the issue on a Colibri iMX6 Dual with a i.MX 6DualLite.
Without the patch I see channel swap in about 3% of playback starts.
The patch fixes the issue.

Tested-by: Max Krummenacher <max.krummenacher@toradex.com>

Max


> ---
> Changes since v1:
> - Do not impact  61fcf10a0ee44763e0 ("ASoC: fsl_ssi: Fix channel slipping in
> Playback at startup")
> 
>  sound/soc/fsl/fsl_ssi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 17f92b8..549b2a5 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -575,7 +575,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>  					"Timeout waiting TX FIFO filling\n");
>  			}
>  		}
> -		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> +		regmap_update_bits(regs, CCSR_SSI_SCR,
> +			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> +			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
>  	}
>  }
>  
