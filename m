From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 13:32:42 -0700
Message-ID: <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 69E40266972
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 22:33:03 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id z204so19958494vkd.2
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 13:33:03 -0700 (PDT)
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
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, max.krummenacher@toradex.com, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 1, 2017 at 7:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
>
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
>                                         "Timeout waiting TX FIFO filling\n");
>                         }
>                 }
> -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> +               regmap_update_bits(regs, CCSR_SSI_SCR,
> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
>         }
>  }
>
> --
> 2.7.4
>

This patch definitely breaks the i.mx6 channel alignment.  In fact it
breaks it so that the channels are never aligned properly.

My test setup is as follows:
* Get vanilla kernel, tag v4.11-rc5
* apply a couple patches to allow AUD4 on the wandboard external
connectors (and disable internal audio)
* Test results:  v4.11-rc5 works flawlessly using Arnaud's atest
program.  No channel slips, no issues at all.
* Apply this patch, recompile, build.
* Channel alignment fails.  The channels never get aligned properly.

Am I right that the *only* change is this one-liner, and ignore the
previous non V2 version of this patch?
> -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> +               regmap_update_bits(regs, CCSR_SSI_SCR,
> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);

See you,

-Caleb
