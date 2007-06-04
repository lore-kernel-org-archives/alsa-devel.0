From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Mon, 4 Jun 2007 12:53:06 +0100
Message-ID: <200706041253.06880.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<200706032055.27495.gineera@aspect135.co.uk>
	<s5htztoayrw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id A696D24556
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 13:43:00 +0200 (CEST)
In-Reply-To: <s5htztoayrw.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 04 June 2007 09:50, you wrote:
> At Sun, 3 Jun 2007 20:55:27 +0100,
>
> Alan Horstmann wrote:
> > On Friday 01 June 2007 10:56, you wrote:
> > > At Thu, 31 May 2007 22:00:25 +0100,
> > >
> > > Alan Horstmann wrote:
> > > > On Wednesday 30 May 2007 07:47, you wrote:
> > > > > Alan Horstmann wrote:
> >
> > << Edited snippets >>
> >
> > > > > fd_playback = open("/dev/dsp", O_WRONLY);
> > > > > fd_capture = open("/dev/dsp", O_RDONLY);
> > > > >
> > > > > > > - change portaudio to open each direction separately, O_RDONLY
> > > > > > > and O_WRONLY at first, then use O_RDWR as fallback
> > > > >
> > > > > This would be the preferred way.  After all, this is the only way
> > > > > that is possible with the existing OSS API when you want to use
> > > > > different sample formats, and it is recommended in all cases (see
> > > > > <http://manuals.opensound.com/developer/full_duplex.html>).
> > > >
> > > > My reading of the 4Front info is different.  I read that they
> > > > recommend best opening SEPARATE devices, one O_RDONLY and the other
> > > > O_WRONLY, in their scheme called 'twodevice'.  It also states in
> > > > fulldup.c:-
> > > >
> > > > "... The one device full duplex scheme requires that the device file
> > > > is opened with O_RDWR."
> > >
> > > Well, I'd say that the current ALSA-OSS implementation _is_ compatible
> > > to OSS API.  What they do is also a pure hack, as you know, just a
> > > workaround because the API doesn't provide the functionality
> > > properly for full-duplex with multi-channels.  The solution might be
> > > different, but it's not the question about "compatibility".
> > >
> > >
> > > Following this thread, I come to believe that the problem with
> > > audacity is actually the application problem.  It tries to open a
> > > full-duplex device with different number of channels for both
> > > directions.  It cannot work because it's not defined in API.  OTOH, if
> > > the number of channels are same for both directions, it should work
> > > with O_RDWR.
> >
> > Thanks for sticking with it so far -hopefully we are moving towards a
> > conclusion so that the result is a definitive recommendation for how to
> > solve the problem of the OSS API limitation.
> >
> > So that there is no misunderstanding, are you willing to confirm that, as
> > far as Alsa-OSS goes, opening both
> > 	input_handle = open("/dev/dsp", O_RDONLY)
> > and
> > 	output_handle = open("/dev/dsp", O_WRONLY)
> > at the same time is a reliable way to open the device bi-directional,
> > enabling different sample formats and/or numbers of channels to be set? 
> > (Actually, I am curious whether different sample rates would also work?)
>
> Yes, although I didn't confirm it.  If it doesn't work, we should
> really fix it.  The dirrerent sample rates should work, too, because
> they are different streams.
>
> > Provided this is so, the recommendation then for duplex as I understand
> > it is:-
> > 	a) where the format and no.channels is the same in each direction,
> > 	    use
> > 		input_handle = output_handle = open("device", O_RDWR)
> >
> > 	b) where the 2 directions have different format or no.channels use
> > 		input_handle = open("device", O_RDONLY)
> > 		output_handle = open("device", O_WRONLY)
> >
> > since a) may improve compatibility with other OSS's but b) is necessary
> > due to the limitations of the OSS API, whether or not it works with other
> > OSS's.
>
> Exactly.  But, remember that the solution for this kind of problems
> must be practical - if the theory above isn't true for the practice,
> it's of course useless :)
>

Confirm it is working on my system apparently OK.  

I will now take this up with portaudio/audacity, and provide substitute 
patches on the known postings that relate to this, so there is some 
consistency.

Might it be worth adding a paragraph to 'OSS-Emulation.txt' (or.html), eg as 
below?  Apart from that I will close off on this issue now!

Thanks again

Alan



Duplex Streams
============

When attempting to use a single device file for playback and capture, the OSS 
API provides no way to set the format, sample rate or number of channels 
different in each direction.  Thus 
		io_handle = open("device", O_RDWR)
will only function correctly if the values are the same in each direction.

To use different values in the two directions, use both
 		input_handle = open("device", O_RDONLY)
 		output_handle = open("device", O_WRONLY)
and set the values for the corresponding handle.
