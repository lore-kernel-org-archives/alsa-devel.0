From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code
Date: Thu, 07 Nov 2002 10:17:08 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211070920340.2533-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0211061803000.1126-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA15782
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 10:17:12 +0100
In-reply-to: <Pine.LNX.4.44.0211061803000.1126-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> > > i'm with fernando on this one. if consistency is the goal, and i think
> > > it should be, then multiport MIDI devices should appear as multiple
> > > ports, not subdevices.

BTW: The old driver had one (emulated) rawmidi device per sequencer port,
each having 16(?) subdevices to enable concurrent access.

> > We have no minor numbers for direct addressing of tenths rawmidi devices.

We have eight minor numbers. On 8-port interfaces like the UM-880 or the
MidiSport 8x8, the ninth port (for control/timing data) is the most
interesting one.

> That's really too bad. What does that address space look like at this
> point and how is it used? (ie: what is it that is available?)

There is one major number each for OSS (14) and ALSA (116), so we have 256
minor numbers for all devices.

ALSA supports up to 8 cards, so there are 32 minors per card.
There are 8 rawmidi minors (8-15).

OSS has 16 minors per card.
Rawmidi devices use 2 (/dev/midix) and 13 (/dev/amidix).

The other minors are mostly used for other devices (see minor.h), but at
least for OSS it may be possible to use the "reserved" numbers 7 and 15
for two other rawmidi devices. Hmmm, /dev/bmidix and /dev/cmidix? :-)

> Is it possible to at least to fix the behavior in the OSS world?

I think it would be possible to add two more options (midi_minor_map and
amidi_minor_map) to the snd-rawmidi module, but I'm not sure this would be
the best solution.


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
