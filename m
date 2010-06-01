From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 1 Jun 2010 15:07:31 +1000
Message-ID: <20100601050731.GB24820@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
	<20100601033023.GA24820@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 00747103935
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 07:07:38 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OJJhN-00079S-7L
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 15:07:33 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OJJhM-0001ta-R6
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 15:07:33 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OJJhM-0001tX-Ps
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 15:07:32 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OJJhM-00078g-BE
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 15:07:32 +1000
Content-Disposition: inline
In-Reply-To: <20100601033023.GA24820@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2010 at 01:30:27PM +1000, Stuart Longland wrote:
> Hi Eric,
> On Fri, May 28, 2010 at 07:55:19AM +0200, Eric B=E9nard wrote:
> > Hi Stuart,
> Well, over the last few days I've been looking closely at the signals
> generated.  Especially this morning... yesterday, I managed to get some
> sound out of the CODEC when operating in I=B2S master mode (yes, I have a
> patch that I need to clean up first).
> =

> What I observed is that despite being configured for I=B2S master, what I
> infact saw, was more like DSP mode, with a 1-bit frame sync pulse.  The
> remainder of my experimentation has been using the DSP modes of both MCU
> and CODEC.

Well, I managed to get the CODEC working as the I=B2S master, and managed
to get good quality audio.  The cause of my earlier DMA issues:  not
enabling DMA in the SSI device flags.  I guess I assumed this was the
default.

Now I just have to get the audio level up to something that's reasonable
for the application ... the volume knob is somewhere amongst these
registers, now I just have to find it and turn it up (and make it
accessible via ALSA).  I'll look at cleaning up this driver and
submitting it for further work.
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
