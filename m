From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Subject: Results of test of p16v patch with audigy2.
Date: Fri, 7 Jan 2005 16:52:42 +0300
Message-ID: <20050107135242.GA7424@school.ioffe.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello,

Please correct me, if this is wrong place to report this.

Today I tried testing p16v patch from
http://www.alsa-project.org/~james/p16v/ with alsa 1.0.8rc2 and my
Audigy2. After patching, snd-emu10k1 module compiled & loaded
succesfully, but when I tried to play self-made SE32_LE @ 96Khz wav
file, I got no sound from analog output & a lot of messages in the kernel log
(attached log of modprobe snd-emu10k1, aplay -D hw:0,3 test.wav; rmmod snd-emu10k1
). I'm using kernel 2.6.9 on Debian sid.

Here is relevant part of lspci -v:
=== Cut here ===
0000:02:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs: Unknown device 1007
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c400 [size=64]
        Capabilities: [dc] Power Management version 2

0000:02:08.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Flags: bus master, medium devsel, latency 32
        I/O ports at c800 [size=8]
        Capabilities: [dc] Power Management version 2

0000:02:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Flags: bus master, medium devsel, latency 32, IRQ 12
        Memory at d8004000 (32-bit, non-prefetchable) [size=2K]
        Memory at d8000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
=== Cut here ===

Feel free to contact me, if you need more information.

BTW: p16v.c  mentions, that Audigy2 chip should be CA0102-IAT, but I have
CA0102-ICT on my card.

-- 
With best wishes
Dmitry Baryshkov

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="ph.log"

ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c:148: snd_p16v_pcm calling.
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:586: snd_p16v_pcm called. device=3
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:611: preallocate playback substream: err=0
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:333: epcm kcalloc: c33cc094
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:339: epcm device=3, channel_id=0
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:379: hw_params alloc: substream=c7f4f1b4
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:382: hw_params alloc: result=1
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:408: prepare:channel_number=3, rate=96000, format=0xa, channels=2, buffer_size=4096, period_size=1024, periods=4, frames_to_bytes=8
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:409: dma_addr=5de0000, dma_area=c5de0000, table_base=c4ffb180
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:410: dma_addr=4ffb000, dma_area=c4ffb000, dma_bytes(size)=400
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:500: channel=3
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:506: basic=0x8, inte=0x8000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/irq.c:137: emu10k1: unhandled interrupt: 0x80000000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:500: channel=3
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:506: basic=0x8, inte=0x8000
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:391: hw_params free: substream=c7f4f1b4
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:393: hw_params free: result=0
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:391: hw_params free: substream=c7f4f1b4
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:393: hw_params free: result=0
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:319: epcm free: c33cc094
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:574: snd_p16v_pcm_free pcm: called
ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/emu10k1/p16v.c:566: period lables free: c11ce078

--IS0zKkzwUGydFO0o--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
