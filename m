From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 04:18:27 +0000
Message-ID: <d77b7d1800884badbdb50564b8460267@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327023617.GB16197@MrMyself>
 <1e2d210764724c7e834c5307b54c37ab@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327025647.GC16197@MrMyself>
 <12f887b3889a41849026965f0cf7db1f@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327033117.GD16197@MrMyself>
 <62630844c7434df6937ca25d3f47b656@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327035726.GA16359@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140327035726.GA16359@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > So let's just ignore the clearance of these bits in isr().
> >
> > +++++
> > SAI Transmit Control Register (I2S1_TCSR) : 32 : R/W : 0000_0000h
> 
> I'm talking about FWF and FRF bits, not TCSR as a register.
> 
> > -----
> >
> > I have checked in the Vybrid and LS1 SoC datasheets, and they are all the
> > Same as above, and nothing else.
> >
> > Have I missed ?
> 
> What i.MX IC team told me is SAI ignores what we do to FWF and FRF, so you
> don't need to worry about it at all unless Vybrid makes them writable, in
> which case we may also need to clear these bits and confirm with Vybrid IC
> team if they're also W1C.
> 

Well, if so, that's fine.

Thanks,
