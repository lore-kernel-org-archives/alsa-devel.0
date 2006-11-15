From: "Kailang" <kailang@realtek.com.tw>
Subject: Re: S/PDIF support for Intel HDA Realtek ALC880?
Date: Wed, 15 Nov 2006 17:38:13 +0800
Message-ID: <004b01c70899$c51c8e70$4c5215ac@realtek.com.tw>
References: <D0623A7E119D564AA1966968BC37AE29C32CDA@srvsegbg19.space.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: PeiSen Hou <pshou@realtek.com.tw>, Takashi Iwai <tiwai@suse.de>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Peter Carlsson <peter.carlsson@space.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yes, you got it. This looks like SUSE Linux.
To add it to the file of sound was right.

Kailang.....^^

----- Original Message ----- 
From: "Peter Carlsson" <peter.carlsson@space.se>
To: "Kailang" <kailang@realtek.com.tw>; "PeiSen Hou" <pshou@realtek.com.tw>;
"Takashi Iwai" <tiwai@suse.de>; "Jonathan Woithe"
<jwoithe@physics.adelaide.edu.au>
Cc: <alsa-devel@lists.sourceforge.net>; "Peter Carlsson"
<peter.carlsson@space.se>
Sent: Wednesday, November 15, 2006 5:31 PM
Subject: RE: S/PDIF support for Intel HDA Realtek ALC880?


Hello!

On my Debian system there is no file named modprobe.conf. Instead
there is a directory named /etc/modprobe.conf with the following
files:

htpc:/etc/modprobe.d# ls -go
total 30
-rw-r--r-- 1  4360 2006-02-05 14:00 aliases
-rw-r--r-- 1 16153 2006-09-11 10:44 alsa-base
-rw-r--r-- 1   156 2005-12-16 10:05 alsa-base-blacklist
drwxr-xr-x 2  1024 2006-06-14 16:51 arch
lrwxrwxrwx 1     9 2006-06-14 16:51 arch-aliases -> arch/i386
-rw-r--r-- 1  1406 2006-02-20 16:15 blacklist
-rw-r--r-- 1   284 2006-02-20 16:15 display_class
lrwxrwxrwx 1    41 2006-10-15 20:07 linux-sound-base_noOSS ->
/lib/linux-sound-base/noOSS.modprobe.conf
-rw-r--r-- 1    29 2005-10-29 04:48 nvidia-kernel-nkc
-rw-r--r-- 1   363 2006-02-20 16:15 pnp-hotplug
-rw-r--r-- 1    61 2006-04-22 14:54 sound

The sound file contains what you told me to look for.

htpc:/etc/modprobe.d# cat sound
alias snd-card-0 snd-hda-intel
options snd-hda-intel index=0

After modifying this file as suggested I get:

htpc:/home/mythtv# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC880 Analog [ALC880 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC880 Digital [ALC880 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

alsamixer now contains IEC958 which I toggled from <Off> to <On>.

htpc:/home/mythtv# lspci -s 00:10 -vn
00:10.0 0604: 10de:026f (rev a2) (prog-if 01 [Subtractive decode])
Flags: bus master, 66MHz, fast devsel, latency 0
Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
I/O behind bridge: 0000a000-0000afff
Memory behind bridge: e9000000-e90fffff
Prefetchable memory behind bridge: e0000000-e3ffffff
Capabilities: [b8] Subsystem: 0000:0000
Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 0403: 10de:026c (rev a2)
Subsystem: 1458:a102
Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
Memory at e9100000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [44] Power Management version 2
Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/0 Enable-
Capabilities: [6c] HyperTransport: MSI Mapping

What entries do I have to put in the ~/.asoundrc file?

I am not able to test if all this works until I get home. But it
surely looks very promising indeed.

Thanks for all the wonderful help!

Best regards,
Peter Carlsson

>-----Original Message-----
>From: Kailang [mailto:kailang@realtek.com.tw]
>Sent: Wednesday, November 15, 2006 9:21 AM
>To: Peter Carlsson; PeiSen Hou; Takashi Iwai; Jonathan Woithe
>Cc: Peter Carlsson
>Subject: Re: S/PDIF support for Intel HDA Realtek ALC880?
>
>Please find the modprobe.conf file first.
>Then to edit the file as below.
>
>find this line.
>options snd-hda-intel index=0
>
>To add the model at this line.
>options snd-hda-intel index=0 model=6stack-digout
>
>try it.
>
>kailang
>
>----- Original Message ----- 
>From: "Peter Carlsson" <peter.carlsson@space.se>
>To: "Kailang" <kailang@realtek.com.tw>; "PeiSen Hou"
><pshou@realtek.com.tw>;
>"Takashi Iwai" <tiwai@suse.de>; "Jonathan Woithe"
><jwoithe@physics.adelaide.edu.au>
>Cc: "Peter Carlsson" <peter.carlsson@space.se>
>Sent: Wednesday, November 15, 2006 2:08 PM
>Subject: RE: S/PDIF support for Intel HDA Realtek ALC880?
>
>
>>Could you check the [alsamixer] mixer AP which have the item of
>>iec958(SPDIF)?
>
>mythtv@htpc:~$ alsamixer
>
>This results in the following controls:
>
>PCM, Front, Front Mic, Surround, Center, LFE, Side, Line, CD,
>Mic, PC Speaker, Channel Mode, Input Source, Input Source 1
>and Input Source 2
>
>No indication of iec958 (S/PDIF)
>
>>Hello!
>>
>>I am running Debian (testing) on a Gigabyte GA-K8N51PVMT-9
>>motherboard with integrated Intel HDA Realtek ALC880 sound.
>>On the motherboard is also a connector for S/PDIF where I
>>have attached a back plate. I am using ALSA 1.0.13.
>>
>>Could you please tell me if S/PDIF is supported for this
>>configuration and if so, how can I enable it?
>
>Best regards,
>Peter Carlsson
>
>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
