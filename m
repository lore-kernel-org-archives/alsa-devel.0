From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001096]: no capture with M-Audio Revolution 7.1
Date: Sun, 26 Jun 2005 01:21:02 +0200
Message-ID: <6004ca739e1504b0d257d89d7c6f4fae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53B421B5
	for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2005 01:21:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1096
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-07-2005 21:28 CEST
Last Modified:              06-26-2005 01:21 CEST
======================================================================
Summary:                    no capture with M-Audio Revolution 7.1
Description: 
I am trying to make capture on M-Audio Revolution 7.1 - to no avail so
far.

The OS is Mandriva 10.2, but I have the same problem with the latest
KNOPPIX,
MEPIS, Kubuntu.

On all the above mentioned distribution playback works out of the box,
but
capture is dead.

I do not think there is a sign that capture at all is possible/at all
exists
 - see detailed information below.

 
I think this message:

http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg09998.html

is also related to the issue.


I didn't find any specific explicit mentioning of capture working with
the
card - just general "the card is supported", "made it work", etc.

Did anyone manage to make capture work with the card ? If yes, how to do
this ?

I'm giving the issue "block" severity because the card was specifically
bougth
to perform capture at 96KHz sampling rate.

Thanks in advance,
  Sergei,

Detailed information follows.

--------------------------------------------------------------------------------
  
Output of 'uname -a' BEGIN

[root@athlon ~]# uname -a
Linux athlon.home.net 2.6.11-6mdk-i586-up-1GB
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Mar 22 15:46:07 CET
2005 i686 AMD Athlon(tm) XP 1900+ unknown GNU/Linux
[root@athlon ~]#            

Output of 'uname -a' END

--------------------------------------------------------------------------------

Output of 'amixer -v' BEGIN

[root@athlon ~]# amixer -v
amixer version 1.0.8
[root@athlon ~]#        

Output of 'amixer -v' END

--------------------------------------------------------------------------------

Output of 'amixer -d controls' BEGIN

[root@athlon ~]# amixer -d controls
numid=1,iface=CARD,name='ICE1724 EEPROM'
numid=18,iface=MIXER,name='IEC958 Playback Con Mask',device=1
numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',device=1
numid=14,iface=MIXER,name='IEC958 Playback Route'
numid=15,iface=MIXER,name='IEC958 Playback Route',index=1
numid=16,iface=MIXER,name='IEC958 Output Switch'
numid=20,iface=MIXER,name='DAC Volume'
numid=21,iface=MIXER,name='DAC Volume',index=1
numid=23,iface=MIXER,name='DAC Volume',index=2
numid=24,iface=MIXER,name='DAC Volume',index=3
numid=25,iface=MIXER,name='DAC Volume',index=4
numid=26,iface=MIXER,name='DAC Volume',index=5
numid=27,iface=MIXER,name='DAC Volume',index=6
numid=28,iface=MIXER,name='DAC Volume',index=7
numid=22,iface=MIXER,name='Deemphasis'
numid=29,iface=MIXER,name='Deemphasis',index=1
numid=5,iface=MIXER,name='H/W Playback Route'
numid=6,iface=MIXER,name='H/W Playback Route',index=1
numid=7,iface=MIXER,name='H/W Playback Route',index=2
numid=8,iface=MIXER,name='H/W Playback Route',index=3
numid=9,iface=MIXER,name='H/W Playback Route',index=4
numid=10,iface=MIXER,name='H/W Playback Route',index=5
numid=11,iface=MIXER,name='H/W Playback Route',index=6
numid=12,iface=MIXER,name='H/W Playback Route',index=7
numid=2,iface=MIXER,name='Multi Track Internal Clock'
numid=13,iface=MIXER,name='Multi Track Peak'
numid=3,iface=MIXER,name='Multi Track Rate Locking'
numid=4,iface=MIXER,name='Multi Track Rate Reset'
numid=17,iface=PCM,name='IEC958 Playback Default',device=1
[root@athlon ~]#

Output of 'amixer -d controls' END                 
--------------------------------------------------------------------------------

Info on/from /proc/asound/ BEGIN

[root@athlon ~]# ls -lt /proc/asound/
total 1
-r--r--r--  1 root root 0 May  6 02:42 cards
-r--r--r--  1 root root 0 May  6 02:42 devices
-r--r--r--  1 root root 0 May  6 02:42 modules
dr-xr-xr-x  2 root root 0 May  6 02:42 oss/
-r--r--r--  1 root root 0 May  6 02:42 pcm
dr-xr-xr-x  2 root root 0 May  6 02:42 seq/
-r--r--r--  1 root root 0 May  6 02:42 timers
-r--r--r--  1 root root 0 May  6 02:42 version
dr-xr-xr-x  6 root root 0 May  6 02:42 card0/
lrwxrwxrwx  1 root root 5 May  6 02:42 Revolution71 -> card0/
[root@athlon ~]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.8.
[root@athlon ~]# cat /proc/asound/cards
0 [Revolution71   ]: ICE1724 - M Audio Revolution-7.1
                     M Audio Revolution-7.1 at 0xe400, irq 5
