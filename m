From: Ctirad Fertr <c.fertr@gmail.com>
Subject: [PATCH] 1616(M) cardbus improvements
Date: Fri, 16 Nov 2007 00:07:00 +0100
Message-ID: <200711160007.00300.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UENPHT49kyo+WLb"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.vol.cz (smtp3.vol.cz [195.250.128.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 7328C1037F2
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 00:07:08 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp3.vol.cz (Postfix) with ESMTP id 2319459564
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 00:07:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_UENPHT49kyo+WLb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

this patch improves E-Mu 1616(M) cardbus support. It adds definitions of the 
new Microdock and 1010 cardbus registers (thanks again for descriptions 
James) and improves mixer for this card. Now you can use S/PDIF and ADAT on 
Mirodock and also use headpohone output on host cardbus card as another 
independent output.

Signed-off-by: Ctirad Fertr <c.fertr@gmail.com> 

------
Ctirad
   

--Boundary-00=_UENPHT49kyo+WLb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="1616cardbus_registers_mixer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1616cardbus_registers_mixer.diff"

diff -ru a/include/emu10k1.h b/include/emu10k1.h
--- a/include/emu10k1.h	2007-11-12 18:53:28.000000000 +0100
+++ b/include/emu10k1.h	2007-11-15 23:10:50.000000000 +0100
@@ -1299,6 +1299,16 @@
 #define EMU_DST_ALICE_I2S2_LEFT		0x0700	/* Alice2 I2S2 Left */
 #define EMU_DST_ALICE_I2S2_RIGHT	0x0701	/* Alice2 I2S2 Right */
 
+/* Additional destinations for 1616(M)/Microdock */
+#define EMU_DST_MDOCK_SPDIF_LEFT1       0x0112	/* Microdock S/PDIF OUT Left, 1st or 48kHz only */
+#define EMU_DST_MDOCK_SPDIF_LEFT2	0x0113	/* Microdock S/PDIF OUT Left, 2nd or 96kHz */
+#define EMU_DST_MDOCK_SPDIF_RIGHT1      0x0116  /* Microdock S/PDIF OUT Right, 1st or 48kHz only */
+#define EMU_DST_MDOCK_SPDIF_RIGHT2      0x0117  /* Microdock S/PDIF OUT Right, 2nd or 96kHz  */
+#define EMU_DST_MDOCK_ADAT       0x0118  /* Microdock S/PDIF ADAT 8 channel out +8 to +f */
+
+#define EMU_DST_MANA_DAC_LEFT	0x0300	/* Headphone jack on 1010 cardbus  ?44.1/48kHz only? */
+#define EMU_DST_MANA_DAC_RIGHT	0x0301	/* Headphone jack on 1010 cardbus ?44.1/48kHz only? */
+
 /************************************************************************************************/
 /* EMU1010m HANA Sources									*/
 /************************************************************************************************/
@@ -1452,6 +1462,14 @@
 #define EMU_SRC_HANA_SPDIF_LEFT2	0x0502	/* Hana SPDIF Left, 2nd or 96kHz */
 #define EMU_SRC_HANA_SPDIF_RIGHT1	0x0501	/* Hana SPDIF Right, 1st or 48kHz only */
 #define EMU_SRC_HANA_SPDIF_RIGHT2	0x0503	/* Hana SPDIF Right, 2nd or 96kHz */
+
+/* Additional inputs for 1616(M)/Microdock */
+#define EMU_SRC_MDOCK_SPDIF_LEFT1	0x0112	/* Microdock S/PDIF Left, 1st or 48kHz only */
+#define EMU_SRC_MDOCK_SPDIF_LEFT2	0x0113	/* Microdock S/PDIF Left, 2nd or 96kHz */
+#define EMU_SRC_MDOCK_SPDIF_RIGHT1	0x0116	/* Microdock S/PDIF Right, 1st or 48kHz only */
+#define EMU_SRC_MDOCK_SPDIF_RIGHT2	0x0117	/* Microdock S/PDIF Right, 2nd or 96kHz */
+#define EMU_SRC_MDOCK_ADAT	0x0118	/* Microdock ADAT 8 channel in +8 to +f */
+
 /* 0x600 and 0x700 no used */
 
 /* ------------------- STRUCTURES -------------------- */
diff -ru a/pci/emu10k1/emumixer.c b/pci/emu10k1/emumixer.c
--- a/pci/emu10k1/emumixer.c	2007-11-12 18:53:28.000000000 +0100
+++ b/pci/emu10k1/emumixer.c	2007-11-14 21:08:06.000000000 +0100
@@ -140,6 +140,61 @@
 	"DSP 31",
 };
 
