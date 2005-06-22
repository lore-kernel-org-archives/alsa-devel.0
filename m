From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001206]: No Surround Sound (5.1) with analog speaker set on ASUS P4P800-VM and Suse 9.3 (Kernel 26.11.4-20a)
Date: Wed, 22 Jun 2005 12:48:47 +0200
Message-ID: <63261be27416400be53f50475729b36c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 777A51D4
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 12:48:47 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1206> 
======================================================================
Reported By:                marcmerz
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1206
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 9.3
Kernel Version:             Linux cinemaxx 2.6.11.4-20a-smp-matrox
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 SMP Fri May 27 20:49:09
CEST 2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             06-20-2005 20:39 CEST
Last Modified:              06-22-2005 12:48 CEST
======================================================================
Summary:                    No Surround Sound (5.1) with analog speaker set on
ASUS P4P800-VM and Suse 9.3 (Kernel 26.11.4-20a)
Description: 
The same hardware (Asus P4P800-VM with an analog surround set from
creative) was working fine under Suse 9.1 with Kernel 2.6.5. I then had to
change my HD (/dev/hda) due to harddisk crash and installed Suse 9.3 with
Kernel 2.6.11.4-20a (where i included module support for my Matrox G400
everything else is default config). It came with ALSA 1.08. I already got
the sources from the alsa homepage and updated to the current versions
(1.09b, 1.09a and 1.09 for drivers, utils, libs, tools etc.).
 
Meanwhile i spent more than 7 days now to get my DD5.1 Surround working in
6-channel mode but to no avail. When i do the speaker test, the front left
and front right are ok. Rear Left comes from the Rear Right speaker and
Rear Right comes from the left rear speaker. The center channel does not
do any sounds at all and the LFE output is on the left front speaker.
 
I checked my wirings a couple of times. I do have 'normal' sound in KDE
playing MP3's etc. and i can also use the 'Spread Front to Surround/LFE'
switch in kmix to get some sound from all speakers including center and
lfe.
 
When i play AC3 testfiles with a52dec, the center is always off (i.e. not
to hear) and the lfe output is going to the front left speaker. With
ac3dec i get the same result but on top of it, using 'ac3dec -6' the sound
is crackling and therefore useless (btw. this was also the case with Alsa
1.04|5 under Suse 9.1 with Kernel 2.6.5).
 
I can not believe that the same setup did work flawlessly under ALSA 1.05
and with a new kernel and current source drivers from the alsa project
homepage it is just not working in DD5.1.
 
Maybe there is a configuration mistake concerning plug:surround51 sending
output to the wrong channels but a) i did not change anything there and b)
i have no clue how to do that anyway.
 
Any help would be greatly appreciated.
 
Just some settings from my setup:
# lspci -v|grep audio  // (using acpi=off noapic in /boot/grub/menu.lst
does not make any difference
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)

# hwinfo --sound
21: PCI 1f.5: 0401 Multimedia audio controller
  [Created at pci.273]
  Unique ID: W60f.jRYEjR2QAA3
  SysFS ID: /devices/pci0000:00/0000:00:1f.5
  SysFS BusID: 0000:00:1f.5
  Hardware Class: sound
  Model: "ASUSTeK 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x24d5 "82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller"
  SubVendor: pci 0x1043 "ASUSTeK Computer Inc."
  SubDevice: pci 0x80b0
  Revision: 0x02
  Driver: "Intel ICH"
  I/O Ports: 0xe800-0xe8ff (rw)
  I/O Ports: 0xee80-0xeebf (rw)
  Memory Range: 0xfebff800-0xfebff9ff (rw,non-prefetchable)
  Memory Range: 0xfebff400-0xfebff4ff (rw,non-prefetchable)
  IRQ: 209 (170062 events)
  Driver Info https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0:
    Driver Status: snd-intel8x0 is active
    Driver Activation Cmd: "modprobe snd-intel8x0"
  Driver Info https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1:
    Driver Status: i810_audio is not active
    Driver Activation Cmd: "modprobe i810_audio"
  Config Status: cfg=yes, avail=yes, need=no, active=unknown

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jun  8 2005 for kernel 2.6.11.4-20a-smp-matrox (SMP).
 
# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1980 at 0xfebff800, irq 209

# cat /proc/asound/devices
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

# cat /proc/asound/modules
0 snd_intel8x0

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1

/etc/asound.state:
state.ICH5 {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Master Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Surround Playback Volume'
                value.0 28
                value.1 28
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value true
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 31
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value true
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 31
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Surround Playback Volume'
                value.0 31
                value.1 31
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Master Playback Switch'
                value.0 true
                value.1 true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 28
                value.1 28
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Mono Playback Switch'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Phone Playback Switch'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value true
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 31
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Line Playback Switch'
                value.0 true
                value.1 true
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 31
                value.1 31
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'CD Playback Switch'
                value.0 false
                value.1 false
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Aux Playback Switch'
                value.0 false
                value.1 false
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'PCM Playback Switch'
                value.0 true
                value.1 true
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 31
                value.1 31
        }
        control.26 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }
        control.27 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 true
                value.1 true
        }
        control.28 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.29 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.30 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f0000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000'
        }
        control.31 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000
        }
        control.32 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'008200020000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000'
        }
        control.33 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value false
        }
        control.34 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 0
        }
        control.35 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 AC-Link
                comment.item.1 'A/D Converter'
                iface MIXER
                name 'IEC958 Playback Source'
                value 'A/D Converter'
        }
        control.36 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Exchange Front/Surround'
                value false
        }
        control.37 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Spread Front to Surround and Center/LFE'
                value false
        }
        control.38 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Off
                comment.item.1 '6 -> 4'
                comment.item.2 '6 -> 2'
                iface MIXER
                name Downmix
                value Off
        }
        control.39 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Shared
                comment.item.1 Independent
                iface MIXER
                name 'Surround Jack Mode'
                value Shared
        }
        control.40 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 '2ch'
                comment.item.1 '4ch'
                comment.item.2 '6ch'
                iface MIXER
                name 'Channel Mode'
                value '6ch'
        }
        control.41 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Stereo Mic'
                value false
        }
        control.42 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'External Amplifier'
                value false
        }
}

# lsmod|grep snd
snd_intel8x0           35136  0
snd_ac97_codec         84220  1 snd_intel8x0
snd_pcm               106500  2 snd_intel8x0,snd_ac97_codec
snd_timer              29700  1 snd_pcm
snd                    65796  4
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              14048  1 snd
snd_page_alloc         13060  2 snd_intel8x0,snd_pcm
======================================================================

----------------------------------------------------------------------
 tiwai - 06-22-05 12:44 
----------------------------------------------------------------------
Then why not try to instal 1.0.8 for testing?

----------------------------------------------------------------------
 tiwai - 06-22-05 12:48 
----------------------------------------------------------------------
Let me rephrase:  You can still install 1.0.8 alsa-driver with the recent
kernel, too.  Some drivers like usb might not, but intel8x0 should be OK. 
You can keep alsa-lib and alsa-utils 1.0.9 with the old drivers.

So, just get alsa-driver-1.0.8 tarball, and configure with
--with-debug=full --with-cards=intel8x0, and install it.  Then dump the
ac97 proc files on that system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 20:39 marcmerz       New Issue                                    
06-20-05 20:39 marcmerz       Distribution              => Suse 9.3        
06-20-05 20:39 marcmerz       Kernel Version            => Linux cinemaxx
2.6.11.4-20a-smp-matrox https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
SMP Fri May 27 20:49:09 CEST 2005 i686 i686 i386 GNU/Linux
06-21-05 11:26 tiwai          Note Added: 0005105                          
06-21-05 20:29 marcmerz       Note Added: 0005113                          
06-22-05 01:08 marcmerz       Note Added: 0005115                          
06-22-05 01:20 marcmerz       Note Added: 0005116                          
06-22-05 01:43 rlrevell       Note Added: 0005117                          
06-22-05 10:04 pzad           Note Added: 0005119                          
06-22-05 11:49 tiwai          Note Added: 0005124                          
06-22-05 11:53 tiwai          Note Added: 0005125                          
06-22-05 12:37 marcmerz       Note Added: 0005127                          
06-22-05 12:44 tiwai          Note Added: 0005128                          
06-22-05 12:48 tiwai          Note Added: 0005129                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
