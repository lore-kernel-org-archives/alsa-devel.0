From: "Rob J. Caskey" <rcaskey@arches.uga.edu>
Subject: [Fwd: Hey There, via82xx stuff]
Date: 08 Aug 2003 09:44:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060350259.8389.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-m4prY1rjMvoebWw0YqYt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-m4prY1rjMvoebWw0YqYt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Eek, lets see if this gets through this time! Silly university
funky-email-rewriter-thingy-and-absentee-list-admins!

--=-m4prY1rjMvoebWw0YqYt
Content-Disposition: inline
Content-Description: Forwarded message - Hey There, via82xx stuf
Content-Type: message/rfc822

Subject: Hey There, via82xx stuf
From: "Rob J. Caskey" <rcaskey@arches.uga.edu>
To: alsa-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1060269376.6681.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 07 Aug 2003 11:16:16 -0400
Content-Transfer-Encoding: 7bit

I bought a new KT333 Series2 MB which has the via8233a on board. I was
very exited to bring it home, having 5.1 channel audio and all that,
which is very important when your audio in source is only mono ;) Now
I've been having some pretty serious problems and people tell me to just
slide in another card, but at this point, it's the principle of the
thing!  Anyway, here is the story thus far. I get the same results from
both .90 from Debian's sid repository and from building my own .96.

ogle: everything works fine
xmame: everything is great
(so far, sounds like oss emulation os pretty swell)
kde (no arts): plays the first part of the startup sound, then repeats
it like 10 times and everything returns to normal
xmms: everything plays fine but if I close xmms it keeps playing the
last part of the sound (maby 1/4 a second worth?) over and over for a
bit and then everything returns to normal
myth-music: same as with xmms. also happens when I change tracks. never
tried to change tracks in xmms so I suppose its any time an audio stream
changes
mythtv: when I kick the sampling rate down to 32000 things almost work
correctly, I still get the occasional hitch every 5 seconds or so that
is so bad it is still unwatchable. When I put things up any higher it
gets totally unplayable. In .90 the thing would get slower and slower
and slower before just crashing out with some buffer error on the back
end, so .96 has helped here. DMA is on, disk throughput scores or
typical, and I have plenty of processing power. I can adjust the
recording resolution from 160x160 to 640x480 and cpu usage jumps way up
but it is still just as smooth as it was previously, even though its
crunching way more data (CPU utilization is still only in the mid 50%
and caps at low 60%) and I had the MythTV guru Chutt take a look at my
setup and he says it looks like a driver problem to him. 

I am really stumped, and don't have a clue. Any advice would be very
much appreciated.

Sincerely,
Rob J. Caskey

misc stuff that might be useful or not 
------
tv@l3ktr0n:~$ lsmod|grep snd
snd-seq-oss            28928   0 (unused)
snd-seq-midi-event      3584   0 [snd-seq-oss]
snd-seq                36656   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            38308   0
snd-mixer-oss          13336   0 [snd-pcm-oss]
snd-via82xx            13216   0
snd-pcm                61572   0 [snd-pcm-oss snd-via82xx]
snd-timer              14468   0 [snd-seq snd-pcm]
snd-ac97-codec         40632   0 [snd-via82xx]
snd-mpu401-uart         3376   0 [snd-via82xx]
snd-rawmidi            13984   0 [snd-mpu401-uart]
snd-seq-device          4304   0 [snd-seq-oss snd-seq snd-rawmidi]
snd                    31972   0 [snd-seq-oss snd-seq-midi-event snd-seq
snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3972   6 [bttv snd]
snd-page-alloc          6516   0 [snd-via82xx snd-pcm]

tv@l3ktr0n:~$ cat /proc/interrupts
           CPU0
  0:    7387713    IO-APIC-edge  timer
  1:          4    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:         13    IO-APIC-edge  lirc_serial
  8:          4    IO-APIC-edge  rtc
 14:     113996    IO-APIC-edge  ide0
 15:          8    IO-APIC-edge  ide1
 16:    4428101   IO-APIC-level  ehci-hcd, nvidia
 18:      55050   IO-APIC-level  VIA8233A, usb-ohci, bttv
 19:      26414   IO-APIC-level  usb-ohci, usb-uhci, usb-uhci, eth0
NMI:          0
LOC:    7387623
ERR:          0
MIS:          0

l3ktr0n:/home/tv# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dde00000-ddefffff
        Prefetchable memory behind bridge: cdc00000-cdcfffff
        Capabilities: [80] Power Management version 2
 
00:05.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at df000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at deff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
 
00:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: ATI Technologies Inc: Unknown device 0003
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at dddfe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
 
00:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: ATI Technologies Inc TV-Wonder/VE
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at dddff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
 
00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at d800 [size=128]
        Memory at defe7f80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at defc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
 
00:0b.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at defe5000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
 
00:0b.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at defe6000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
 
00:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
3504
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at defe7e00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
 
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev
01) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 1275
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 19
        I/O ports at ec00 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at dc00 [size=16]
        Memory at defec000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 1
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master
ATA133/100/66/33 IDE        Flags: bus master, medium devsel, latency
32, IRQ 16
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
 
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
 
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
 
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 40)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
4720
        Flags: medium devsel, IRQ 18
        I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2


--=-m4prY1rjMvoebWw0YqYt--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
