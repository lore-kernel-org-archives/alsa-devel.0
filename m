From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Wed, 27 Aug 2014 07:02:43 +0000
Message-ID: <cd9a50c81d3a402594a30cdd39220614@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408950961-19177-1-git-send-email-Li.Xiubo@freescale.com>
	<20140826090426.GA31558@leverpostej>
	<cf0e029ae99d4b48a432e5c1669ddc15@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <CAGoOwPSTJaT0UA4yaYR0x49C8UHbmKAR8PzUfV9ZWVW5XBfV5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGoOwPSTJaT0UA4yaYR0x49C8UHbmKAR8PzUfV9ZWVW5XBfV5w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH] ASoC: fsl-sai: using 'lsb-first' property instead of
> 'big-endian-data'.
> 
> On Tue, Aug 26, 2014 at 7:12 PM, Li.Xiubo@freescale.com
> <Li.Xiubo@freescale.com> wrote:
> > > > This property used for configuring whether the LSB or the MSB is
> transmitted
> > > > first for the fifo data.
> > >
> > > I don't follow the rationale for this change.
> > >
> > > This looks like a pointless renaming.
> > >
> > > Why is this any better?
> > >
> >
> > This is originally to indicate whether the LSB firstly or MSB firstly will
> be
> > transmitted to the CODEC or received from the CODEC, and there has nothing
> > Relation to the memory data.
> >
> > Generally, if the audio data in big endian format, which will be using the
> bytes
> > Reversion ? Here this can only be used to bits reversion.
> 
> That's why I suggested previously: mention it in the commit comment.
> 
> People will have no idea about what's the exact reason for this change.
> Any functional enhancement? Or a bug fix(more likely for this one).
> I'm not sure what I described in the previous mail is correct or not.
> But you probably should have added it into the commit comments.
> 
> And Xiubo, this patch still hasn't fixed the issue of breaking the old DT,
> although system can pass during the probe() section.
> 

Beside LS1+, who else is using this now ? And the LS1 dts files are still doing
The upstream for now.

Thanks,

BRs
Xiubo
