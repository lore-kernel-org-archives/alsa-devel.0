From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: snd-usb-midi, midi input, oss, oops!
Date: Tue, 17 Sep 2002 12:47:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209171947.MAA06264@cmn29.stanford.edu>
References: <Pine.HPX.4.33n.0209170930500.5178-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0209170930500.5178-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > firmware, the interface disconnects and reconnects, hotplug
> > recognizes that and loads snd-usb-audio (both "audio" and
> > "usb-midi" have been blacklisted). And that's it. With no
> > extra configuration snd-usb-audio is not automatically loading
> > snd-usb-midi (bug?). So I go ahead and load snd-usb-midi by
> > hand.
>
> snd-usb-midi should be loaded when you try to access the sequencer device.
> "aconnect -o" or trying to play/record something usually does the job.

"aconnect -o" does it, starting Muse (which uses alsa native
midi) does it but starting Pd (which uses the OSS emulation
midi raw devices) does not load the snd-usb-midi modules. Is
there a reason why the load is delayed? It makes more sense to
me to load them when the interface is plugged in, after all
the hardware is there and is usable and snd-usb-audio loads.
Or maybe I need to put something in /etc/modules.conf to
accomplish this?

> Neither driver working may indicate some problem with the 2x2 firmware.
> Try using some other version.

Thanks to an email from Michal Seta (off the list) the MIDI in
problem is solved. Apparently the Midisport 2x2 firmware does
not like any active MIDI inputs while the firmware is loading.
If you disconnect everything, plug in the interface to the usb
bus, load all the drivers and _then_ connect the input midi
cables everything is fine.

> Please compare /proc/bus/usb/devices before and after. It really should
> not be possible to replace a driver already connected to the device.

This is what it shows (diffs from previous state):

- first load all alsa drivers, including snd-usb-audio and snd-usb-midi
  [baseline]

- then unload all alsa drivers:

 S:  Product=Midisport 2x2
 S:  SerialNumber=Copyright (GPLv2) 2001 by Lars Doelle <lars.doelle@on-line.de>
 C:* #Ifs= 2 Cfg#= 1 Atr=00 MxPwr=100mA
-I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
+I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
+I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=(none)
 E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
 E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

- just load the alsa audio drivers (alsasound startup script)
  [no changes]

- load the "audio" module
  [no changes]

- load the "usb-midi" module

 S:  SerialNumber=Copyright (GPLv2) 2001 by Lars Doelle <lars.doelle@on-line.de>
 C:* #Ifs= 2 Cfg#= 1 Atr=00 MxPwr=100mA
 I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=(none)
+I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=midi
 E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
 E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

- load snd-usb-audio, snd-usb-midi

 S:  Product=Midisport 2x2
 S:  SerialNumber=Copyright (GPLv2) 2001 by Lars Doelle <lars.doelle@on-line.de>
 C:* #Ifs= 2 Cfg#= 1 Atr=00 MxPwr=100mA
-I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=midi
+I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
+I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
 E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
 E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

So it appears things are being replaced when they should not be.

> > So I unload all modules, both alsa and oss versions dealing
> > with the MidiSport. They unload cleanly.
> >
> > The I load snd-usb-audio and snd-usb-midi _again_. They load.
> >
> > If I start pd I get a kernel oops:
>
> I think something got out of whack when two drivers tried to handle the
> same device simultaneously.

Definitely...
-- Fernando


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
