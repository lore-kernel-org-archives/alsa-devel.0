From: Martin Dausel <dauselm@emt.iis.fhg.de>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: Thu, 13 Nov 2003 11:10:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB35888.60606@emt.iis.fhg.de>
References: <200311121803.hACI3aQC023763@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311121803.hACI3aQC023763@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 1) just a quick note to point out that whether you know it or not, the
> email program you are using is sending out copies of your mail in both
> plain text and HTML formats. increasingly on the net, there are
> filters being put in place that silently dump HTML-formatted
> email. some mailing lists will not ever accept such posts. as long as
> you do this, you are (1) wasting network bandwidth by sending messages
> that are typically more than twice as long as they could be (2) making
> it harder for people using traditional email readers to read them (3)
> risking the chance that people will never see your mail because its
> filtered before reaching their email inbox.
> 
> 2) as requested, please send the output of lspci -v
> 

1)
I reprimand my email program and hope it will never ever do it again ;-)

2)
here is the output of lspci -v

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
	Subsystem: Unknown device 1734:101b
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [0106]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2572 (rev 
02) (prog-if 00 [VGA])
	Subsystem: Unknown device 1734:101b
	Flags: bus master, fast devsel, latency 0, IRQ 9
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1000 [size=8]
	Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1400 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1c00 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 2000 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02) 
(prog-if 20 [EHCI])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 9
	Memory at e0080000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) 
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: e0100000-e1ffffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) 
(prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1734:101c
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 2800 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Unknown device 1734:101c
	Flags: medium devsel, IRQ 5
	I/O ports at 2400 [size=32]

03:05.0 Multimedia audio controller: Xilinx Corporation RME Digi9652 
(Hammerfall) (rev 03)
	Flags: bus master, stepping, slow devsel, latency 64, IRQ 5
	Memory at e1000000 (32-bit, non-prefetchable) [size=16M]

03:08.0 Ethernet controller: Intel Corp.: Unknown device 1051 (rev 02)
	Subsystem: Unknown device 1734:101a
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at e0100000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2






-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
