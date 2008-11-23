From: Vincent Petry <PVince81@yahoo.fr>
Subject: [PATCH] hda: Added an ALC888 model entry for
 Fujitsu-Siemens Amilo Xa3530
Date: Sun, 23 Nov 2008 11:31:41 +0800
Message-ID: <4928CE9D.1090606@yahoo.fr>
References: <4922A549.3070808@yahoo.fr>	<s5h8wrhfehv.wl%tiwai@suse.de>	<4922BF91.2030704@yahoo.fr>	<s5hvduldve6.wl%tiwai@suse.de>	<4922C95D.8080201@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n14.bullet.mail.mud.yahoo.com (n14.bullet.mail.mud.yahoo.com
	[68.142.206.41]) by alsa0.perex.cz (Postfix) with SMTP id 6E853243FF
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2008 04:31:26 +0100 (CET)
In-Reply-To: <4922C95D.8080201@yahoo.fr>
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
Cc: manu@frogged.de
List-Id: alsa-devel@alsa-project.org

This patch fixes the bug 0004240: ALC888 - Intel HDA - Headphone Controlling.
It is made against the 2008-11-23 snapshot.

Added Realtek ALC888 model entry for the Fujitsu-Siemens Amilo Xa3530
laptop. It has 4 jacks: HP out, Mic-in, Line-in and Line-out/Side/SPDIF
(this one is on the laptop side, the other ones are on the rear).

Model detection works.
Headphone jack sense works now.
Front mic works now, was same as Acer Aspire 4930G.
Added channel mode from 2 to 8 channels.

In 2ch and 4ch modes, the front is also sent to the Line-out/side jack
for convenience instead of just muting the Line-out/side jack like other
models do.

When using the Mic-in jack as CLFE, the sound is very low (bug?). To
work it around, in 6ch mode the CLFE channel is duplicated to the
Line-out/side jack because this one has a better amp.

Signed-off-by: Vincent Petry <PVince81@yahoo.fr>
---
 Documentation/ALSA-Configuration.txt |    1
 pci/hda/patch_realtek.c              |  176
+++++++++++++++++++++++++++++++++--
 2 files changed, 168 insertions(+), 9 deletions(-)

diff -Nur alsa-kernel//Documentation/ALSA-Configuration.txt
alsa-kernel-new//Documentation/ALSA-Configuration.txt
--- alsa-kernel//Documentation/ALSA-Configuration.txt	2008-11-23
07:05:01.000000000 +0800
+++ alsa-kernel-new//Documentation/ALSA-Configuration.txt	2008-11-23
10:58:28.000000000 +0800
@@ -919,6 +919,7 @@
 	  mitac		Mitac 8252D
 	  clevo-m720	Clevo M720 laptop series
 	  fujitsu-pi2515 Fujitsu AMILO Pi2515
+	  fujitsu-xa3530 Fujitsu AMILO XA3530
 	  3stack-6ch-intel Intel DG33* boards
 	  auto		auto-config reading BIOS (default)

diff -Nur alsa-kernel//pci/hda/patch_realtek.c
alsa-kernel-new//pci/hda/patch_realtek.c
--- alsa-kernel//pci/hda/patch_realtek.c	2008-11-23 07:05:02.000000000 +0800
+++ alsa-kernel-new//pci/hda/patch_realtek.c	2008-11-23
10:39:59.000000000 +0800
@@ -230,6 +230,7 @@
 	ALC883_MITAC,
 	ALC883_CLEVO_M720,
 	ALC883_FUJITSU_PI2515,
+	ALC888_FUJITSU_XA3530,
 	ALC883_3ST_6ch_INTEL,
 	ALC888_ASUS_M90V,
 	ALC888_ASUS_EEE1601,
@@ -1156,6 +1157,141 @@
 }

 /*
+ * ALC888
+ */
+
+/*
+ * 2ch mode
+ */
+static struct hda_verb alc888_4ST_ch2_intel_init[] = {
+/* Mic-in jack as mic in */
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+/* Line-in jack as Line in */
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+/* Line-Out as Front */
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ } /* end */
+};
+
+/*
+ * 4ch mode
+ */
+static struct hda_verb alc888_4ST_ch4_intel_init[] = {
+/* Mic-in jack as mic in */
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+/* Line-in jack as Surround */
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+/* Line-Out as Front */
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ } /* end */
+};
+
+/*
+ * 6ch mode
+ */
+static struct hda_verb alc888_4ST_ch6_intel_init[] = {
+/* Mic-in jack as CLFE */
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+/* Line-in jack as Surround */
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+/* Line-Out as CLFE (workaround because Mic-in is not loud enough) */
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x03},
+	{ } /* end */
+};
+
+/*
+ * 8ch mode
+ */
+static struct hda_verb alc888_4ST_ch8_intel_init[] = {
+/* Mic-in jack as CLFE */
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+/* Line-in jack as Surround */
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+/* Line-Out as Side */
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x03},
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc888_4ST_8ch_intel_modes[4] = {
+	{ 2, alc888_4ST_ch2_intel_init },
+	{ 4, alc888_4ST_ch4_intel_init },
+	{ 6, alc888_4ST_ch6_intel_init },
+	{ 8, alc888_4ST_ch8_intel_init },
+};
+
+/*
+ * ALC888 Fujitsu Siemens Amillo xa3530
+ */
+
+static struct hda_verb alc888_fujitsu_xa3530_verbs[] = {
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Connect Internal HP to Front */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Connect Bass HP to Front */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Connect Line-Out side jack (SPDIF) to Side */
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x17, AC_VERB_SET_CONNECT_SEL, 0x03},
+/* Connect Mic jack to CLFE */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x02},
+/* Connect Line-in jack to Surround */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x01},
+/* Connect HP out jack to Front */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Enable unsolicited event for HP jack and Line-out jack */
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{}
+};
+
+static void alc888_fujitsu_xa3530_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+	unsigned int bits;
+	/* Line out presence */
+	present = snd_hda_codec_read(codec, 0x17, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	/* HP out presence */
+	present = present || snd_hda_codec_read(codec, 0x1b, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	bits = present ? HDA_AMP_MUTE : 0;
+	/* Toggle internal speakers muting */
+	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+	/* Toggle internal bass muting */
+	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+}
+
+static void alc888_fujitsu_xa3530_unsol_event(struct hda_codec *codec,
+		unsigned int res)
+{
+	if (res >> 26 == ALC880_HP_EVENT)
+		alc888_fujitsu_xa3530_automute(codec);
+}
+
+
+/*
  * ALC888 Acer Aspire 4930G model
  */

@@ -1164,7 +1300,7 @@
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 /* Unselect Front Mic by default in input mixer 3 */
 	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
-/* enable unsolicited event fpr HP jack */
+/* Enable unsolicited event for HP jack */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 /* Connect Internal HP to front */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -1177,7 +1313,7 @@
 	{ }
 };

