From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: uhci.c Fix for an UHCI error -EILSEQ on a VIA Controller during BULK IN transfer
Date: Fri, 22 Aug 2003 14:50:50 +0200
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <200308221450.50730.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>
List-Id: alsa-devel@alsa-project.org

hi Maintainers,

I'm developing a driver for the tascam us428 audio/midi controller. it works 
on intel USB BX440 Host controller, but has problems with one VIA USB 
Controller (others unknown).
kernel is 2.4.21. module is uhci. (usb-uhci behaves similarly.)

the error shows up like this:
uhci.c: uhci_result_interrupt/bulk() failed with status 440000
[cf7a50c0] link (0f7a5092) element (02ecf1e0)
  0: [c2ecf1e0] link (00000001) e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=3f 
DT0 EndPt=6 Dev=2, PID=69(IN) (buf=0e01cc54)

the FIX is to initialise status in uhci_submit_bulk() like this:
/* 3 errors if there is a timeout else 0; 
   UHCI Spec says: 0 == unlimited errors
   VIA-chip 1106:3038 needs 0 for urbs that should not timeout!
   */
status = TD_CTRL_ACTIVE | ((urb->timeout ? 3 : 0) << TD_CTRL_C_ERR_SHIFT);

the urb in question should stay in the queue until the extern midi device 
submits an event.
It seams intels HC ignores the spec, while Via's obeys here?

Please apply the fix in uhci.c, usb-uhci.c and for 2.6!

thanks, karsten

some details:

lspci -n for the VIA Board:
00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 1a)
00:07.3 Class 0c03: 1106:3038 (rev 1a)
00:07.4 Class 0680: 1106:3057 (rev 40)
00:07.5 Class 0401: 1106:3058 (rev 50)
00:09.0 Class 0100: 1000:000f (rev 03)
00:0a.0 Class 0200: 8086:1229 (rev 08)
01:00.0 Class 0300: 1002:4c42 (rev dc)

lspci -v for the VIA Board:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Flags: bus master, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=32M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e2000000-e3ffffff
        Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 
IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d400 [size=32]
        Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d800 [size=32]
        Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 9
        Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
        Flags: medium devsel, IRQ 10
        I/O ports at dc00 [size=256]
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=4]
        Capabilities: <available only to root>

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)
        Flags: bus master, medium devsel, latency 134, IRQ 11
        I/O ports at e800 [size=256]
        Memory at e4202000 (32-bit, non-prefetchable) [size=256]
        Memory at e4201000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e4200000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ec00 [size=64]
        Memory at e4000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 
(rev dc) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage LT Pro AGP 2X
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 5
        Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at c000 [size=256]
        Memory at e3020000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
