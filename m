From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_audmix: remove "model" attribute
Date: Tue, 9 Apr 2019 13:05:31 +0300
Message-ID: <CAEnQRZB8ub6tyuputU51Ev9d6USg4idcXW6P6tkfuhHECAuGUA@mail.gmail.com>
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com> <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.inf>
List-Id: alsa-devel@alsa-project.org

Hi Viorel,

Few comments inline.

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Use "of_device_id.data" to specify the machine driver,
> instead of "model" DTS attribute.

<snip>

>  static int fsl_audmix_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;

You might want to remove this change from the patch because it touches
a lot of lines
and it makes the review harder.

I don't see any reason to have it at all.

thanks,
Daniel.
