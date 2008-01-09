From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD7XXX power management support
Date: Wed, 09 Jan 2008 11:41:00 -0500
Message-ID: <4784F91C.9000504@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010806000803070409080109"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.re2.yahoo.com (smtp109.biz.mail.re2.yahoo.com
	[206.190.53.8]) by alsa0.perex.cz (Postfix) with SMTP id 91AD92461A
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 17:41:54 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010806000803070409080109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for advanced power management support for output ports on 
92HD7xxx family of codecs. Inactive output ports are powered down when 
the pin sense  doesn't detect a connection, and powered back up when a 
connection is sensed.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------010806000803070409080109
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="92hd7xxx_power_management.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="92hd7xxx_power_management.patch"

diff -r 60aa7d37dcd5 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Jan 08 17:19:22 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Jan 09 11:13:21 2008 -0500
@@ -35,7 +35,8 @@
 #include "hda_local.h"
 
 #define NUM_CONTROL_ALLOC	32
-#define STAC_HP_EVENT		0x37
+#define STAC_PWR_EVENT		0x20
+#define STAC_HP_EVENT		0x30
 
 enum {
 	STAC_REF,
@@ -127,6 +128,10 @@ struct sigmatel_spec {
 	unsigned char aloopback_mask;
 	unsigned char aloopback_shift;
 
+	/* power management */
+	unsigned int num_pwrs;
+	hda_nid_t *pwr_nids;
+
 	/* playback */
 	struct hda_multi_out multiout;
 	hda_nid_t dac_nids[5];
@@ -185,6 +190,11 @@ static hda_nid_t stac9200_dac_nids[1] = 
         0x02,
 };
 
+static hda_nid_t stac92hd73xx_pwr_nids[8] = {
+	0x0a, 0x0b, 0x0c, 0xd, 0x0e,
+	0x0f, 0x10, 0x11
+};
+
 static hda_nid_t stac92hd73xx_adc_nids[2] = {
 	0x1a, 0x1b
 };
@@ -205,6 +215,10 @@ static hda_nid_t stac92hd73xx_mux_nids[4
 
 static hda_nid_t stac92hd73xx_dmux_nids[2] = {
 	0x20, 0x21,
+};
+
+static hda_nid_t stac92hd71bxx_pwr_nids[3] = {
+	0x0a, 0x0d, 0x0f
 };
 
 static hda_nid_t stac92hd71bxx_adc_nids[2] = {
@@ -546,7 +560,7 @@ static struct hda_verb stac92hd71bxx_ana
 	/* connect ports 0d and 0f to audio mixer */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
 	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
 	/* unmute dac0 input in audio mixer */
 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
 	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
@@ -714,6 +728,8 @@ static struct snd_kcontrol_new stac92hd7
 
 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
+
+	HDA_CODEC_MUTE_MONO("Mono Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -728,6 +744,8 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_MUTE_MONO("Mono Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -2651,11 +2669,26 @@ static void enable_pin_detect(struct hda
 static void enable_pin_detect(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int event)
 {
+	int pinctl = snd_hda_codec_read(codec, nid, 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	if (pinctl & AC_PINCTL_IN_EN)
+		return;
+
 	if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP)
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_UNSOLICITED_ENABLE,
 					  (AC_USRSP_EN | event));
 }
+
+static int is_nid_hp_pin(struct auto_pin_cfg *cfg, hda_nid_t nid)
+{
+	int i;
+	for (i = 0; i < cfg->hp_outs; i++)
+		if (cfg->hp_pins[i] == nid)
+			return 1; /* nid is a HP-Out */
+
+	return 0; /* nid is not a HP-Out */
+};
 
 static int stac92xx_init(struct hda_codec *codec)
 {
@@ -2696,6 +2729,14 @@ static int stac92xx_init(struct hda_code
 		for (i = 0; i < spec->num_dmics; i++)
 			stac92xx_auto_set_pinctl(codec, spec->dmic_nids[i],
 						 AC_PINCTL_IN_EN);
+	if (spec->num_pwrs > 0) {
+		for (i = 0; i < spec->num_pwrs; i++)  {
+			int event = is_nid_hp_pin(cfg, spec->pwr_nids[i])
+					? STAC_HP_EVENT : STAC_PWR_EVENT;
+			enable_pin_detect(codec, spec->pwr_nids[i], event | i);
+			codec->patch_ops.unsol_event(codec, (event | i) << 26);
+		}
+	}
 
 	if (cfg->dig_out_pin)
 		stac92xx_auto_set_pinctl(codec, cfg->dig_out_pin,
@@ -2822,12 +2863,37 @@ static void stac92xx_hp_detect(struct hd
 	}
 } 
 
+static void stac92xx_pin_sense(struct hda_codec *codec, int idx)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int presence, val;
+
+	val = snd_hda_codec_read(codec, codec->afg, 0, 0x0fec, 0x0)
+							& 0x000000ff;
+	presence = get_hp_pin_presence(codec, spec->pwr_nids[idx]);
+	idx = 1 << idx;
+
+	if (presence)
+		val &= ~idx;
+	else
+		val |= idx;
+
+	/* power down unused output ports */
+	snd_hda_codec_write(codec, codec->afg, 0, 0x7ec, val);
+};
+
 static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	switch (res >> 26) {
+	struct sigmatel_spec *spec = codec->spec;
+	int idx = res >> 26 & 0x0f;
+
+	switch ((res >> 26) & 0x30) {
 	case STAC_HP_EVENT:
 		stac92xx_hp_detect(codec, res);
-		break;
+		/* fallthru */
+	case STAC_PWR_EVENT:
+		if (spec->num_pwrs > 0)
+			stac92xx_pin_sense(codec, idx);
 	}
 }
 
@@ -2898,6 +2964,7 @@ static int patch_stac9200(struct hda_cod
 	spec->num_muxes = 1;
 	spec->num_dmics = 0;
 	spec->num_adcs = 1;
+	spec->num_pwrs = 0;
 
 	if (spec->board_config == STAC_9200_GATEWAY)
 		spec->init = stac9200_eapd_init;
@@ -2953,6 +3020,7 @@ static int patch_stac925x(struct hda_cod
 	spec->mux_nids = stac925x_mux_nids;
 	spec->num_muxes = 1;
 	spec->num_adcs = 1;
+	spec->num_pwrs = 0;
 	switch (codec->vendor_id) {
 	case 0x83847632: /* STAC9202  */
 	case 0x83847633: /* STAC9202D */
@@ -3076,6 +3144,9 @@ again:
 	spec->gpio_mask = spec->gpio_data = 0x000001;
 	stac92xx_enable_gpio_mask(codec);
 
+	spec->num_pwrs = 8;
+	spec->pwr_nids = stac92hd73xx_pwr_nids;
+
 	err = stac92xx_parse_auto_config(codec, 0x22, 0x24);
 
 	if (!err) {
@@ -3157,6 +3228,9 @@ again:
 	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
 	spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+
+	spec->num_pwrs = 3;
+	spec->pwr_nids = stac92hd71bxx_pwr_nids;
 
 	spec->multiout.num_dacs = 2;
 	spec->multiout.hp_nid = 0x11;
@@ -3252,6 +3326,7 @@ static int patch_stac922x(struct hda_cod
 	spec->num_muxes = ARRAY_SIZE(stac922x_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac922x_adc_nids);
 	spec->num_dmics = 0;
+	spec->num_pwrs = 0;
 
 	spec->init = stac922x_core_init;
 	spec->mixer = stac922x_mixer;
@@ -3356,6 +3431,7 @@ static int patch_stac927x(struct hda_cod
 		spec->mixer = stac927x_mixer;
 	}
 
+	spec->num_pwrs = 0;
 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
 
@@ -3417,6 +3493,7 @@ static int patch_stac9205(struct hda_cod
 	spec->num_dmics = STAC9205_NUM_DMICS;
 	spec->dmux_nids = stac9205_dmux_nids;
 	spec->num_dmuxes = ARRAY_SIZE(stac9205_dmux_nids);
+	spec->num_pwrs = 0;
 
 	spec->init = stac9205_core_init;
 	spec->mixer = stac9205_mixer;
@@ -3679,6 +3756,7 @@ static int patch_stac9872(struct hda_cod
 		spec->multiout.hp_nid = VAIO_HP_DAC;
 		spec->num_adcs = ARRAY_SIZE(vaio_adcs);
 		spec->adc_nids = vaio_adcs;
+		spec->num_pwrs = 0;
 		spec->input_mux = &vaio_mux;
 		spec->mux_nids = vaio_mux_nids;
 		codec->patch_ops = stac9872_vaio_patch_ops;
@@ -3692,6 +3770,7 @@ static int patch_stac9872(struct hda_cod
 		spec->multiout.dac_nids = vaio_dacs;
 		spec->multiout.hp_nid = VAIO_HP_DAC;
 		spec->num_adcs = ARRAY_SIZE(vaio_adcs);
+		spec->num_pwrs = 0;
 		spec->adc_nids = vaio_adcs;
 		spec->input_mux = &vaio_mux;
 		spec->mux_nids = vaio_mux_nids;

--------------010806000803070409080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010806000803070409080109--
