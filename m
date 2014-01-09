From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 3/4] ASoC: fsl: Add VF610 simple audio card widgets
 driver.
Date: Thu, 9 Jan 2014 07:43:42 +0000
Message-ID: <3ebbe152f0a94858a24a97f6251e5715@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
 <1389164556-2728-3-git-send-email-Li.Xiubo@freescale.com>
 <20140108180638.GS31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140108180638.GS31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > This is the SGTL5000 codec based off-CODEC widgets supports.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  sound/soc/fsl/Kconfig                     | 25 ++++++++++++++++++
> >  sound/soc/fsl/Makefile                    |  3 +++
> >  sound/soc/fsl/snd-soc-simple-card-vf610.c | 44
> +++++++++++++++++++++++++++++++
> 
> If we're needing to add explict code for a simple audio card that seems
> to defeat the point of using the simple audio card - we may as well just
> have an explicit machine driver.
>

IMHO, the simple audio card driver could fulfil most of machine driver's work. 
And will make some machine driver simpler and eaiser to code.

Thanks,

--
Best Regards,
Xiubo 
