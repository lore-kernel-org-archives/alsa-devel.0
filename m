From: Martin Wilhelm <wilhelmm@emt.iis.fhg.de>
Subject: snd-rme9652 fails
Date: Wed, 17 Dec 2003 11:10:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE02BA2.8020900@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Martin Dausel <dauselm@emt.iis.fhg.de>
List-Id: alsa-devel@alsa-project.org

Hi,


according to martin dausel's posting some weeks ago, I can
confirm, that since alsa-0.9.8 was released, the "old" rme-9652
cards are no longer working.
This is very strange, because the driver was not changed... :(
And: The OSS-kernelmod (rme96xx) works fine!

Here's some output (long lines not wrapped):

lspci:
----------------------------------------------------------------
[root@il028 /]# lspci -v
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge (rev 01)
         Subsystem: Unknown device 1734:1003
         Flags: bus master, fast devsel, latency 0
         Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [e4] #09 [4105]

00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G]
Chipset Integrated Graphics Device (rev 01) (prog-if 00 [VGA])
         Subsystem: Unknown device 1734:1003
         Flags: bus master, fast devsel, latency 0, IRQ 9
         Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
         Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
(prog-if 00 [UHCI])
         Subsystem: Unknown device 1734:1004
         Flags: bus master, medium devsel, latency 0, IRQ 9
         I/O ports at 1000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
(prog-if 00 [UHCI])
         Subsystem: Unknown device 1734:1004
         Flags: bus master, medium devsel, latency 0, IRQ 11
         I/O ports at 1400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
(prog-if 00 [UHCI])
         Subsystem: Unknown device 1734:1004
         Flags: bus master, medium devsel, latency 0, IRQ 10
         I/O ports at 1800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20
[EHCI])
         Subsystem: Unknown device 1734:1004
         Flags: bus master, medium devsel, latency 0, IRQ 9
         Memory at d0080000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
         Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 81)
(prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 00003000-00003fff
         Memory behind bridge: d0100000-d1ffffff

00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 01)
         Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller
(rev 01) (prog-if 8a [Master SecP PriP])
         Subsystem: Unknown device 1734:1004
         Flags: bus master, medium devsel, latency 0
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at 2000 [size=16]
         Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
         Subsystem: Unknown device 1734:1004
         Flags: medium devsel, IRQ 5
         I/O ports at 1c00 [size=32]

02:05.0 Multimedia audio controller: Xilinx Corporation RME Digi9652
(Hammerfall) (rev 03)
         Flags: bus master, stepping, slow devsel, latency 64, IRQ 5
         Memory at d1000000 (32-bit, non-prefetchable) [size=16M]

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM)
Ethernet Controller (rev 81)
         Subsystem: Unknown device 1734:1001
         Flags: bus master, medium devsel, latency 66, IRQ 11
         Memory at d0100000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at 3000 [size=64]
         Capabilities: [dc] Power Management version 2

[root@il028 /]#
----------------------------------------------------------------

Alsa-Try:
----------------------------------------------------------------
[root@il028 /]# modprobe snd-rme9652
/lib/modules/2.4.23-uv1-AEMT/kernel/sound/pci/rme9652/snd-rme9652.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
       You may find more information in syslog or the output from dmesg
modprobe: insmod
/lib/modules/2.4.23-uv1-AEMT/kernel/sound/pci/rme9652/snd-rme9652.o failed
modprobe: insmod snd-rme9652 failed
[root@il028 /]#

[root@il028 /]# dmesg
RME Digi9652/Digi9636: no cards found
[root@il028 /]#
----------------------------------------------------------------


OSS-Try:
----------------------------------------------------------------
[root@il028 /]# modprobe rme96xx
Warning: loading
/lib/modules/2.4.23-uv1-AEMT/kernel/drivers/sound/rme96xx.o will taint
the kernel: no license
   See http://www.tux.org/lkml/#export-tainted for information about
tainted modules
Module rme96xx loaded, with warnings
[root@il028 /]#

[root@il028 /]# dmesg
rme96xx: version 0.8 time 08:58:37 Dec 17 2003
rme96xx: reserving 1 dsp device(s)
rme96xx: detected RME Digi9652 (Rev 1.5) (hw_rev 15)
rme96xx: card 1 initialized
[root@il028 /]#
----------------------------------------------------------------


Some other Infos:
* "Affected" Kernels: 2.4.22, 2.4.23, 2.4.23-uv1.
* "Affected" Alsa-Versions: 0.9.8, 1.0.0betaX, 1.0.0rcX.

More on request ...


So long and thanks for any help,
Wico

-- 
+                                  -                                +
| Martin Wilhelm                                                    |
| Fraunhofer IIS - Arbeitsgruppe EMT Ilmenau                        |
| mailto:wilhelmm@emt.iis.fhg.de                                    |
| Tel. (privat): +49 (0)3677 208655                                 |
| Tel. (dienst): +49 (0)3677 789143                                 |
+                                  -                                +







-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
