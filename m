From: Peter Chapman <x6pe9syq02@sneakemail.com>
Subject: module_init fails with OEM SoundBlaster Live!
Date: Sun, 2 Nov 2003 11:46:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031102114634.GA13679@gondolin.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I have an SBLive! which came with a Dell Dimension PC. The snd-emu10k1
module has been refusing to load ("EMU10K1/Audigy soundcard not found or
device busy"), however I found the following patch makes it work:

Index: alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.18
diff -u -r1.18 emumixer.c
--- alsa-kernel/pci/emu10k1/emumixer.c	23 Oct 2003 14:34:53 -0000	1.18
+++ alsa-kernel/pci/emu10k1/emumixer.c	2 Nov 2003 11:23:13 -0000
@@ -540,10 +540,6 @@
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
-		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_control, emu)) == NULL)
-			return -ENOMEM;
-		if ((err = snd_ctl_add(card, kctl)))
-			return err;
 	}
 
 	if (emu->audigy) {


By no coincidence I'm sure, I never got the spdif output on the card to
work. Perhaps it's a cut-down OEM version? I noticed a DELL OEM entry in
snd_emu10k1_ids[], but my card does not match that device id. Here is
the lspci output:

03:03.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

with lspci -n:
03:03.0 Class 0401: 1102:0002 (rev 07)
        Subsystem: 1102:8022
etc....

could a failure to add the spdif control be made non-fatal perhaps?

Thanks,
Pete Chapman


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
