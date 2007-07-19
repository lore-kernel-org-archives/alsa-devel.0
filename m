From: Nicola Fagnani <nicfagn@iol.it>
Subject: [PATCH] hda-intel: support for iMac 24'' released on
	09/2006
Date: Thu, 19 Jul 2007 21:41:16 +0200
Message-ID: <BCA9F482-FAD3-4BB1-A6A1-E27E66900CFB@iol.it>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out4.libero.it (smtp-out4.libero.it [212.52.84.46])
	by alsa0.perex.cz (Postfix) with ESMTP id F1AE7103811
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 21:42:36 +0200 (CEST)
Received: from localhost (172.31.0.54) by smtp-out4.libero.it (7.3.120)
	id 4688F35001C0A70C for alsa-devel@alsa-project.org;
	Thu, 19 Jul 2007 21:42:35 +0200
Received: from smtp-out3.libero.it ([172.31.0.39])
	by localhost (asav-out12.libero.it [192.168.32.40]) (amavisd-new,
	port 10024)
	with ESMTP id Xwmi3RO5EGSV for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 21:42:35 +0200 (CEST)
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out3.libero.it
	(7.3.120) id 4611FDB60803A88E for alsa-devel@alsa-project.org;
	Thu, 19 Jul 2007 21:42:35 +0200
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Basic audio support for the iMac 24'' model released on 09/2006,  
including
headphone jack detection with automatic speaker muting.
This iMac uses the Realtek ALC885 codec, not a Sigmatel one as in  
other models.
Functionality has been tested for internal speakers, headphone and  
microphone.

Signed-off-by: Nicola Fagnani <nicfagn@iol.it>
---

diff -ru alsa-driver-1.0.14/alsa-kernel/Documentation/ALSA- 
Configuration.txt alsa-driver-1.0.14-patched/alsa-kernel/ 
Documentation/ALSA-Configuration.txt
--- alsa-driver-1.0.14/alsa-kernel/Documentation/ALSA- 
Configuration.txt	2007-06-04 09:28:52.000000000 +0200
+++ alsa-driver-1.0.14-patched/alsa-kernel/Documentation/ALSA- 
Configuration.txt	2007-07-19 20:16:24.000000000 +0200
@@ -827,6 +827,7 @@
  	  6stack-dig	6-jack digital with SPDIF I/O
  	  arima		Arima W820Di1
  	  macpro	MacPro support
+	  imac24	iMac 24'' with jack detection
  	  w2jc		ASUS W2JC
  	  auto		auto-config reading BIOS (default)

diff -ru alsa-driver-1.0.14/alsa-kernel/pci/hda/patch_realtek.c alsa- 
driver-1.0.14-patched/alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-1.0.14/alsa-kernel/pci/hda/patch_realtek.c	2007-06-04  
09:28:54.000000000 +0200
+++ alsa-driver-1.0.14-patched/alsa-kernel/pci/hda/patch_realtek.c	 
2007-07-06 12:19:30.000000000 +0200
@@ -144,6 +144,7 @@
  	ALC882_TARGA,
  	ALC882_ASUS_A7J,
  	ALC885_MACPRO,
+	ALC885_IMAC24,
  	ALC882_AUTO,
  	ALC882_MODEL_LAST,
  };
@@ -5054,6 +5055,59 @@
  	{ }
  };

+/* iMac 24 mixer. */
+static struct snd_kcontrol_new alc885_imac24_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Master Playback Switch", 0x0c, 0x00, HDA_INPUT),
+	{ } /* end */
+};
+/* iMac 24 init verbs. */
+static struct hda_verb alc885_imac24_init_verbs[] = {
+	/* Internal speakers: output 0 (0x0c) */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* Internal speakers: output 0 (0x0c) */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* Headphone: output 0 (0x0c) */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	/* Front Mic: input vref at 80% */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	{ }
+};
+
+/* Toggle speaker-output according to the hp-jack state */
+static void alc885_imac24_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+
+ 	present = snd_hda_codec_read(codec, 0x14, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_update(codec, 0x18, 0, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x18, 1, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x1a, 0, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x1a, 1, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+}
+/* Processes unsolicited events. */
+static void alc885_imac24_unsol_event(struct hda_codec *codec,  
unsigned int res)
+{
+	/* Headphone insertion or removal. */
+	if (((res >> 26) == ALC880_HP_EVENT)) {
+		alc885_imac24_automute(codec);
+	}
+}
+
+
  static struct hda_verb alc882_targa_verbs[] = {
  	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
  	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
@@ -5274,6 +5328,7 @@
  	[ALC882_ARIMA]		= "arima",
  	[ALC882_W2JC]		= "w2jc",
  	[ALC885_MACPRO]		= "macpro",
+	[ALC885_IMAC24]		= "imac24",
  	[ALC882_AUTO]		= "auto",
  };

@@ -5345,6 +5400,19 @@
  		.channel_mode = alc882_ch_modes,
  		.input_mux = &alc882_capture_source,
  	},
+	[ALC885_IMAC24] = {
+		.mixers = { alc885_imac24_mixer },
+		.init_verbs = { alc885_imac24_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc882_dac_nids),
+		.dac_nids = alc882_dac_nids,
+		.dig_out_nid = ALC882_DIGOUT_NID,
+		.dig_in_nid = ALC882_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc882_ch_modes),
+		.channel_mode = alc882_ch_modes,
+		.input_mux = &alc882_capture_source,
+		.unsol_event = alc885_imac24_unsol_event,
+		.init_hook = alc885_imac24_automute,
+	},
  	[ALC882_TARGA] = {
  		.mixers = { alc882_targa_mixer, alc882_chmode_mixer,
  			    alc882_capture_mixer },
@@ -5494,6 +5562,9 @@
  		case 0x106b0c00: /* Mac Pro */
  			board_config = ALC885_MACPRO;
  			break;
+		case 0x106b1000: /* iMac 24 */
+			board_config = ALC885_IMAC24;
+			break;
  		default:
  			printk(KERN_INFO "hda_codec: Unknown model for ALC882, "
  		       			 "trying auto-probe from BIOS...\n");
@@ -5518,7 +5589,7 @@
  	if (board_config != ALC882_AUTO)
  		setup_preset(spec, &alc882_presets[board_config]);

-	if (board_config == ALC885_MACPRO) {
+	if (board_config == ALC885_MACPRO || board_config == ALC885_IMAC24) {
  		alc882_gpio_mute(codec, 0, 0);
  		alc882_gpio_mute(codec, 1, 0);
  	}
