From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-midi, midi input, oss, oops!
Date: Wed, 18 Sep 2002 11:04:30 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209181036450.6852-100000@studcom.urz.uni-halle.de>
References: <200209171947.MAA06264@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200209171947.MAA06264@cmn29.stanford.edu>
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
> > snd-usb-midi should be loaded when you try to access the sequencer device.
> > "aconnect -o" or trying to play/record something usually does the job.
>
> "aconnect -o" does it, starting Muse (which uses alsa native
> midi) does it but starting Pd (which uses the OSS emulation
> midi raw devices) does not load the snd-usb-midi modules. Is
> there a reason why the load is delayed?

ALSA loads sequencer drivers lazily because most users only want to play
.wav and MP3^H^H^HOgg files and thus do not have to suffer the overhead of
the sequencer which is quite big. In most cases, the sequencer would have
been loaded because of the existence of the OPL3 FM synthesize which
nodody wants to use anyway.

> Or maybe I need to put something in /etc/modules.conf to
> accomplish this?

I think add-above/below could do what you want. Please have a look at the
manpage.

> > Please compare /proc/bus/usb/devices before and after. It really should
> > not be possible to replace a driver already connected to the device.
>
> This is what it shows (diffs from previous state):
>
> - first load all alsa drivers, including snd-usb-audio and snd-usb-midi
>   [baseline]
>
> - then unload all alsa drivers:
>
> -I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
> -I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
> +I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
> +I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=(none)

Interface 0 is the AudioControl interface. Its purpose is to list all
AudioStreaming and MIDIStreaming interfaces of the device. In this case,
if0 has a pointer to MIDI if1 (see lsusb for the boring details), and
snd-usb-audio grabs both interfaces.

> - just load the alsa audio drivers (alsasound startup script)
>   [no changes]
>
> - load the "audio" module
>   [no changes]

audio looks at the control interface, doesn't find any AudioStreaming
interfaces, and therefore doesn't do anything.

> - load the "usb-midi" module
>
>  I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
> -I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=(none)
> +I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=midi

usb-midi does _not_ look at the control interface, it simply grabs all
MIDIStreaming interfaces. (The old snd-usb-midi driver from 0.9.0rc3 did
the same.)

> - load snd-usb-audio, snd-usb-midi
>
> -I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
> -I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=midi
> +I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
> +I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
>
> So it appears things are being replaced when they should not be.

Yes.

Interface 0 doesn't have a driver, so the Linux kernel tries to load
snd-usb-audio for it. snd-usb-audio then looks at the list of streaming
interfaces (see above) and grabs interface 1 without checking if this
interface is used by another driver.

This is a bug in snd-usb-audio.


Regards,
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
