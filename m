From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Wed, 06 Nov 2002 10:46:11 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211060955410.14432-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA26692
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 10:46:15 +0100
In-reply-to: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> The MIDI interface I'm using is a Midisport 2x2 (same results with a 1x1).
>
> It works fine with alsa cvs of 2002-08-20, has problems with alsa cvs of
> 2002-10-28.

The driver has been changed to use rawmidi ports.

> ALSA:
>   cat /proc/asound/devices shows only one raw midi interface. This is on
>   a two port device (but Muse lets me select either port). On the older
>   alsa two devices show up on the listing.

For multiport interfaces, the additional ports are available as subdevices
of the rawmidi device, i.e. hw:1,0,0 and hw:1,0,1. (This is the same
behaviour as with other multiport interfaces, i.e. snd-mtpav and
snd-serial-u16550.)

>   input does not seem to work at all. I'm using the Muse MIDI sequencer,
>   with  the older alsa version it works fine (input), with the newer alsa
>   version it does not record midi input at all. Output works fine on both
>   alsa versions.

It worked when I tested it with midiloop and seq. Try using a sequencer
port instead of a rawmidi port.

>   The input byte counters in /proc/asound/card1/midi0 do not increment.

These counters increment only when somebody is reading from the port.
Try looking at them while executing "cat /dev/snd/midiCxD0".

> OSS emulation (raw midi interface):
>   OSS programs using the raw midi interface emulation (I'm using pd) can't
>   see both midi ports in the oss emulation world. They only see the first
>   port.

The OSS emulation doesn't support specifying a subdevice number.

If a rawmidi device is opened without a subdevice number, ALSA opens the
first available subdevice, so it would be possible to access both ports by
opening /dev/midix twice.
(It should be possible to map both /dev/midix and /dev/amidix to the same
device with the midi_map and amidi_map options of the snd-rawmidi module.)


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
