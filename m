From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000224]: modul snd-via82xx from alsa-driver 0.9.8 and 1.0.3 fails to load
Date: Tue, 30 Aug 2005 12:19:59 +0200
Message-ID: <242e8e4db5832c7bfa1ce591aa7386c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 566861C7
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:20:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=224> 
======================================================================
Reported By:                deepspace9
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   224
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.24 and 2.6.4
======================================================================
Date Submitted:             04-20-2004 08:03 CEST
Last Modified:              08-30-2005 12:19 CEST
======================================================================
Summary:                    modul snd-via82xx from alsa-driver 0.9.8 and 1.0.3
fails to load
Description: 
After installing the alsa-driver package to get sound I found that trying
to load snd-via82xx.o fails with the following message:

/lib/modules/2.4.24-ppc-dev-r2/kernel/sound/pci/snd-via82xx.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.24-ppc-dev-r2/kernel/sound/pci/snd-via82xx.o: insmod
/lib/modules/2.4.24-ppc-dev-r2/kernel/sound/pci/snd-via82xx.o: failed
/lib/modules/2.4.24-ppc-dev-r2/kernel/sound/pci/snd-via82xx.o: insmod
snd-via82xx.o failed

The lspci -v command say:

Multimedia audio Controller: VIA Technologies, Inc. VT82C686 AC97 Audio
Controller (rev 40)
Flags: medium devsel, IRQ 9
I/O ports at 1300 [size=256]
I/O ports at 1138 [size=4]
I/O ports at 113c [size=4]
Capabilities: [c0] Power Management version 2


Hardware config:

Pegasos II G3 600
512MB Ram
Dawicontrol 2976 UW ( SCSI Controller )

 
lsmod:

Module                  Size  Used by    Not tainted
usbcore                66584   1 
via-rhine              17832   1 
mii                     3072   0  [via-rhine]
crc32                   3072   0  [via-rhine]

emerge info:

Gentoo Base System version 1.4.3.13
Portage 2.0.50-r1 (default-ppc-1.4, gcc-3.2.3, glibc-2.3.2-r9,
2.4.24-ppc-dev-r2)
=================================================================
System uname: 2.4.24-ppc-dev-r2 ppc 745/755
Autoconf: sys-devel/autoconf-2.58-r1
Automake: sys-devel/automake-1.7.8
ACCEPT_KEYWORDS="ppc"
AUTOCLEAN="yes"
CFLAGS="-O3 -pipe -mcpu=750"
CHOST="powerpc-unknown-linux-gnu"
COMPILER="gcc3"
CONFIG_PROTECT="/etc /usr/X11R6/lib/X11/xkb /usr/kde/2/share/config
/usr/kde/3.2/share/config /usr/kde/3/share/config /usr/share/config
/var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/env.d"
CXXFLAGS="-O3 -pipe -mcpu=750"
DISTDIR="/mnt/distfiles/distfiles"
FEATURES="ccache"
GENTOO_MIRRORS="http://gentoo.oregonstate.edu
http://www.ibiblio.org/pub/Linux/distributions/gentoo"
MAKEOPTS="-j2"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY=""
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="X alsa arts berkdb cdr cups directfb dvd dvdr encode esd foomaticdb
gdbm gif gpm gtk gtk2 icq imlib ipv6 java joystick jpeg kde libg++ libwww
linguas_de mad mikmod mitshm motif mozilla mpeg ncurses nls oggvorbis
opengl pam pdflib perl png ppc python qt quicktime readline samba sdl
slang snmp socks5 ssl tcpd tiff truetype usb voodoo3 xml xmms xv zlib"

lspci -v:

00:00.0 Host bridge: Marvell: Unknown device 6460 (rev 03)
	Subsystem: Unknown device 0020:0000
	Flags: bus master, fast devsel, latency 0
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)

00:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Flags: medium devsel, IRQ 9
	Memory at 80000800 (32-bit, non-prefetchable) [disabled] [size=2K]
	I/O ports at 1180 [disabled] [size=128]
	Capabilities: [50] Power Management version 2

00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
	Subsystem: Creative Labs SBLive! 5.1 Digital Model SB0220
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1200 [size=32]
	Capabilities: [dc] Power Management version 1

00:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Flags: medium devsel
	I/O ports at 1130 [disabled] [size=8]
	Capabilities: [dc] Power Management version 1

00:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
26)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1000 [size=256]
	Memory at 80000000 (32-bit, non-prefetchable) [size=256]
	Memory at 80001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80010000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 1

00:0c.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev
10)
	Flags: bus master, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:0c.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8f [Master SecP SecO PriP PriO])
	Flags: bus master, medium devsel, latency 0, IRQ 14
	I/O ports at 1100 [size=8]
	I/O ports at 110c [size=4]
	I/O ports at 1110 [size=8]
	I/O ports at 111c [size=4]
	I/O ports at 1120 [size=16]
	Capabilities: [c0] Power Management version 2

00:0c.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 1e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 22, IRQ 9
	I/O ports at 1140 [size=32]
	Capabilities: [80] Power Management version 2

00:0c.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 1e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 22, IRQ 9
	I/O ports at 1160 [size=32]
	Capabilities: [80] Power Management version 2

00:0c.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:0c.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 40)
	Flags: medium devsel, IRQ 9
	I/O ports at 1300 [size=256]
	I/O ports at 1138 [size=4]
	I/O ports at 113c [size=4]
	Capabilities: [c0] Power Management version 2

00:0c.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97
Modem] (rev 20)
	Flags: medium devsel, IRQ 9
	I/O ports at 1400 [disabled] [size=256]
	Capabilities: [d0] Power Management version 2

00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
51)
	Subsystem: Unknown device 3065:1106
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1500 [size=256]
	Memory at 80000100 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

10:00.0 Host bridge: Marvell: Unknown device 6460 (rev 03)
	Subsystem: Unknown device 0020:0000
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Capabilities: [20] #20 [0000]

10:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200
SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: Yuan Yuan Enterprise Co., Ltd.: Unknown device 5964
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at fffef000 [size=256]
	Memory at d0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d0020000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

I hope this help...


======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-04 17:27 
----------------------------------------------------------------------
first, try ALSA 1.0.4.  and check any kernel messages whether any
resource conflict exists.

----------------------------------------------------------------------
 jdthood - 08-30-05 12:19 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-04 08:03 deepspace9     New Issue                                    
04-20-04 08:03 deepspace9     Kernel Version            => 2.4.24 and 2.6.4
04-23-04 17:27 tiwai          Note Added: 0000906                          
04-23-04 17:30 tiwai          Status                   new => assigned     
04-23-04 17:30 tiwai          Assigned To               => tiwai           
08-30-05 12:19 jdthood        Note Added: 0005971                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