+/* 1616(m) cardbus */
+
+static char *emu1616cardbus_src_texts[] = {
+        "Silence",
+        "Dock Mic A",
+        "Dock Mic B",
+        "Dock ADC1 Left",
+        "Dock ADC1 Right",
+        "Dock ADC2 Left",
+        "Dock ADC2 Right",
+        "Dock SPDIF Left",
+        "Dock SPDIF Right",
+        "ADAT 0",
+        "ADAT 1",
+        "ADAT 2",
+        "ADAT 3",
+        "ADAT 4",
+        "ADAT 5",
+        "ADAT 6",
+        "ADAT 7",
+        "DSP 0",
+        "DSP 1",
+        "DSP 2",
+        "DSP 3",
+        "DSP 4",
+        "DSP 5",
+        "DSP 6",
+        "DSP 7",
+        "DSP 8",
+        "DSP 9",
+        "DSP 10",
+        "DSP 11",
+        "DSP 12",
+        "DSP 13",
+        "DSP 14",
+        "DSP 15",
+        "DSP 16",
+        "DSP 17",
+        "DSP 18",
+        "DSP 19",
+        "DSP 20",
+        "DSP 21",
+        "DSP 22",
+        "DSP 23",
+        "DSP 24",
+        "DSP 25",
+        "DSP 26",
+        "DSP 27",
+        "DSP 28",
+        "DSP 29",
+        "DSP 30",
+        "DSP 31",
+};
+
+
 /*
  * List of data sources available for each destination
  */
@@ -199,6 +254,59 @@
 	EMU_SRC_ALICE_EMU32B+0xf, /* 52 */
 };
 
+/* 1616(m) cardbus */
+static unsigned int emu1616cardbus_src_regs[] = {
+	EMU_SRC_SILENCE,
+	EMU_SRC_DOCK_MIC_A1,
+	EMU_SRC_DOCK_MIC_B1, 
+	EMU_SRC_DOCK_ADC1_LEFT1,
+	EMU_SRC_DOCK_ADC1_RIGHT1,
+	EMU_SRC_DOCK_ADC2_LEFT1, 
+	EMU_SRC_DOCK_ADC2_RIGHT1,
+	EMU_SRC_MDOCK_SPDIF_LEFT1,
+	EMU_SRC_MDOCK_SPDIF_RIGHT1,
+	EMU_SRC_MDOCK_ADAT, 
+	EMU_SRC_MDOCK_ADAT+1, 
+	EMU_SRC_MDOCK_ADAT+2, 
+	EMU_SRC_MDOCK_ADAT+3, 
+	EMU_SRC_MDOCK_ADAT+4, 
+	EMU_SRC_MDOCK_ADAT+5, 
+	EMU_SRC_MDOCK_ADAT+6, 
+	EMU_SRC_MDOCK_ADAT+7, 
+	EMU_SRC_ALICE_EMU32A, 
+	EMU_SRC_ALICE_EMU32A+1, 
+	EMU_SRC_ALICE_EMU32A+2, 
+	EMU_SRC_ALICE_EMU32A+3, 
+	EMU_SRC_ALICE_EMU32A+4, 
+	EMU_SRC_ALICE_EMU32A+5, 
+	EMU_SRC_ALICE_EMU32A+6, 
+	EMU_SRC_ALICE_EMU32A+7, 
+	EMU_SRC_ALICE_EMU32A+8, 
+	EMU_SRC_ALICE_EMU32A+9, 
+	EMU_SRC_ALICE_EMU32A+0xa,
+	EMU_SRC_ALICE_EMU32A+0xb,
+	EMU_SRC_ALICE_EMU32A+0xc,
+	EMU_SRC_ALICE_EMU32A+0xd,
+	EMU_SRC_ALICE_EMU32A+0xe,
+	EMU_SRC_ALICE_EMU32A+0xf,
+	EMU_SRC_ALICE_EMU32B,
+	EMU_SRC_ALICE_EMU32B+1,
+	EMU_SRC_ALICE_EMU32B+2,
+	EMU_SRC_ALICE_EMU32B+3,
+	EMU_SRC_ALICE_EMU32B+4,
+	EMU_SRC_ALICE_EMU32B+5,
+	EMU_SRC_ALICE_EMU32B+6,
+	EMU_SRC_ALICE_EMU32B+7,
+	EMU_SRC_ALICE_EMU32B+8,
+	EMU_SRC_ALICE_EMU32B+9,
+	EMU_SRC_ALICE_EMU32B+0xa,
+	EMU_SRC_ALICE_EMU32B+0xb,
+	EMU_SRC_ALICE_EMU32B+0xc,
+	EMU_SRC_ALICE_EMU32B+0xd,
+	EMU_SRC_ALICE_EMU32B+0xe,
+	EMU_SRC_ALICE_EMU32B+0xf,
+};    
+																						    
 /*
  * Data destinations - physical EMU outputs.
  * Each destination has an enum mixer control to choose a data source
@@ -230,6 +338,28 @@
 	EMU_DST_HANA_ADAT+7, /* 23 */
 };
 
