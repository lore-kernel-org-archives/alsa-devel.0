From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 1/8] ASoC: fsl: Add VF610 soc audio card Kconfig
Date: Mon, 10 Feb 2014 04:12:19 +0000
Message-ID: <d774da5b38ff47b6a350d92d1ffb362a@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-2-git-send-email-Li.Xiubo@freescale.com>
 <20140123183829.GB11727@sirena.org.uk>
 <88ad355def5f440eb92ca921b17aabb9@DM2PR03MB509.namprd03.prod.outlook.com>
 <20140126124313.GF11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140126124313.GF11727@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH 1/8] ASoC: fsl: Add VF610 soc audio card Kconfig
> 
> On Sun, Jan 26, 2014 at 05:15:05AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > > ...for simple card since the whole idea is to support any CODEC with the
> > > same driver we should probably just make sure that all the individual
> > > drivers can be enabled in Kconfig, that way we don't have to have
> > > specific Kconfig entries for boards and loose some of the benefit of the
> > > generic card.  I sent a patch earlier exposing the OF supporting CODEC
> > > drivers, one for at least some of the Freescale CPU drivers was sent to
> > > the list recently too but there were some review comments.
> 
> > I hadn't found the patches, could you tell me the titles of them please?
> 
> My patch was "ASoC: codecs: Make OF supported CODECs visible in
> Kconfig".  I can't remember offhand what the patch for i.MX was called.

Yes, found it.

If so, shouldn't the CPU DAIs(such as I2S) also be invisible in Kconfig like
CODECs ?


Thanks very much.
--
Best Regards,
Xiubo
