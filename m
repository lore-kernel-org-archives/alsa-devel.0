From: Nicolas Pitre <nico@cam.org>
Subject: intel8x0 on a GA-K8VT800 Pro motherboard
Date: Tue, 18 Jan 2005 16:57:52 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0501181636350.5130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have a Giga-byte GA-K8VT800 Pro Motherboard which has:

00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
	Subsystem: Giga-byte Technology: Unknown device af12
	Flags: fast devsel, IRQ 209
	Memory at f20c0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

The PCI ID for it is:

00:1b.0 Class 0403: 8086:2668 (rev 03)

Looking at the intel8x0 driver the nearest entry I could find is:

{ 0x8086, 0x266e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH6 */

So, I just added another entry for 0x8086:0x2668 and the driver loaded, 
but failed with:

ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1b.0 to 64
codec_ready: codec is not ready [0x8080808]
Intel ICH: probe of 0000:00:1b.0 failed with error -5

Does anyone have a hint about what could be missing at this point?


Nicolas


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