+/* 1616(m) cardbus */
+static unsigned int emu1616cardbus_output_dst[] = {
+	EMU_DST_DOCK_DAC1_LEFT1,
+	EMU_DST_DOCK_DAC1_RIGHT1,
+	EMU_DST_DOCK_DAC2_LEFT1,
+	EMU_DST_DOCK_DAC2_RIGHT1,
+	EMU_DST_DOCK_DAC3_LEFT1,
+	EMU_DST_DOCK_DAC3_RIGHT1,
+	EMU_DST_MDOCK_SPDIF_LEFT1,
+	EMU_DST_MDOCK_SPDIF_RIGHT1,
+	EMU_DST_MDOCK_ADAT,
+	EMU_DST_MDOCK_ADAT+1,
+	EMU_DST_MDOCK_ADAT+2,
+	EMU_DST_MDOCK_ADAT+3,
+	EMU_DST_MDOCK_ADAT+4,
+	EMU_DST_MDOCK_ADAT+5,
+	EMU_DST_MDOCK_ADAT+6,
+	EMU_DST_MDOCK_ADAT+7,
+	EMU_DST_MANA_DAC_LEFT,
+	EMU_DST_MANA_DAC_RIGHT,
+};
+
 /*
  * Data destinations - HANA outputs going to Alice2 (audigy) for
  *   capture (EMU32 + I2S links)
@@ -262,12 +392,21 @@
 
 static int snd_emu1010_input_output_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
+	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 53;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, emu1010_src_texts[uinfo->value.enumerated.item]);
+	if (emu->card_capabilities->emu_model == 3 ){ /* 1616(m) cardbus */
+	    uinfo->value.enumerated.items = 49;
+	    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		    uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	    strcpy(uinfo->value.enumerated.name, emu1616cardbus_src_texts[uinfo->value.enumerated.item]);
+	} else {
+    	    uinfo->value.enumerated.items = 53;
+	    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		    uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	    strcpy(uinfo->value.enumerated.name, emu1010_src_texts[uinfo->value.enumerated.item]);
+	}
 	return 0;
 }
 
@@ -279,7 +418,7 @@
 
 	channel = (kcontrol->private_value) & 0xff;
 	/* Limit: emu1010_output_dst, emu->emu1010.output_source */
-	if (channel >= 24)
+	if ((channel >= 24) || ((emu->card_capabilities->emu_model == 3 ) && ( channel >= 18 )))
 		return -EINVAL;
 	ucontrol->value.enumerated.item[0] = emu->emu1010.output_source[channel];
 	return 0;
@@ -295,13 +434,18 @@
 
 	channel = (kcontrol->private_value) & 0xff;
 	/* Limit: emu1010_output_dst, emu->emu1010.output_source */
-	if (channel >= 24)
+	if ((channel >= 24) || ((emu->card_capabilities->emu_model == 3 ) && ( channel >= 18 )))
 		return -EINVAL;
 	if (emu->emu1010.output_source[channel] != ucontrol->value.enumerated.item[0]) {
 		val = emu->emu1010.output_source[channel] = ucontrol->value.enumerated.item[0];
 		change = 1;
-		snd_emu1010_fpga_link_dst_src_write(emu,
-			emu1010_output_dst[channel], emu1010_src_regs[val]);
+		if (emu->card_capabilities->emu_model == 3 ){ /* 1616(m) cardbus */
+		    snd_emu1010_fpga_link_dst_src_write(emu,
+			    emu1616cardbus_output_dst[channel], emu1616cardbus_src_regs[val]);
+		} else {
+		    snd_emu1010_fpga_link_dst_src_write(emu,
+			    emu1010_output_dst[channel], emu1010_src_regs[val]);
+		}    	    
 	}
 	return change;
 }
@@ -378,6 +522,30 @@
 	EMU1010_SOURCE_OUTPUT("1010 ADAT 7 Playback Enum", 0x17),
 };
 