-static struct hda_input_mux alc888_acer_aspire_4930g_capture_source[2] = {
+static struct hda_input_mux alc888_2_capture_sources[2] = {
 	/* Front mic only available on one ADC */
 	{
 		.num_items = 4,
@@ -1198,7 +1334,7 @@
 	}
 };

-static struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] = {
+static struct snd_kcontrol_new alc888_base_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
@@ -1225,11 +1361,12 @@
 static void alc888_acer_aspire_4930g_automute(struct hda_codec *codec)
 {
 	unsigned int present;
+	unsigned int bits;
 	present = snd_hda_codec_read(codec, 0x15, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	/* Toggle the internal HP PIN (regular muting doesn't work) */
-	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-					(present ? 0x0 : PIN_OUT));
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
 }

 static void alc888_acer_aspire_4930g_unsol_event(struct hda_codec *codec,
@@ -8286,6 +8423,7 @@
 	[ALC883_MITAC]		= "mitac",
 	[ALC883_CLEVO_M720]	= "clevo-m720",
 	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
+	[ALC888_FUJITSU_XA3530] = "fujitsu-xa3530",
 	[ALC883_3ST_6ch_INTEL]	= "3stack-6ch-intel",
 	[ALC1200_ASUS_P5Q]	= "asus-p5q",
 	[ALC883_AUTO]		= "auto",
@@ -8346,6 +8484,8 @@
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
 	SND_PCI_QUIRK(0x1734, 0x1108, "Fujitsu AMILO Pi2515",
ALC883_FUJITSU_PI2515),
+	SND_PCI_QUIRK(0x1734, 0x113d, "Fujitsu AMILO Xa3530",
+		ALC888_FUJITSU_XA3530),
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo 101e", ALC883_LENOVO_101E_2ch),
 	SND_PCI_QUIRK(0x17aa, 0x2085, "Lenovo NB0763", ALC883_LENOVO_NB0763),
 	SND_PCI_QUIRK(0x17aa, 0x3bfc, "Lenovo NB0763", ALC883_LENOVO_NB0763),
@@ -8472,7 +8612,7 @@
 		.init_hook = alc883_acer_aspire_automute,
 	},
 	[ALC888_ACER_ASPIRE_4930G] = {
-		.mixers = { alc888_acer_aspire_4930g_mixer,
+		.mixers = { alc888_base_mixer,
 				alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
 				alc888_acer_aspire_4930g_verbs },
@@ -8486,8 +8626,8 @@
 		.channel_mode = alc883_3ST_6ch_modes,
 		.need_dac_fix = 1,
 		.num_mux_defs =
-			ARRAY_SIZE(alc888_acer_aspire_4930g_capture_source),
-		.input_mux = alc888_acer_aspire_4930g_capture_source,
+			ARRAY_SIZE(alc888_2_capture_sources),
+		.input_mux = alc888_2_capture_sources,
 		.unsol_event = alc888_acer_aspire_4930g_unsol_event,
 		.init_hook = alc888_acer_aspire_4930g_automute,
 	},
@@ -8634,6 +8774,24 @@
 		.unsol_event = alc883_2ch_fujitsu_pi2515_unsol_event,
 		.init_hook = alc883_2ch_fujitsu_pi2515_automute,
 	},
+	[ALC888_FUJITSU_XA3530] = {
+		.mixers = { alc888_base_mixer, alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs,
+			alc888_fujitsu_xa3530_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids_rev),
+		.adc_nids = alc883_adc_nids_rev,
+		.capsrc_nids = alc883_capsrc_nids_rev,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc888_4ST_8ch_intel_modes),
+		.channel_mode = alc888_4ST_8ch_intel_modes,
+		.num_mux_defs =
+			ARRAY_SIZE(alc888_2_capture_sources),
+		.input_mux = alc888_2_capture_sources,
+		.unsol_event = alc888_fujitsu_xa3530_unsol_event,
+		.init_hook = alc888_fujitsu_xa3530_automute,
+	},
 	[ALC888_LENOVO_SKY] = {
 		.mixers = { alc888_lenovo_sky_mixer, alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc888_lenovo_sky_verbs},