[root@athlon ~]# cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/hw_params
closed
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/prealloc
256
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/status
closed
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/sw_params
closed
[root@athlon ~]#    

Info on/from /proc/asound/ END

--------------------------------------------------------------------------------

Output of 'lspci -v' BEGIN

[root@athlon ~]# lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller (rev 14)
        Flags: bus master, medium devsel, latency 32
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Memory at eb100000 (32-bit, prefetchable) [size=4K]
        I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP
Bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=256]
        Memory at eb104000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb101000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver, audio section)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb102000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:0c.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
        Subsystem: VIA Technologies Inc. M-Audio Revolution 7.1
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at e400 [size=32]
        I/O ports at e800 [size=128]
        Capabilities: [80] Power Management version 1

00:0f.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 02)
        Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at eb103000 (32-bit, prefetchable) [size=4K]
        I/O ports at ec00 [size=32]
        Memory at eb000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at eb105000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb106000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb107000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage 128 AIW AGP
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ
5
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        I/O ports at c000 [size=256]
        Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 1

[root@athlon ~]#

Output of 'lspci -v' END

--------------------------------------------------------------------------------


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001187 Gain control for M-Audio Revolution (an...
has duplicate       0001205 Mark M-Audio Revolution 7.1 (and probab...
has duplicate       0001164 aoss + skype: volume_adjust: SOUND_MIXE...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-23-05 10:43 
----------------------------------------------------------------------
Sigh, these many threads came just from a misunderstanding of the term
"capture".  What the reporter wants is the "loopback (from capture)", not
the capture we (audio deveopers) usually call.
As Peter and Lee mentioned, the loopback controls are often (or in almost
100% cases) implemented independently from the real capture (aka
recording).

On ICE1724, the loopback can be enabled by setting the "H/W Playback
Route" control.  You'll see controls "H/W", "H/W1".."H/W7" in alsamixer. 
They are the routing of each channel 0-7.
You can choose independently the playback source from either the
corresponding PCM channel, analog input or SPDIF input.  Change H/W and
H/W1 to H/W In 0 and H/W In 1 via up/down key.

----------------------------------------------------------------------
 sst4 - 06-26-05 01:21 
----------------------------------------------------------------------
Takashi,
thanks for your reply.

Do I understand correctly that the same effect can also be achieved by:

1)
amixer cset numid=5 1
amixer cset numid=6 2

2)
alsactl store

manually editing /etc/asound.state to make control.5, control.6 pieces
look
this way:

        control.5 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 'PCM Out'
                comment.item.1 'H/W In 0'
                comment.item.2 'H/W In 1'
                comment.item.3 'IEC958 In L'
                comment.item.4 'IEC958 In R'
                iface MIXER
                name 'H/W Playback Route'
                value 'H/W In 0'
        }
        control.6 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 'PCM Out'
                comment.item.1 'H/W In 0'
                comment.item.2 'H/W In 1'
                comment.item.3 'IEC958 In L'
                comment.item.4 'IEC958 In R'
                iface MIXER
                name 'H/W Playback Route'
                index 1
                value 'H/W In 1'
        }

- the enabling capture loopback lines are:

                value 'H/W In 0'
                value 'H/W In 1'
?

Thanks,
  Sergei.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 21:28 sst4           New Issue                                    
05-07-05 22:24 sst4           Note Added: 0004607                          
05-19-05 23:51 sst4           Note Added: 0004696                          
05-24-05 11:56 tiwai          Note Added: 0004710                          
05-24-05 22:01 sst4           Note Added: 0004732                          
06-02-05 00:03 sst4           Note Added: 0004871                          
06-15-05 15:28 tiwai          Note Added: 0005033                          
06-16-05 14:59 perex          Relationship added       related to 0001187  
06-22-05 01:47 rlrevell       Relationship added       has duplicate 0001205
06-22-05 01:48 rlrevell       Relationship added       has duplicate 0001164
06-22-05 01:49 rlrevell       Relationship replaced    has duplicate 0001187
06-22-05 18:16 tiwai          Note Added: 0005141                          
06-22-05 23:28 sst4           Note Added: 0005155                          
06-23-05 00:07 rlrevell       Note Added: 0005156                          
06-23-05 00:21 sst4           Note Added: 0005157                          
06-23-05 00:32 rlrevell       Note Added: 0005158                          
06-23-05 01:01 sst4           Note Added: 0005159                          
06-23-05 01:13 rlrevell       Note Added: 0005160                          
06-23-05 01:30 sst4           Note Added: 0005161                          
06-23-05 08:18 pzad           Note Added: 0005163                          
06-23-05 10:43 tiwai          Note Added: 0005164                          
06-26-05 01:21 sst4           Note Added: 0005259                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
