From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 1/2] ASoC: fsl-spdif: big-endian support
Date: Tue, 11 Feb 2014 07:25:25 +0000
Message-ID: <3a4d25c844a94dd4a7483fc426d28ec4@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
 <20140211071034.GA18803@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140211071034.GA18803@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> > +	spdif_priv->big_endian = of_property_read_bool(np, "big-endian");
> > +	if (spdif_priv->big_endian)
> > +		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> 
> Why not just:
> 	if (of_property_read_bool(np, "big-endian"))
> 		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
>

I just think maybe other places of the driver maybe use this.
Yes, it could be removed just for now.

See the next version please.

Thanks very much,

--
Best Regards,
Xiubo