+
+/* 1616(m) cardbus */
+static struct snd_kcontrol_new snd_emu1616cardbus_output_enum_ctls[] __devinitdata = {
+	EMU1010_SOURCE_OUTPUT("Dock DAC1 Left Playback Enum", 0),
+	EMU1010_SOURCE_OUTPUT("Dock DAC1 Right Playback Enum", 1),
+	EMU1010_SOURCE_OUTPUT("Dock DAC2 Left Playback Enum", 2),
+	EMU1010_SOURCE_OUTPUT("Dock DAC2 Right Playback Enum", 3),
+	EMU1010_SOURCE_OUTPUT("Dock DAC3 Left Playback Enum", 4),
+	EMU1010_SOURCE_OUTPUT("Dock DAC3 Right Playback Enum", 5),
+	EMU1010_SOURCE_OUTPUT("Dock SPDIF Left Playback Enum", 6),
+	EMU1010_SOURCE_OUTPUT("Dock SPDIF Right Playback Enum", 7),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 0 Playback Enum", 8),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 1 Playback Enum", 9),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 2 Playback Enum", 0xa),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 3 Playback Enum", 0xb),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 4 Playback Enum", 0xc),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 5 Playback Enum", 0xd),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 6 Playback Enum", 0xe),
+	EMU1010_SOURCE_OUTPUT("Dock ADAT 7 Playback Enum", 0xf),
+	EMU1010_SOURCE_OUTPUT("Mana DAC Left Playback Enum", 0x10),
+	EMU1010_SOURCE_OUTPUT("Mana DAC Right Playback Enum", 0x11),
+};
+
+
 #define EMU1010_SOURCE_INPUT(xname,chid) \
 {								\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
@@ -1821,7 +1989,34 @@
 			return err;
 	}
 
-	if (emu->card_capabilities->emu_model) {
+	if (emu->card_capabilities->emu_model == 3 ) { /* 1616(m) cardbus */
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(snd_emu1616cardbus_output_enum_ctls); i++) {
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1616cardbus_output_enum_ctls[i], emu));
+			if (err < 0)
+				return err;
+		}
+		for (i = 0; i < ARRAY_SIZE(snd_emu1010_input_enum_ctls); i++) {
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1010_input_enum_ctls[i], emu));
+			if (err < 0)
+				return err;
+		}
+		for (i = 0; i < ( ARRAY_SIZE(snd_emu1010_adc_pads) - 2) ; i++) {
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1010_adc_pads[i], emu));
+			if (err < 0)
+				return err;
+		}
+		for (i = 0; i < ( ARRAY_SIZE(snd_emu1010_dac_pads) - 2) ; i++) {
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1010_dac_pads[i], emu));
+			if (err < 0)
+				return err;
+		}
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1010_internal_clock, emu));
+		if (err < 0)
+			return err;
+
+	} else { /* all other e-mu cards for now */ 
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(snd_emu1010_output_enum_ctls); i++) {
@@ -1847,6 +2042,7 @@
 		err = snd_ctl_add(card, snd_ctl_new1(&snd_emu1010_internal_clock, emu));
 		if (err < 0)
 			return err;
+	
 	}
 
 	if ( emu->card_capabilities->i2c_adc) {
diff -ru a/pci/emu10k1/emu10k1_main.c b/pci/emu10k1/emu10k1_main.c
--- a/pci/emu10k1/emu10k1_main.c	2007-11-10 20:31:28.000000000 +0100
+++ b/pci/emu10k1/emu10k1_main.c	2007-11-15 23:16:01.000000000 +0100
@@ -1050,6 +1050,7 @@
 		/* Hana ADAT Out <- Silence */
 		snd_emu1010_fpga_link_dst_src_write(emu, EMU_DST_HANA_ADAT + i, EMU_SRC_SILENCE);
 	}
