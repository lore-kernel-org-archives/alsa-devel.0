From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AK4458: add regulator for ak4458
Date: Thu, 16 May 2019 10:14:42 -0300
Message-ID: <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 16, 2019 at 10:02 AM Viorel Suman <viorel.suman@nxp.com> wrote:

> +       for (i = 0; i < ARRAY_SIZE(ak4458->supplies); i++)
> +               ak4458->supplies[i].supply = ak4458_supply_names[i];
> +
> +       ret = devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies),
> +                                     ak4458->supplies);
> +       if (ret != 0) {
> +               dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
> +               return ret;

This would break existing users that do not pass the regulators in device tree.

Ok, in this case there is no ak4458 user in any dts, so that would not
be an issue.

Please update the dt-bindings with the regulator entries.
