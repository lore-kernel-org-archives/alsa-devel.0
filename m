From: "Peter Hartman" <peterjohnhartman@gmail.com>
Subject: hda intel intermittent on a MX6920 Gateway
Date: Thu, 12 Oct 2006 08:41:02 -0500
Message-ID: <c36f61790610120641i352881f2m88bd599916f3eb6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi folks,

I haven't been able to get my snd hda intel driver to work
consistently on my new laptop; check the alsa-users list for my
previous posts (and they directed me here).  My setup:

1. alsa-utils-1.0.13, alsa-driver-1.0.13; alsa-lib-1.0.13;
alsa-headers-1.0.13.  (Although, I get the same problems with
alsa-*-1.0.11 which is Gentoo's default.)

2. Gentoo linux.  (I'm using the gentoo packages, but I get the same
results compiling from scratch.)

3. Kernel: linux-2.6.17-gentoo-r8

Issue: Sound will sometimes work, and sometimes not work, although my
programs don't give an error message, i.e., it acts like it is
playing, but no sound comes out.  When sound doesn't work (on certain
bootups), if I run "/etc/init.d/alsasound restart" (which essentially
unloads/loads the snd-hda-intel etc modules) a random number (between
3 and 8 usually) of times, sound starts working.  In cases where sound
IS working, my alsamixer lists only Master; in cases where sound is
not working, I get 4 settings (Master, Caller I, Off-Hook, SPDIF).
(Note: With 1.0.11, in the NOT WORKING alsamixer has Master and SPDIF,
Caller I and Off-Hook are only in 1.0.13, so I don't suspect they are
at issue.)

My lsmod:
snd_pcm_oss            34144  0
snd_mixer_oss          13824  1 snd_pcm_oss
snd_seq_oss            26624  0
snd_seq_device          5256  1 snd_seq_oss
snd_seq_midi_event      5504  1 snd_seq_oss
snd_seq                40944  4 snd_seq_oss,snd_seq_midi_event
snd_hda_intel          13656  0
snd_hda_codec         144576  1 snd_hda_intel
snd_pcm                58244  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              15748  2 snd_seq,snd_pcm
snd                    40228  9
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq_device,snd_seq,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          6856  2 snd_hda_intel,snd_pcm

My lspci -v:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Aud
io Controller (rev 02)
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, fast devsel, latency 0, IRQ 21
       Memory at d8240000 (64-bit, non-prefetchable) [size=16K]
       Capabilities: [50] Power Management version 2
       Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable
-
       Capabilities: [70] Express Unknown type IRQ 0
       Capabilities: [100] Virtual Channel
       Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (r
ev 02) (prog-if 00 [Normal decode])
       Flags: bus master, fast devsel, latency 0
       Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
       I/O behind bridge: 00002000-00002fff
       Memory behind bridge: d4000000-d5ffffff
       Prefetchable memory behind bridge: 00000000d0000000-00000000d1f00000
       Capabilities: [40] Express Root Port (Slot+) IRQ 0
       Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable
-
       Capabilities: [90] #0d [0000]
       Capabilities: [a0] Power Management version 2
       Capabilities: [100] Virtual Channel
       Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (r
ev 02) (prog-if 00 [Normal decode])
       Flags: bus master, fast devsel, latency 0
       Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
       I/O behind bridge: 00003000-00003fff
       Memory behind bridge: d6000000-d7ffffff
       Prefetchable memory behind bridge: 00000000d2000000-00000000d3f00000
       Capabilities: [40] Express Root Port (Slot+) IRQ 0
       Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable
-
       Capabilities: [90] #0d [0000]
       Capabilities: [a0] Power Management version 2
       Capabilities: [100] Virtual Channel
       Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev
02) (prog-if 00 [UHCI])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 20
       I/O ports at 1820 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev
02) (prog-if 00 [UHCI])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 18
       I/O ports at 1840 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev
02) (prog-if 00 [UHCI])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 19
       I/O ports at 1860 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev
02) (prog-if 00 [UHCI])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 17
       I/O ports at 1880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Control
ler (rev 02) (prog-if 20 [EHCI])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 20
       Memory at d8444000 (32-bit, non-prefetchable) [size=1K]
       Capabilities: [50] Power Management version 2
       Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if
01 [Subtractive decode])
       Flags: bus master, fast devsel, latency 0
       Bus: primary=00, secondary=04, subordinate=05, sec-latency=32
       I/O behind bridge: 00004000-00004fff
       Memory behind bridge: d8000000-d80fffff
       Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
       Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (re
v 02)
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0
       Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (re
v 02) (prog-if 8a [Master SecP PriP])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, medium devsel, latency 0, IRQ 18
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at 1810 [size=16]

00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA
 Storage Controller AHCI (rev 02) (prog-if 01 [AHCI 1.0])
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
       I/O ports at 18d0 [size=8]
       I/O ports at 18c4 [size=4]
       I/O ports at 18c8 [size=8]
       I/O ports at 18c0 [size=4]
       I/O ports at 18b0 [size=16]
       Memory at d8444400 (32-bit, non-prefetchable) [size=1K]
       Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable
-
       Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
       Subsystem: Gateway 2000 Unknown device 0366
       Flags: medium devsel, IRQ 10
       I/O ports at 18e0 [size=32]


Thanks,
Peter

Update:

Whenever I run /etc/init.d/alsasound and it starts working, I get the following:


/usr/sbin/alsactl: set_control:991: warning: name mismatch (SPDIF
Playback Switch/Off-hook Switch) for control #3
/usr/sbin/alsactl: set_control:993: warning: index mismatch (0/0) for control #3
/usr/sbin/alsactl: set_control:1099: bad control.3.value index

"lsmod" lists the exact same number of modules.

Hope this helps someone narrow it down.

Peter

-- 

gpg  1024D/ED6EF59B  (7D1A 522F D08E 30F6 FA42  B269 B860 352B ED6E F59B)
gpg --keyserver pgp.mit.edu --recv-keys ED6EF59B

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
