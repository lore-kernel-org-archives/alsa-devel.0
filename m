From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Thu, 22 Aug 2002 11:45:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003201c249c9$0b6ecc60$0400a8c0@martijn>
References: <Pine.LNX.4.21.0208191748480.673-100000@summer.quitte> <002001c247ac$2259e960$0400a8c0@martijn> <20020820205028.GA2657@idefix.fvdpol.home.nl> <005701c248af$94d09710$0400a8c0@martijn> <20020821234823.GA18447@idefix.fvdpol.home.nl>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA14282
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 11:49:38 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Frank van de Pol <fvdpol@home.nl>, linux-audio-dev@music.columbia.edu, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > I don't want to support tempo (MIDI clock) scheduling in my MIDI API.
This
> > could be better handled in the application itself. Also, when slaved to
MIDI
> > clock
> > it is no longer possible to send messages ahead of time, and not
supporting
> > this
> > in the API makes that clear to the application programmer.
>
> The concept of the public available alsa timing queues allow outboard
> applications to schedule events in a tempo locked fashion. Think of
> applications like drum machines, appegiators, tempo delay etc. Of course
you
> might be using one big monolithic (cubase?) sequencer application which
does
> do everything you need....

No, I like the concept of a lot of small applications. And I want those to
be able
to sync (slave) to MIDI clock.

> Compare it to an external (outboard) drum machine you're using since
> programming a pattern in it so user friendly (hence you end up being more
> creative), and sync that from your favorite sequencer which has the tempo
> map for your song.

For this, the sequencer is master and just sends the MIDI messages including
MIDI clock to a scheduled UST queue. Timing will be as good as is possible
with a MIDI clock slaved external instrument.

> Of course all of this could be done without a queue which supports tempo
> scheduling, but then you'll need to emit MIDI Clock events and rely on
> immediate processing.

Isn't that what will eventually happen using a tempo queue also?

> In case a soft synth (or other potentially high
> latency device) is triggered from the MIDI Clock you loose the ability to
> correct for this.

I don't see how having a MIDI clock scheduled tree will help. When slaving
to MIDI clock you cannot know when a future beat will occur, so a software
synth salved to MIDI clock will behave just like a software synth in real
time,
i.e. it cannot compensate for its own latency. However, if the master sends
the MIDI clock messages ahead of time, and for a sequencer application this
is exactly what it would do, then the software synth can compensate for its
latency and might even interpolate between clocks. This would not be
possible
having a tempo based queue since the UST of the messages in that queue are
not known in advance, right?

> > > leaves room for events not defined in midi spec).
> >
> > ...I'm not sure that is a good idea. What kind of events?
>
> eg.
>
> - system events like announcements of topology changes

I'm thinking of handling these out-of-band.

> - (N)RPNs as a 14 bit value instead of 2x 7bit

This I would like to solve by having the posibility of sending a short
sequence
of MIDI messages that are guaranteed to not be interleaved, e.g. 4 messages,
two for setting the current (N)RPN and 2 for setting its value.

> - SMF like meta data

Is it really necessary to support karaoke :)

> - controls for current sequencer queue: tempo, position, etc.

These aren't needed when a tempo queue isn't used.

I think it is important to keep the API as simple as possible.

--martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
