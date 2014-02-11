From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/2] ASoC: fsl-esai: big-endian support
Date: Tue, 11 Feb 2014 07:27:19 +0000
Message-ID: <32151e3d675b44e4812fe852a66832a6@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
 <1392097276-14705-2-git-send-email-Li.Xiubo@freescale.com>
 <20140211071403.GB18803@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140211071403.GB18803@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> > +  - big-endian : If this property is absent, the native endian mode will
> > +    be in use as default, or the big endian mode will be in use for all the
> > +    device registers.
> 
> > +
> > +
> 
> Single blank line should be enough here :)
> 

This will be removed.


> > @@ -687,6 +688,10 @@ static int fsl_esai_probe(struct platform_device *pdev)
> >  	esai_priv->pdev = pdev;
> >  	strcpy(esai_priv->name, np->name);
> >
> > +	esai_priv->big_endian = of_property_read_bool(np, "big-endian");
> > +	if (esai_priv->big_endian)
> > +		fsl_esai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> > +
> 
> Same comments here. And please wait for Shawn's reply at the other patch
> before you revise this part to V2.
> 

Okey,


Thanks,

--
Best Regards,
Xiubo
