From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()
Date: Fri, 26 Apr 2019 08:19:14 +0300
Message-ID: <CAEnQRZCV7mnBmUFiC2pVz4ndo6a0L1eF8pAuiOO5OBTayXt=SA@mail.gmail.com>
References: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, sfr@canb.auug.org.au, Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2019 at 6:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Build warning being reported:
>     sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
>     sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
>     function returning non-void [-Wreturn-type]
>
> So this patch just adds a "return 0" to fix it.
>
> Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks Nicolin!

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 26c27dc..8593269 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  static int fsl_sai_remove(struct platform_device *pdev)
>  {
>         pm_runtime_disable(&pdev->dev);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id fsl_sai_ids[] = {
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
