From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Intel HDA 82801G
Date: Tue, 3 Oct 2006 12:55:34 +0200
Message-ID: <20061003105534.GA13274@trinnov.com>
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

Hello,

I've recently installed alsa drivers 1.0.13 on my laptop (its brand is Medion),
and I don't get the sound to work on it. I saw a recent post on this subject
(somedy having the same card as me), but I didn't see a follow-up after the
first answer, so I'm sending this email.

lspci -nv says:
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 161f:2054
        Flags: fast devsel, IRQ 21
        Memory at d5300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Codec info:
* vendor 0x10ec0883, subsystem 0x161fd82b, revision 0x100002
* vendor 0x11c11040, subsystem 0x11c10001, revision 0x100200
I think the second one is the modem part (which I would like to get working
too, but I think the two problems are linked together).

The card is seen as an hda-intel, but the driver fails to initialize it. A
previous version of the alsa driver (1.0.11) successfuly loaded the hda-intel
driver (but telling that it was an unknown model), but I got no sound (of
course I chcked the mixer settings). With 1.0.13, I get the following driver
messages:

Oct  3 11:20:36 localhost ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
Oct  3 11:20:36 localhost PCI: Setting latency timer of device 0000:00:1b.0 to 64
Oct  3 11:20:36 localhost hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
Oct  3 11:20:36 localhost ALSA /usr/local/src/alsa-driver-1.0.13/pci/hda/hda_codec.c:607: HDA: codec info: vendor 0x10ec0883, subsystem 0x161fd82b, revision 0x100002
Oct  3 11:20:38 localhost ALSA /usr/local/src/alsa-driver-1.0.13/pci/hda/hda_codec.c:607: HDA: codec info: vendor 0x11c11040, subsystem 0x11c10001, revision 0x100200
Oct  3 11:20:38 localhost ALSA /usr/local/src/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245: si3054: cannot initialize. EXT MID = 0000
Oct  3 11:20:38 localhost HDA Intel: probe of 0000:00:1b.0 failed with error -13

The two "HDA: codec info" lines were added by me to see the info on the
detected codecs (the /proc/asound/card0/codec* files are not available as the
card is not recognized)

I tried the model=acer option of the driver as suggested several times on this
list, but with no success (and with both versions of alsa).

Thank you,

Remy Bruno


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
