From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Force suspend/resume during
 system suspend/resume
Date: Tue, 27 Aug 2019 15:09:23 +0300
Message-ID: <CAEnQRZC9+ZiEUq-X34xv0L-QV4k1_XDbnBgdu8b8Kqo7wiT7CQ@mail.gmail.com>
References: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2019 at 1:15 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Use force_suspend/resume to make sure clocks are disabled/enabled
> accordingly during system suspend/resume.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/cs42xx8.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
> index 5b049fcdba20..94b1adb088fd 100644
> --- a/sound/soc/codecs/cs42xx8.c
> +++ b/sound/soc/codecs/cs42xx8.c
> @@ -684,6 +684,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
>  #endif
>
>  const struct dev_pm_ops cs42xx8_pm = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(cs42xx8_runtime_suspend, cs42xx8_runtime_resume, NULL)
>  };
>  EXPORT_SYMBOL_GPL(cs42xx8_pm);
> --
> 2.21.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
