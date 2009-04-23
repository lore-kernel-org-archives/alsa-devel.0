From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 14:52:24 +0300
Message-ID: <200904231452.24916.peter.ujfalusi@nokia.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<200904231220.14465.peter.ujfalusi@nokia.com>
	<200904231204.05991.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D16103871
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 13:52:30 +0200 (CEST)
In-Reply-To: <200904231204.05991.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Alan Horstmann <gineera@aspect135.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 23 April 2009 14:04:05 ext Alan Horstmann wrote:
> On Thursday 23 April 2009 10:20, Peter Ujfalusi wrote:
> > On Wednesday 22 April 2009 20:58:01 ext twebb wrote:
> > > Problem 2:
> > > Test tone is being presented by the user application, providing a 1Khz
> > > tone sampled at 44.1Khz. The data are S16_LE, right channel only. Left
> > > channel is quiet. The data seems to slip back and forth from left to
> > > right channel. This is reproducable and verified with a scope trace.
> > >
> > > Anybody have any ideas what might be going wrong here?  Traces for
> > > codec reg dump and mcbsp are attached.
> >
> > As Jarkko already asked: are you seeing the channel switch while running
> > or is it happens on playback start?
> >
> > AFAIK this phenomena can be also seen on Beagle board.
> >
> > I have done some investigation regarding to these, but so far I can not
> > say that I know what causes it.
> >
> > BTW: these are separate issues (startup switch and runtime switch).
>
> I just want to declare an interest in this investigation.  Many months ba=
ck
> I was working on a SAM9260 board with wm8731 codec; the project is rather
> 'background' at present.  One of the outstanding unresolved (not really
> investigated much either) issues was of channel swapping at start of
> capture or playback.  It never changed during operation, but each start
> time the channels would be randomly correct or swapped.

So in case of OMAP35XX, when the switch happens?

I have a theory, which needs to be checked for the startup switch in OMAP:
I think what is happening, that the McBSP module got enabled earlier then t=
he =

DMA is started. This leads to and underrun situation in McBSP (no data in t=
he =

buffer), so McBSP will transmit _something_ when the start condition for th=
e =

I2S is met. When the DMA starting to push data to McBSP, than valid data wi=
ll =

be shifted out.
McBSP is shifting word by word manner. So if the first word transmit need t=
o =

be done, when the buffer is empty, it starts to shift the word, than the da=
ta =

arrives from the DMA,  the next word will be valid data -> you will have a =

nice channel switch.

Is this makes sense?

>
> Does this indicate that the implementation/drivers of i2s has a fundament=
al
> ambiguity?  Is it not rigidly defined which channel should follow a rising
> edge of L/R clock?
>
> Alan

-- =

P=E9ter
