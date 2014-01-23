From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-sai: convert to use regmap API for
 Freeacale SAI
Date: Thu, 23 Jan 2014 11:00:26 -0200
Message-ID: <CAOMZO5AMiQF=QgxuTvmOi49dC+er4L6a42F-daab3dEsQZB+yA@mail.gmail.com>
References: <1390463283-7545-1-git-send-email-Li.Xiubo@freescale.com>
	<CAOMZO5ATVkcORZBMbNzu2F-dyJxjzgjkRgezj2vGM9v7cyfy1w@mail.gmail.com>
	<b073a0513dd04d4b99177b2f2c3a8eb5@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b073a0513dd04d4b99177b2f2c3a8eb5@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 23, 2014 at 8:32 AM, Li.Xiubo@freescale.com
<Li.Xiubo@freescale.com> wrote:

> The clock operations in the driver is only related to the module clock, and has
> move to the regmap core and regmap core will to the same clock operations at
> proper time, since we are using:
>
> +       sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +                       "sai", base, &fsl_sai_regmap_config);

Ok, understood. I was not familiar with devm_regmap_init_mmio_clk()

Regards,

Fabio Estevam
