From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 26 Mar 2010 12:26:29 +0800
Message-ID: <4f3252891003252126y4f76d650m6adf85362cbf274@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id D4DD82440E
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 05:26:31 +0100 (CET)
Received: by pwj7 with SMTP id 7so5652252pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 21:26:29 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/2/17 Jaroslav Kysela <perex@perex.cz>

> On Tue, 16 Feb 2010, Lennart Poettering wrote:
>
> > On Tue, 16.02.10 14:40, Mark Brown (broonie@opensource.wolfsonmicro.com)
> wrote:
> >
> >>
> >> On Tue, Feb 16, 2010 at 03:32:01PM +0100, Lennart Poettering wrote:
> >>> On Tue, 16.02.10 09:24, Jaroslav Kysela (perex@perex.cz) wrote:
> >>
> >>>> Line: 0dB..47.81dB         # seems correct -47.81dB..0dB
> >>>> Line Capture: -0.18dB..23.81dB     # seems correct
> >>>> -17.81dB..6.18dB
> >>
> >>> Hmm, how did you choose where to put 0dB?
> >>
> >> The Line one looks like someone got attenuation and gain confused, which
> >> is a fairly common mistake for people to make when copying information
> >> from one place to another.  Possibly a similar thing going on with the
> >> Line Capture control, plus a fixed 6dB gain (which may well be a
> >> separate amp...).
> >
> > I remember that a while back we had a discussion on alsa-devel
> > regarding the fact that ALSA does not define relative to what the dB
> > values reported by the mixer elements actually are measured. Some
> > mixer controls export dB values relative to max amplification (e.g. my
> > integrated USB speakers here), others relative to the output of some
> > other mixer element, and others relative to different standard or
> > not-so-standard output voltages.  And there is no API to figure out
> > what the base is.
> >
> > Now, what Jaroslav listed above suggests that he chose carefully where
> > he put 0dB. I was just wondering about that. Jaroslav, how did you
> > choose where to put 0dB?
>
> Basically, if I remember correctly the discussion, 0dB on all elements
> should main unchanged volume, <0dB attenuation and >0dB gain. We cannot
> measure precisely other components on path like analog volume wheels
> (like SB MP3+ has to change line-out volume), analog amplifiers and other
> analog signal modificators.
>
> So, if you use one headphones and speakers with defined and fixed volume
> settings, you can measure differences for the card with broken dB volume
> ranges. I just used another HDA card in notebook with 0dB settings on all
> playback controls on path, captured stream from this card on my USB card
> and played this stream back on my USB card watching and relating the
> volume levels according dB values. It's not 100% correct, but at least
> it's something to start with.
>
>                                        Jaroslav
>  <Alsa-devel@alsa-project.org>
>

Refer  to  http://thread.gmane.org/gmane.linux.alsa.devel/15859

Try to lower "Wave" volume - otherways there will be clipping on bass.

When you set "PCM" to 75 % this is 0 db.

The dB scale of alsa  driver was implemented because of 0dB is not at the
maximum for emu10k1
