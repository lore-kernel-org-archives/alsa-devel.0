From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Thu, 16 Oct 2008 22:18:40 -0400
Message-ID: <48F7F600.3040706@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 17F571037F2
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 04:19:12 +0200 (CEST)
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

Add support for detecting line out pin insertion and reporting
back to userspace with the jack abstraction layer. Line outs
are reported with the macro defined SW_LINEOUT_INSERT code.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/include/linux/input.h b/include/linux/input.h
index a5802c9..7323d2f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -644,6 +644,7 @@ struct input_absinfo {
 #define SW_RADIO		SW_RFKILL_ALL	/* deprecated */
 #define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_DOCK			0x05  /* set = plugged into dock */
+#define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index b1b2b8b..7cb25f4 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -35,6 +35,7 @@ enum snd_jack_types {
 	SND_JACK_HEADPHONE	= 0x0001,
 	SND_JACK_MICROPHONE	= 0x0002,
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
+	SND_JACK_LINEOUT	= 0x0004,
 };

 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index bd2d9e6..4978db1 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -102,6 +102,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_HEADPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_HEADPHONE_INSERT);
+	if (type & SND_JACK_LINEOUT)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_LINEOUT_INSERT);
 	if (type & SND_JACK_MICROPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_MICROPHONE_INSERT);
@@ -153,6 +156,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
+	if (jack->type & SND_JACK_LINEOUT)
+		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
+				    status & SND_JACK_LINEOUT);
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d106ea5..1b3cba8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -36,6 +36,7 @@
 #include "hda_patch.h"
 #include "hda_beep.h"

+#define STAC_LINEOUT_EVENT	0x10
 #define STAC_PWR_EVENT		0x20
 #define STAC_HP_EVENT		0x30
 #define STAC_VREF_EVENT		0x40
@@ -217,7 +218,8 @@ struct sigmatel_spec {
 	struct hda_pcm pcm_rec[2];	/* PCM information */

 	/* jack detection */
-	struct snd_jack *jack;
+	struct snd_jack *hp_jack;
+	struct snd_jack *lineout_jack;

 	/* dynamic controls and input_mux */
 	struct auto_pin_cfg autocfg;
@@ -3635,9 +3637,15 @@ static int stac92xx_init(struct hda_codec *codec)
 		/* jack detection */
 		err = snd_jack_new(codec->bus->card,
 			"Headphone Jack",
-			SND_JACK_HEADPHONE, &spec->jack);
+			SND_JACK_HEADPHONE, &spec->hp_jack);
 		if (err < 0)
 			return err;
+		err = snd_jack_new(codec->bus->card,
+			"Lineout Jack",
+			SND_JACK_LINEOUT, &spec->lineout_jack);
+		if (err < 0)
+			return err;
+
 		/* fake event to set up pins */
 		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
 	} else {
@@ -3661,6 +3669,16 @@ static int stac92xx_init(struct hda_codec *codec)
 	for (i = 0; i < spec->num_dmics; i++)
 		stac92xx_auto_set_pinctl(codec, spec->dmic_nids[i],
 					AC_PINCTL_IN_EN);
+	for (i = 0; i < cfg->line_outs; i++) {
+		int def_conf = snd_hda_codec_read(codec, cfg->line_out_pins[i],
+					0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+		def_conf = get_defcfg_connect(def_conf);
+
+		if (def_conf && def_conf != AC_JACK_PORT_FIXED)
+			continue;
+		enable_pin_detect(codec, cfg->line_out_pins[i],
+			STAC_LINEOUT_EVENT);
+	}
 	for (i = 0; i < spec->num_pwrs; i++)  {
 		int event = is_nid_hp_pin(cfg, spec->pwr_nids[i])
 					? STAC_HP_EVENT : STAC_PWR_EVENT;
@@ -3717,8 +3735,10 @@ static void stac92xx_free(struct hda_codec *codec)
 	if (! spec)
 		return;

-	if (spec->jack)
-		snd_device_free(codec->bus->card, spec->jack);
+	if (spec->hp_jack)
+		snd_device_free(codec->bus->card, spec->hp_jack);
+	if (spec->lineout_jack)
+		snd_device_free(codec->bus->card, spec->lineout_jack);

 	if (spec->bios_pin_configs)
 		kfree(spec->bios_pin_configs);
@@ -3804,7 +3824,7 @@ static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 			break;
 		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}
-	snd_jack_report(spec->jack,
+	snd_jack_report(spec->hp_jack,
 		presence ? SND_JACK_HEADPHONE : 0);

 	if (presence) {
@@ -3840,6 +3860,28 @@ static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 		stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
 }

+static void stac92xx_lineout_detect(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int presence, i;
+
+	for (i = 0; i < cfg->line_outs; i++) {
+		int def_conf = snd_hda_codec_read(codec,
+			cfg->line_out_pins[i], 0,
+			AC_VERB_GET_CONFIG_DEFAULT, 0);
+		def_conf = get_defcfg_connect(def_conf);
+
+		if (def_conf && def_conf != AC_JACK_PORT_FIXED)
+			continue;
+		presence = get_hp_pin_presence(codec,
+			cfg->line_out_pins[i]);
+		if (presence)
+			break;
+	}
+	snd_jack_report(spec->lineout_jack, presence ? SND_JACK_LINEOUT : 0);
+}
+
 static void stac92xx_pin_sense(struct hda_codec *codec, int idx)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -3868,15 +3910,20 @@ static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	int idx = res >> 26 & 0x0f;
+	int event = (res >> 26) & 0x70;

-	switch ((res >> 26) & 0x70) {
+	switch (event) {
 	case STAC_HP_EVENT:
 		stac92xx_hp_detect(codec, res);
 		/* fallthru */
 	case STAC_PWR_EVENT:
 		if (spec->num_pwrs > 0)
 			stac92xx_pin_sense(codec, idx);
-		break;
+		/* fallthru */
+	case STAC_LINEOUT_EVENT:
+		if (event == STAC_HP_EVENT)
+			break;
+		stac92xx_lineout_detect(codec);
 	case STAC_VREF_EVENT: {
 		int data = snd_hda_codec_read(codec, codec->afg, 0,
 			AC_VERB_GET_GPIO_DATA, 0);
