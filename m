From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: capture EXTINs with multichannel device
Date: Tue, 01 Feb 2005 22:03:52 -0500
Message-ID: <1107313433.3225.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch changes the emu10k1 multichannel capture device (hw:x,2) to
capture the 16 external inputs by default.  This involves adding DSP
code to route the EXTINs to the FXBUS2 (EFX capture) channels and
setting the corresponding FXWC bits by default.

This allows capturing multiple inputs simultaneously.  It completely
bypasses the capture controls of the mixer.  With my Audigy2 ZS I can
capture LineIn, Line2, and Aux2 at the same time (6 channels).

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa-default/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.53
diff -u -r1.53 emu10k1.h
--- alsa-default/alsa-kernel/include/emu10k1.h	22 Nov 2004 18:42:01 -0000	1.53
+++ alsa-default/alsa-kernel/include/emu10k1.h	2 Feb 2005 02:16:42 -0000
@@ -1112,7 +1112,10 @@
 /* GPRs */
 #define FXBUS(x)	(0x00 + (x))	/* x = 0x00 - 0x0f */
 #define EXTIN(x)	(0x10 + (x))	/* x = 0x00 - 0x0f */
-#define EXTOUT(x)	(0x20 + (x))	/* x = 0x00 - 0x0f */
+#define EXTOUT(x)	(0x20 + (x))	/* x = 0x00 - 0x0f physical outs -> FXWC low 16 bits */
+#define FXBUS2(x)	(0x30 + (x))	/* x = 0x00 - 0x0f copies of fx buses for capture -> FXWC high 16 bits */
+					/* NB: 0x31 and 0x32 are shared with Center/LFE on SB live 5.1 */
+
 #define C_00000000	0x40
 #define C_00000001	0x41
 #define C_00000002	0x42
@@ -1154,9 +1157,13 @@
 #define A_ITRAM_CTL(x)	(A_TANKMEMCTLREGBASE + 0x00 + (x)) /* x = 0x00 - 0xbf */
 #define A_ETRAM_CTL(x)	(A_TANKMEMCTLREGBASE + 0xc0 + (x)) /* x = 0x00 - 0x3f */
 
-#define A_FXBUS(x)	(0x00 + (x))	/* x = 0x00 - 0x3f? */
-#define A_EXTIN(x)	(0x40 + (x))	/* x = 0x00 - 0x1f? */
-#define A_EXTOUT(x)	(0x60 + (x))	/* x = 0x00 - 0x1f? */
+#define A_FXBUS(x)	(0x00 + (x))	/* x = 0x00 - 0x3f FX buses */
+#define A_EXTIN(x)	(0x40 + (x))	/* x = 0x00 - 0x0f physical ins */
+#define A_P16VIN(x)	(0x50 + (x))	/* x = 0x00 - 0x0f p16v ins (A2 only) "EMU32 inputs" */
+#define A_EXTOUT(x)	(0x60 + (x))	/* x = 0x00 - 0x1f physical outs -> A_FXWC1 0x79-7f unknown   */
+#define A_FXBUS2(x)	(0x80 + (x))	/* x = 0x00 - 0x1f extra outs used for EFX capture -> A_FXWC2 */
+#define A_EMU32OUTH(x)	(0xa0 + (x))	/* x = 0x00 - 0x0f "EMU32_OUT_10 - _1F" - ??? */
+#define A_EMU32OUTL(x)	(0xb0 + (x))	/* x = 0x00 - 0x0f "EMU32_OUT_1 - _F" - ??? */
 #define A_GPR(x)	(A_FXGPREGBASE + (x))
 
 /* cc_reg constants */
Index: alsa-default/alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.67
diff -u -r1.67 emufx.c
--- alsa-default/alsa-kernel/pci/emu10k1/emufx.c	28 Jan 2005 15:33:10 -0000	1.67
+++ alsa-default/alsa-kernel/pci/emu10k1/emufx.c	2 Feb 2005 02:16:45 -0000
@@ -1358,6 +1358,11 @@
 	A_PUT_OUTPUT(A_EXTOUT_ADC_CAP_R, capture+1);
 #endif
 
+	/* EFX capture - capture the 16 EXTINs */
+	for (z = 0; z < 16; z++) {
+		A_OP(icode, &ptr, iACC3, A_FXBUS2(z), A_C_00000000, A_C_00000000, A_EXTIN(z));
+	}
+	
 	/*
 	 * ok, set up done..
 	 */
@@ -1930,6 +1935,24 @@
 	if (emu->fx8010.extout_mask & (1<<EXTOUT_MIC_CAP))
 		OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_MIC_CAP), GPR(capture + 2), C_00000000, C_00000000);
 
+	/* EFX capture - capture the 16 EXTINS */
+	OP(icode, &ptr, iACC3, FXBUS2(14), C_00000000, C_00000000, EXTIN(0));
+	OP(icode, &ptr, iACC3, FXBUS2(15), C_00000000, C_00000000, EXTIN(1));
+	OP(icode, &ptr, iACC3, FXBUS2(0), C_00000000, C_00000000, EXTIN(2));
+	OP(icode, &ptr, iACC3, FXBUS2(3), C_00000000, C_00000000, EXTIN(3));
+	/* Dont connect anything to FXBUS2 1 and 2.  These are shared with 
+	 * Center/LFE on the SBLive 5.1.  The kX driver only changes the 
+	 * routing when it detects an SBLive 5.1.
+	 *
+	 * Since only 14 of the 16 EXTINs are used, this is not a big problem.  
+	 * We route AC97L and R to FX capture 14 and 15, SPDIF CD in to FX capture 
+	 * 0 and 3, then the rest of the EXTINs to the corresponding FX capture 
+	 * channel.
+	 */
+	for (z = 4; z < 14; z++) {
+		OP(icode, &ptr, iACC3, FXBUS2(z), C_00000000, C_00000000, EXTIN(z));
+	}
+
 	if (gpr > tmp) {
 		snd_BUG();
 		err = -EIO;
Index: alsa-default/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.35
diff -u -r1.35 emupcm.c
--- alsa-default/alsa-kernel/pci/emu10k1/emupcm.c	29 Nov 2004 14:09:47 -0000	1.35
+++ alsa-default/alsa-kernel/pci/emu10k1/emupcm.c	2 Feb 2005 02:16:46 -0000
@@ -1390,8 +1390,18 @@
 	if (rpcm)
 		*rpcm = pcm;
 
-	emu->efx_voices_mask[0] = FXWC_DEFAULTROUTE_C | FXWC_DEFAULTROUTE_A;
-	emu->efx_voices_mask[1] = 0;
+	/* EFX capture - record the "FXBUS2" channels, by default we connect the EXTINs 
+	 * to these
+	 */	
+	
+	/* emu->efx_voices_mask[0] = FXWC_DEFAULTROUTE_C | FXWC_DEFAULTROUTE_A; */
+	if (emu->audigy) {
+		emu->efx_voices_mask[0] = 0;
+		emu->efx_voices_mask[1] = 0xffff;
+	} else {
+		emu->efx_voices_mask[0] = 0xffff;
+		emu->efx_voices_mask[1] = 0;
+	}
 	snd_ctl_add(emu->card, snd_ctl_new1(&snd_emu10k1_pcm_efx_voices_mask, emu));
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