+	
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_ALICE_I2S0_LEFT, EMU_SRC_DOCK_ADC1_LEFT1);
 	snd_emu1010_fpga_link_dst_src_write(emu,
@@ -1104,79 +1105,106 @@
 		EMU_DST_HANA_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 3); /* ALICE2 bus 0xb3 */
 #endif
 	/* Default outputs */
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC1_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[0] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC1_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[1] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC2_LEFT1, EMU_SRC_ALICE_EMU32A + 2);
-	emu->emu1010.output_source[2] = 23;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC2_RIGHT1, EMU_SRC_ALICE_EMU32A + 3);
-	emu->emu1010.output_source[3] = 24;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC3_LEFT1, EMU_SRC_ALICE_EMU32A + 4);
-	emu->emu1010.output_source[4] = 25;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC3_RIGHT1, EMU_SRC_ALICE_EMU32A + 5);
-	emu->emu1010.output_source[5] = 26;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC4_LEFT1, EMU_SRC_ALICE_EMU32A + 6);
-	emu->emu1010.output_source[6] = 27;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_DAC4_RIGHT1, EMU_SRC_ALICE_EMU32A + 7);
-	emu->emu1010.output_source[7] = 28;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_PHONES_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[8] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_PHONES_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[9] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_SPDIF_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[10] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_DOCK_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[11] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_SPDIF_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[12] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[13] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HAMOA_DAC_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[14] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HAMOA_DAC_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[15] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
-	emu->emu1010.output_source[16] = 21;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 1, EMU_SRC_ALICE_EMU32A + 1);
-	emu->emu1010.output_source[17] = 22;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 2, EMU_SRC_ALICE_EMU32A + 2);
-	emu->emu1010.output_source[18] = 23;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 3, EMU_SRC_ALICE_EMU32A + 3);
-	emu->emu1010.output_source[19] = 24;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 4, EMU_SRC_ALICE_EMU32A + 4);
-	emu->emu1010.output_source[20] = 25;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 5, EMU_SRC_ALICE_EMU32A + 5);
-	emu->emu1010.output_source[21] = 26;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 6, EMU_SRC_ALICE_EMU32A + 6);
-	emu->emu1010.output_source[22] = 27;
-	snd_emu1010_fpga_link_dst_src_write(emu,
-		EMU_DST_HANA_ADAT + 7, EMU_SRC_ALICE_EMU32A + 7);
-	emu->emu1010.output_source[23] = 28;
-
+	
+	if ( emu->card_capabilities->emu_model == 3 ){ /* 1616(M) cardbus default outputs */
+        	snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC1_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[0] = 17;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC1_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[1] = 18;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC2_LEFT1, EMU_SRC_ALICE_EMU32A + 2);
+		emu->emu1010.output_source[2] = 19;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC2_RIGHT1, EMU_SRC_ALICE_EMU32A + 3);
+		emu->emu1010.output_source[3] = 20;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC3_LEFT1, EMU_SRC_ALICE_EMU32A + 4);
+		emu->emu1010.output_source[4] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC3_RIGHT1, EMU_SRC_ALICE_EMU32A + 5);
+		emu->emu1010.output_source[5] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_MANA_DAC_LEFT, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[16] = 17;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_MANA_DAC_RIGHT, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[17] = 18;
+	} else {
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC1_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[0] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC1_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[1] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC2_LEFT1, EMU_SRC_ALICE_EMU32A + 2);
+		emu->emu1010.output_source[2] = 23;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC2_RIGHT1, EMU_SRC_ALICE_EMU32A + 3);
+		emu->emu1010.output_source[3] = 24;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC3_LEFT1, EMU_SRC_ALICE_EMU32A + 4);
+		emu->emu1010.output_source[4] = 25;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC3_RIGHT1, EMU_SRC_ALICE_EMU32A + 5);
+		emu->emu1010.output_source[5] = 26;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC4_LEFT1, EMU_SRC_ALICE_EMU32A + 6);
+		emu->emu1010.output_source[6] = 27;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_DAC4_RIGHT1, EMU_SRC_ALICE_EMU32A + 7);
+		emu->emu1010.output_source[7] = 28;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_PHONES_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[8] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_PHONES_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[9] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_SPDIF_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[10] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_DOCK_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[11] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_SPDIF_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[12] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[13] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HAMOA_DAC_LEFT1, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[14] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HAMOA_DAC_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[15] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT, EMU_SRC_ALICE_EMU32A + 0); /* ALICE2 bus 0xa0 */
+		emu->emu1010.output_source[16] = 21;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 1, EMU_SRC_ALICE_EMU32A + 1);
+		emu->emu1010.output_source[17] = 22;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 2, EMU_SRC_ALICE_EMU32A + 2);
+		emu->emu1010.output_source[18] = 23;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 3, EMU_SRC_ALICE_EMU32A + 3);
+		emu->emu1010.output_source[19] = 24;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 4, EMU_SRC_ALICE_EMU32A + 4);
+		emu->emu1010.output_source[20] = 25;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 5, EMU_SRC_ALICE_EMU32A + 5);
+		emu->emu1010.output_source[21] = 26;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 6, EMU_SRC_ALICE_EMU32A + 6);
+		emu->emu1010.output_source[22] = 27;
+		snd_emu1010_fpga_link_dst_src_write(emu,
+			EMU_DST_HANA_ADAT + 7, EMU_SRC_ALICE_EMU32A + 7);
+		emu->emu1010.output_source[23] = 28;
+	}
 	/* TEMP: Select SPDIF in/out */
 	//snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0); /* Output spdif */
 

--Boundary-00=_UENPHT49kyo+WLb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_UENPHT49kyo+WLb--
