From: Ondrej Zary <linux@rainbow-software.org>
Subject: Undocumented Sound Blaster 16 extended mixer registers
Date: Tue, 15 May 2012 22:01:13 +0200
Message-ID: <201205152201.17928.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 76A0F10436E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 22:01:58 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
while playing with various SB16 types, found that the newer types have some 
extended mixer registers that aren't documented anywhere. Windows 9x driver 
detects and uses them so e.g. Auxiliary input appears when using CT2511-based 
card, MIDI mute becomes available on some cards, etc.

Chips tested:
CT1746B+CT1745A: SB16 SCSI
CT1747+CT1745A: SB16 IDE
CT2504: Vibra 16S
CT2505: Vibra 16C (PnP)
CT2511: Vibra 16XV (PnP)
CT8920: AWE64 (the last one with integrated mixer) (PnP)

Registers found:
----------------
0x48: Output switches 2
	all supported bits are set after reset
	(0x1f on CT2505 and CT8920, 0x7f on CT2511)
	bit 0: PC Speaker
	bit 1: PCM
	bit 2: PCM
	bit 3: MIDI
	bit 4: MIDI
	bit 5: AUX (CT2511 only, zero otherwise)
	bit 6: AUX (CT2511 only, zero otherwise)
	bit 7: unused (always zero)
0x49: Master switches
	all supported bits are set after reset
	(0x0f on CT2511, 0x0c on CT8920)
	bit 0: capture
	bit 1: capture
	bit 2: playback
	bit 3: playback
	bits 4..7: unused (always zero)
0x4a: Input switches 2
	zero after reset
	bit 0: PCM
	bit 1: PCM
	bit 2: AUX (CT2511 only, zero otherwise)
	bit 3: AUX (CT2511 only, zero otherwise)
	bits 4..7: unused (always zero)
0x4b: ??
	0x63 after reset (on CT2511 and CT8920)
	bits 0..5 writable

CT2511 also provides two additional volume controls:
0x50,0x51: Master Capture Volume (bits 7..3)
	reads as 0xE0 after reset when present
0x52,0x53: AUX Volume (bits 7..3)
	reads as 0xC0 after reset when present

There are no extended registers on the older cards (CT1746B+CT1745A,
CT1747+CT1745A and CT2504). CT2505 implements only 0x48.

AUX is an additional input, used at least on SF16-FMD2 card to connect 
integrated FM tuner.

I'm going to prepare a patch that allows sb16 driver to detect these 
additional controls and enable them if found.

However, I still haven't found how Windows driver detects Bass/Treble control 
presence. All chips have the bass/treble registers (0x44-0x47) present and 
writable but they have no effect on all Vibra chips except CT2502 (which I 
don't have). There must be some other register which says that bass/treble 
controls are not available.

-- 
Ondrej Zary
