From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF to be
 visible in Kconfig
Date: Thu, 20 Feb 2014 08:44:52 +0000
Message-ID: <5ca19952e55e4a719ecd7034ca595aba@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
 <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
 <36d9c0a870604fbe87b129e95fea9da1@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140220024432.GU2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140220024432.GU2669@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> Subject: Re: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF to be
> visible in Kconfig
> 
> On Thu, Feb 20, 2014 at 02:06:20AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > I'm not very sure of this patch, maybe should we add one menu
> > in Kconfig for all visible CPU DAIs firstly like for code drivers?
> 
> Allowing them to be individually selected is definitely useful if people
> are trying to minimise their kernel size and/or build time.  However
> none of the other Freescale people have commented on this patch (which
> I'd have expected) so I was giving them time and IIRC it needs a rebase
> against current code.

Yes, Surely.

As we can see that there will be many CPU DAI drivers to be visible in the
future, and they will get a bit noisy too. IMHO, put the CPU DAI drivers in
a menu is a good choice for other separate patches.

Thanks very much,

--
Best Regards,
Xiubo
