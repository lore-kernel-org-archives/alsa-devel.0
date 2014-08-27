From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Wed, 27 Aug 2014 07:10:35 +0000
Message-ID: <b4efadd81cae4b66ad484866bb56df40@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408950961-19177-1-git-send-email-Li.Xiubo@freescale.com>
 <20140826090426.GA31558@leverpostej>
 <cf0e029ae99d4b48a432e5c1669ddc15@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <CAGoOwPSTJaT0UA4yaYR0x49C8UHbmKAR8PzUfV9ZWVW5XBfV5w@mail.gmail.com>
 <20140827070544.GO17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140827070544.GO17528@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH] ASoC: fsl-sai: using 'lsb-first' property instead of
> 'big-endian-data'.
> 
> On Tue, Aug 26, 2014 at 11:53:56PM -0700, Nicolin Chen wrote:
> 
> > That's why I suggested previously: mention it in the commit comment.
> 
> > People will have no idea about what's the exact reason for this change.
> > Any functional enhancement? Or a bug fix(more likely for this one).
> > I'm not sure what I described in the previous mail is correct or not.
> > But you probably should have added it into the commit comments.
> 
> Right, this is a good idea - make sure people can understand what the
> goal of the change is.
> 

Okay, I will add this.

Thanks,

BRs
Xiubo
