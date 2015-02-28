From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [patch] emu1010: avoid pop noises
Date: Sat, 28 Feb 2015 19:41:10 +0000
Message-ID: <20150228194110.325716b92ca0d7195887f234@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
 [209.85.215.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B8B260541
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 17:41:17 +0100 (CET)
Received: by labgm9 with SMTP id gm9so23014542lab.2
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 08:41:16 -0800 (PST)
Received: from egoOne ([77.67.186.109])
 by mx.google.com with ESMTPSA id p7sm1537118lap.18.2015.02.28.08.41.13
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 28 Feb 2015 08:41:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix pop noises on startup and on poweroff.

Signed-off-by: Mihail Zenkov <mihail.zenkov@gmail.com>

--- linux-3.19/include/sound/emu10k1.h
+++ linux-3.19-1/include/sound/emu10k1.h
@@ -1809,6 +1809,8 @@
 		       uint subsystem,
 		       struct snd_emu10k1 ** remu);
 
+void snd_emu10k1_shutdown(struct pci_dev *pci);
+
 int snd_emu10k1_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
 int snd_emu10k1_pcm_mic(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
 int snd_emu10k1_pcm_efx(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
--- linux-3.19/sound/pci/emu10k1/emu10k1.c
+++ linux-3.19-1/sound/pci/emu10k1/emu10k1.c
@@ -282,6 +282,7 @@
 	.driver = {
 		.pm = SND_EMU10K1_PM_OPS,
 	},
+	.shutdown = snd_emu10k1_shutdown,
 };
 
 module_pci_driver(emu10k1_driver);
--- linux-3.19/sound/pci/emu10k1/emu10k1_main.c
+++ linux-3.19-1/sound/pci/emu10k1/emu10k1_main.c
@@ -361,6 +361,9 @@
 	/* Enable analog/digital outs on audigy */
 	if (emu->card_capabilities->emu_model) {
 		;  /* Disable all access to A_IOCFG for the emu1010 */
+		/* Wait before unmute to avoid pop noise */
+		msleep_interruptible(500);
+		snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE); /* Unmute all */
 	} else if (emu->card_capabilities->i2c_adc) {
 		;  /* Disable A_IOCFG for Audigy 2 ZS Notebook */
 	} else if (emu->audigy) {
@@ -1097,7 +1100,6 @@
 		EMU_DST_ALICE_I2S2_LEFT, EMU_SRC_DOCK_ADC3_LEFT1);
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_ALICE_I2S2_RIGHT, EMU_SRC_DOCK_ADC3_RIGHT1);
-	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x01); /* Unmute all */
 
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp);
 
@@ -1253,17 +1255,12 @@
 	/* snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0); */ /* Output spdif */
 
 	/* TEMP: Select 48kHz SPDIF out */
-	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x0); /* Mute all */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, 0x0); /* Default fallback clock 48kHz */
 	/* Word Clock source, Internal 48kHz x1 */
 	snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K);
 	/* snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X); */
 	emu->emu1010.internal_clock = 1; /* 48000 */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12); /* Set LEDs on Audio Dock */
-	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x1); /* Unmute all */
-	/* snd_emu1010_fpga_write(emu, 0x7, 0x0); */ /* Mute all */
-	/* snd_emu1010_fpga_write(emu, 0x7, 0x1); */ /* Unmute all */
-	/* snd_emu1010_fpga_write(emu, 0xe, 0x12); */ /* Set LEDs on Audio Dock */
 
 	return 0;
 }
@@ -2142,3 +2139,16 @@
 	}
 }
 #endif
+
+void snd_emu10k1_shutdown(struct pci_dev *pci)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct snd_emu10k1 *emu = card->private_data;
+
+	if (emu->card_capabilities->emu_model) {
+		snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE); /* Mute all */
+		/* Clean FPGA to avoid pop noise on shutdown */
+		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0x02);
+	}
+}
+EXPORT_SYMBOL(snd_emu10k1_shutdown);
