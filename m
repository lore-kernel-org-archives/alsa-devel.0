From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-midi, midi input, oss, oops!
Date: Tue, 17 Sep 2002 11:49:38 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209170930500.5178-100000@studcom.urz.uni-halle.de>
References: <200209162313.QAA04893@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200209162313.QAA04893@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> After the reboot is done I conect the MidiSport 2x2 usb MIDI
> interface. Hotplug recognizes the card, fxload loads the
> firmware, the interface disconnects and reconnects, hotplug
> recognizes that and loads snd-usb-audio (both "audio" and
> "usb-midi" have been blacklisted). And that's it. With no
> extra configuration snd-usb-audio is not automatically loading
> snd-usb-midi (bug?). So I go ahead and load snd-usb-midi by
> hand.

snd-usb-midi should be loaded when you try to access the sequencer device.
"aconnect -o" or trying to play/record something usually does the job.

I think I have observed a similar bug when snd-usb-audio is already loaded
for another device without MIDI, but this isn't the case here.

> Sending midi from a keyboard makes the Midi IN LED blink (so the midi
> bytes are getting to the interface) but I see no activity in the
> program (which should be showing the midi bytes being received).
> Checking /proc/asound/card1/midi0 I can see that Output 0 has a
> non-zero value of "Tx bytes", but Input O has received nothing. Same
> with Muse which uses the native alsa interface.
>
> So everything seems to indicate things are working but
> nothing is received by the programs and alsa.

Please try the seq program in the alsa-lib/test directory to see whether
the sequencer device works.
"./seq decoder 72.0" will show incoming events.

> So I say, let's try the oss drivers.
>
> I unload all the alsa modules related with the second card
> (which is the MidiSport). After that I load both "audio" and
> "usb-midi", they say they recognize the card and they set up
> two interfaces, /dev/midi00 and /dev/midi01. Trying to use pd
> gets the same results, output works, input does not.

Neither driver working may indicate some problem with the 2x2 firmware.
Try using some other version.

> Now I get curious and say, what if I load the alsa usb midi
> modules? (I know I should not be doing this!) So I go ahead
> and load snd-usb-audio and then snd-usb-midi, to my surprise
> they load (I would imagine they would refuse to load because
> the other driver is using the midi interface hardware):

Please compare /proc/bus/usb/devices before and after. It really should
not be possible to replace a driver already connected to the device.

> Sep 16 15:42:06 nando kernel: snd-usb-midi: MIDIStreaming version 01.00
> Sep 16 15:42:06 nando kernel: snd-usb-midi: detected 2 output jack(s) on endpoint 1
> Sep 16 15:42:06 nando kernel: snd-usb-midi: detected 2 input jack(s) on endpoint 1
> Sep 16 15:42:06 nando kernel: ALSA ../alsa-kernel/core/rawmidi.c:1425: unable
> to register OSS rawmidi device 1:0
> Sep 16 15:42:06 nando kernel: snd-usb-midi: endpoint 1: created 2 output and 2
> input ports
>
> Note that they cannot register the device (because usb-midi is
> using it?) but the drivers stay loaded and seem to create the
> endpoints.

The OSS devices cannot be registered. The ALSA rawmidi and sequencer
devices should work.

> If I try to start pd things keep working (midi in
> does not work, of course), but I get some errors (not
> surprising):
>
> Sep 16 15:42:48 nando kernel: usb-uhci.c: ENXIO c0008580, flags 0, urb
> deebaea0, burb defc3ce0
> Sep 16 15:42:48 nando kernel: usbmidi: Cannot submit urb for MIDI-IN
> Sep 16 15:43:31 nando kernel: usb-uhci.c: ENXIO c0008580, flags 0, urb
> deebaea0, burb defc3ce0
> Sep 16 15:43:31 nando kernel: usbmidi: Cannot submit urb for MIDI-IN

usb-midi complains because snd-usb-midi has already submitted an urb.
This is to be expected in this situation.

> So I unload all modules, both alsa and oss versions dealing
> with the MidiSport. They unload cleanly.
>
> The I load snd-usb-audio and snd-usb-midi _again_. They load.
>
> If I start pd I get a kernel oops:

I think something got out of whack when two drivers tried to handle the
same device simultaneously.

> Is there anything else I could test?

Try to see what happens if you plug/unplug 50 times in 10 seconds.  ;-)


Regards,
Clemens



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
