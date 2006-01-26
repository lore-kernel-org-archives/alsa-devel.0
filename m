From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Thu, 26 Jan 2006 20:45:37 +0100
Message-ID: <bfd25206b4f6a121f739e5677f04a301@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4EB88197
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 20:45:37 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The issue 0001784 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              01-18-2006 18:16 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001784 line input not recording right channel
======================================================================

----------------------------------------------------------------------
 linuxbear - 12-18-05 12:02 
----------------------------------------------------------------------
I have the same issue.  My kernel is 2.6.14 with Con Kolivas ck5 patch. 
nForce motherboard with intel8x0.... does not work, capture happens on one
channel... tried every mixer setting.

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio
Controler (MCP) (rev a1)
        Subsystem: Biostar Microtech Int'l Corp: Unknown device 8201
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2



----------------------------------------------------------------------
 tgutwin - 01-07-06 06:24 
----------------------------------------------------------------------
Same issue here, plus a few others on the MythTV user list have the same
symptoms after kernel and/or ALSA dirver updates.

Playback works fine
Capture only gets one channel (Left).
I can monitor the 2ch audio fine but when it gets recorded through Myth
(or LiveTV which is also a capture and record process) it loses its right
channel of audio with plain old analog 2 channel output.
NO digital AC3 used here (yet)

I have gone through the alsa setup with a fine tooth comb. it looks
correct.
plus all audio and video apps outside of MythTV play back work correctly.


I have tried every mute/capture setting using a couple of different
mixers.
The problem persists.

My system is a freshly built system specifically to be a home for
>>  AMD X2
>>  Asus A8N-e with onboard nvidia CK804/intel8x0
>>  Fedora core 4 built for x86_64
>>  with smp kernel 2.6.14-1.1653_FC4
>>  Alsa Version 1.0.10rc3  for kernel 2.6.14-1.1653_FC4smp (SMP)
    From atrpms

[root@dvr dev]# cd /proc
[root@dvr proc]# cd asound
[root@dvr asound]# ls
card0  cards  CK804  devices  hwdep  modules  oss  pcm  seq  timers 
version
[root@dvr asound]# cat version
Advanced Linux Sound Architecture Driver Version 1.0.10rc3.
Compiled on Dec 14 2005 for kernel 2.6.14-1.1653_FC4smp (SMP).
[root@dvr asound]# cat cards
0 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xc8103000, irq 50

lsmod | grep snd
snd_usb_audio          92160  0
snd_usb_lib            21504  1 snd_usb_audio
snd_rawmidi            32544  1 snd_usb_lib
snd_hwdep              14624  1 snd_usb_audio
snd_intel8x0           39848  1
snd_ac97_codec        115516  1 snd_intel8x0
snd_ac97_bus            6784  1 snd_ac97_codec
snd_seq_dummy           8068  0
snd_seq_oss            42596  0
snd_seq_midi_event     12672  1 snd_seq_oss
snd_seq                67288  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         14224  4
snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            61984  0
snd_mixer_oss          22656  2 snd_pcm_oss
snd_pcm               106888  4
snd_usb_audio,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              30344  2 snd_seq,snd_pcm
snd                    69088  15
snd_usb_audio,snd_usb_lib,snd_rawmidi,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              16353  2 snd
snd_page_alloc         15376  2 snd_intel8x0,snd_pcm


There are other users that have reported the same issue.

What other debugging can I do?
I can send in amixer scontents, but I have enumerated all options.

----------------------------------------------------------------------
 legluondunet - 01-09-06 01:34 
----------------------------------------------------------------------
Hello,

I had the same problem: suddenly and with no reason, my system record
sound with only one channel :-(.
After severals hours of searches on internet and in the deeper place of my
system, I found a solution.

I have a Ubuntu live disc. I boot on it and test the record: 2 channels
were record (ok).
So I begin to replace the alsa config of my system with the Ubuntu one's.
After several tests, I found that when I change my
/usr/share/alsa/alsa.conf with the ubuntu nes, I could again record with 2
channels :-).
I don't know the differences between this 2 files so I join them.

I hope this help :-)

----------------------------------------------------------------------
 legluondunet - 01-09-06 01:43 
----------------------------------------------------------------------
I join the two files:
alsa.conf.record1channel
and
alsa.conf.ubuntu --> the file I copy from a ubuntu distrib, I could record
normaly with it.

My config:

Debian testing/unstable
P4 3ghz
soundcard:
 0 [ICH5           ]: ICH4 - Intel ICH5
                      Intel ICH5 with ALC650F at 0xee101000, irq 20
kernel 2.6.14

nota: before finding this solution I did this:
test several other kernels, test several recording applications, test
others alsa modules...lost my hair...

----------------------------------------------------------------------
 rlrevell - 01-13-06 02:17 
----------------------------------------------------------------------
That's bizarre, the only difference is:

--- /home/rlrevell/Desktop/alsa.conf.ubuntu     2006-01-12
20:15:41.000000000 -0500
+++ /home/rlrevell/Desktop/alsa.conf.record1channel     2006-01-12
20:16:28.000000000 -0500
@@ -251,6 +251,7 @@
 pcm.iec958 cards.pcm.iec958
 pcm.spdif cards.pcm.iec958
 pcm.modem cards.pcm.modem
+pcm.phoneline cards.pcm.phoneline
 
 pcm.default cards.pcm.default
 pcm.dmix cards.pcm.dmix

----------------------------------------------------------------------
 Matthias Koenig - 01-13-06 14:29 
----------------------------------------------------------------------
I have the same symptoms on my system:
Capturing Line, works only on channel 1, channel 2 is silent,
although with some noise. 
I figured out that switching the Mic Boost on changes (boosts) 
the noisefloor of the silent channel 2.
Some tests with a Microphone confirmed that channel 2 records always
the Mic input, independently of any capture source settings in mixer.
Switching Capture off in mixer does work (silence on both channels
without noise). However, switching capture source is only effective 
on channel 1. Channel 2 keeps listening to Mic input.

ALSA Versions tried:
1.0.10rc3
1.0.11rc2

Kernel: Vanilla 2.6.15 on Debian/testing

card 0: nForce2 [NVidia nForce2], device 0: Intel ICH [NVidia nForce2]

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio
Processing Unit (rev a2)
        Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at ef000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [44] Power Management version 2

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
        Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at ef081000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

----------------------------------------------------------------------
 legluondunet - 01-13-06 17:12 
----------------------------------------------------------------------
Alsa.conf is part of the libasound/alsalib librairie. Did you tried to
install another version of this librairie? I think the problem come from
this librairie.

----------------------------------------------------------------------
 vsu - 01-13-06 17:46 
----------------------------------------------------------------------
Here I see what looks like the same problem with snd-via82xx and Realtek
ALC200 (not really tested with input signals, but values of ac97 mixer
registers are wrong). Kernel 2.6.14, alsa-driver, alsa-lib and alsa-utils
1.0.10.

Initially the capture source is set to Mic:

$ cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:1a 
0:1a = 0000
$ amixer cget iface=MIXER,name='Capture Source'               
numid=24,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=0,0

Then I run alsamixer, press F4 to switch to capture view, move to "Line"
and press Space - alsamixer shows that Line is now selected for capture.

However, the contents of the ac97 register 0x1a is wrong:

$ cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:1a
0:1a = 0400

Only the left channel was switched to Line - the right channel remains set
to Mic.  And amixer shows this too:

$ amixer cget iface=MIXER,name='Capture Source'
numid=24,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=4,0

But the simple mixer values do not agree with this:

$ amixer sget 'Line'
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [on]
  Front Right: Playback 0 [0%] [off] Capture [on]
$ amixer sget 'Mic'                                         
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]

If I use "amixer cset", I can set the mixer properly:

$ amixer cset iface=MIXER,name='Capture Source' 4,4
numid=24,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=4,4
$ cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:1a
0:1a = 0404

So it looks like the kernel driver and low-level mixer access in alsa-lib
works correctly, but the simple mixer layer in alsa-lib is broken.

----------------------------------------------------------------------
 tiwai - 01-13-06 17:51 
----------------------------------------------------------------------
This should have been already fixed in the latest version.

----------------------------------------------------------------------
 vsu - 01-13-06 18:17 
----------------------------------------------------------------------
Yes, upgrading only alsa-lib to 1.0.11rc2 seems to fix this problem for me.

----------------------------------------------------------------------
 Matthias Koenig - 01-18-06 11:53 
----------------------------------------------------------------------
Indeed, updating alsa-lib to the latest version fixes the problem.
I misleadingly assumed the bug in the kernel driver.
Thank you very much!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
01-09-06 01:35 legluondunet   File Added: alsa.conf.record1channel              
     
01-09-06 01:37 legluondunet   File Added: alsa.conf.ubuntu                    
01-09-06 01:43 legluondunet   Note Added: 0007530                          
01-13-06 02:17 rlrevell       Note Added: 0007615                          
01-13-06 14:29 Matthias KoenigNote Added: 0007640                          
01-13-06 17:12 legluondunet   Note Added: 0007644                          
01-13-06 17:46 vsu            Note Added: 0007645                          
01-13-06 17:49 vsu            Issue Monitored: vsu                         
01-13-06 17:51 tiwai          Note Added: 0007646                          
01-13-06 18:17 vsu            Note Added: 0007647                          
01-18-06 11:53 Matthias KoenigNote Added: 0007709                          
01-18-06 18:16 rlrevell       Status                   new => resolved     
01-18-06 18:16 rlrevell       Resolution               open => fixed       
01-18-06 18:16 rlrevell       Assigned To               => rlrevell        
01-26-06 20:45 rlrevell       Relationship added       has duplicate 0001784
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
