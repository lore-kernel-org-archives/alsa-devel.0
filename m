From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH4/4] hda: add support for jack detection on IDT
	codecs.
Date: Sat, 25 Oct 2008 01:06:04 -0400
Message-ID: <4902A93C.40909@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 567D724373
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 07:06:30 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This patch adds support to the IDT codec families to report jack status
to the jack abstraction layer. This required some reorganization in the
stac92xx_unsol_event function in which the index value is changed to
reporting the nid with the event.

Also adds an sigmatel_jack struct to keep track of the nid relation
to the jack abstraction layer instance. Also adds functions to set and
retrieve data values for each nid, this is used in stac92xx_unsol_event
to retrieve the GPIO mask for STAC_VREF_EVENT.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d106ea5..c24d22f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -36,6 +36,7 @@
 #include "hda_patch.h"
 #include "hda_beep.h"

+#define STAC_INSERT_EVENT	0x10
 #define STAC_PWR_EVENT		0x20
 #define STAC_HP_EVENT		0x30
 #define STAC_VREF_EVENT		0x40
@@ -129,6 +130,17 @@ enum {
 	STAC_927X_MODELS
 };

+struct sigmatel_event {
+	hda_nid_t nid;
+	int data;
+};
+
+struct sigmatel_jack {
+	hda_nid_t nid;
+	int type;
+	struct snd_jack *jack;
+};
+
 struct sigmatel_spec {
 	struct snd_kcontrol_new *mixers[4];
 	unsigned int num_mixers;
@@ -161,6 +173,12 @@ struct sigmatel_spec {
 	hda_nid_t *pwr_nids;
 	hda_nid_t *dac_list;

+	/* jack detection */
+	struct snd_array jacks;
+
+	/* events */
+	struct snd_array events;
+
 	/* playback */
 	struct hda_input_mux *mono_mux;
 	struct hda_input_mux *amp_mux;
@@ -216,9 +234,6 @@ struct sigmatel_spec {

 	struct hda_pcm pcm_rec[2];	/* PCM information */

-	/* jack detection */
-	struct snd_jack *jack;
-
 	/* dynamic controls and input_mux */
 	struct auto_pin_cfg autocfg;
 	struct snd_array kctls;
@@ -2458,13 +2473,15 @@ static int stac92xx_hp_switch_put(struct snd_kcontrol
*kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int nid = cfg->hp_pins[cfg->hp_outs - 1];

 	spec->hp_switch = ucontrol->value.integer.value[0];

 	/* check to be sure that the ports are upto date with
 	 * switch changes
 	 */
-	codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+	codec->patch_ops.unsol_event(codec, (STAC_HP_EVENT | nid) << 26);

 	return 1;
 }
@@ -2504,7 +2521,8 @@ static int stac92xx_io_switch_put(struct snd_kcontrol
*kcontrol, struct snd_ctl_
 	 * appropriately according to the pin direction
 	 */
 	if (spec->hp_detect)
-		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+		codec->patch_ops.unsol_event(codec,
+			(STAC_HP_EVENT | nid) << 26);

         return 1;
 }
@@ -3574,13 +3592,70 @@ static void stac_gpio_set(struct hda_codec *codec,
unsigned int mask,
 			   AC_VERB_SET_GPIO_DATA, gpiostate); /* sync */
 }

+static int stac92xx_add_jack(struct hda_codec *codec,
+		hda_nid_t nid, int type)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct sigmatel_jack *jack;
+	int def_conf = snd_hda_codec_read(codec, nid,
+			0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+	int connectivity = get_defcfg_connect(def_conf);
+	char name[32];
+
+	if (connectivity && connectivity != AC_JACK_PORT_FIXED)
+		return 0;
+
+	snd_array_init(&spec->jacks, sizeof(*jack), 32);
+	jack = snd_array_new(&spec->jacks);
+	if (!jack)
+		return -ENOMEM;
+	jack->nid = nid;
+	jack->type = type;
+
+	sprintf(name, "%s at %s %s Jack",
+		snd_hda_get_jack_type(def_conf),
+		snd_hda_get_jack_connectivity(def_conf),
+		snd_hda_get_jack_location(def_conf));
+
+	return snd_jack_new(codec->bus->card, name, type, &jack->jack);
+}
+
+static int stac92xx_add_event(struct sigmatel_spec *spec, hda_nid_t nid,
+			     int data)
+{
+	struct sigmatel_event *event;
+
+	snd_array_init(&spec->events, sizeof(*event), 32);
+	event = snd_array_new(&spec->events);
+	if (!event)
+		return -ENOMEM;
+	event->nid = nid;
+	event->data = data;
+
+	return 0;
+}
+
+static int stac92xx_event_data(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct sigmatel_event *events = spec->events.list;
+	if (events) {
+		int i;
+		for (i = 0; i < spec->events.used; i++)
+			if (events[i].nid == nid)
+				return events[i].data;
+	}
+	return 0;
+}
+
 static void enable_pin_detect(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int event)
 {
-	if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP)
+	if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_UNSOLICITED_ENABLE,
-					  (AC_USRSP_EN | event));
+					  (AC_USRSP_EN | event | nid));
+	}
 }

 static int is_nid_hp_pin(struct auto_pin_cfg *cfg, hda_nid_t nid)
@@ -3623,27 +3698,36 @@ static int stac92xx_init(struct hda_codec *codec)
 	/* set up pins */
 	if (spec->hp_detect) {
 		/* Enable unsolicited responses on the HP widget */
-		for (i = 0; i < cfg->hp_outs; i++)
-			enable_pin_detect(codec, cfg->hp_pins[i],
-					  STAC_HP_EVENT);
+		for (i = 0; i < cfg->hp_outs; i++) {
+			int type = SND_JACK_HEADPHONE;
+			hda_nid_t nid = cfg->hp_pins[i];
+			enable_pin_detect(codec, nid, STAC_HP_EVENT | nid);
+			/* jack detection */
+			if (cfg->hp_outs == i)
+				type |= SND_JACK_LINEOUT;
+			err = stac92xx_add_jack(codec, nid, type);
+			if (err < 0)
+				return err;
+
+		}
 		/* force to enable the first line-out; the others are set up
 		 * in unsol_event
 		 */
 		stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
-					 AC_PINCTL_OUT_EN);
-		stac92xx_auto_init_hp_out(codec);
-		/* jack detection */
-		err = snd_jack_new(codec->bus->card,
-			"Headphone Jack",
-			SND_JACK_HEADPHONE, &spec->jack);
-		if (err < 0)
-			return err;
+				AC_PINCTL_OUT_EN);
 		/* fake event to set up pins */
-		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+		codec->patch_ops.unsol_event(codec,
+			(STAC_HP_EVENT | spec->autocfg.hp_pins[0]) << 26);
 	} else {
 		stac92xx_auto_init_multi_out(codec);
 		stac92xx_auto_init_hp_out(codec);
 	}
+	for (i = 0; i < cfg->line_outs; i++) {
+		err = stac92xx_add_jack(codec,
+				cfg->line_out_pins[i], SND_JACK_LINEOUT);
+		if (err < 0)
+			return err;
+	}
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
 		hda_nid_t nid = cfg->input_pins[i];
 		if (nid) {
@@ -3656,6 +3740,11 @@ static int stac92xx_init(struct hda_codec *codec)
 			if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC)
 				pinctl |= stac92xx_get_vref(codec, nid);
 			stac92xx_auto_set_pinctl(codec, nid, pinctl);
+			err = stac92xx_add_jack(codec, nid,
+				SND_JACK_MICROPHONE);
+			if (err < 0)
+				return err;
+			enable_pin_detect(codec, nid, STAC_INSERT_EVENT | nid);
 		}
 	}
 	for (i = 0; i < spec->num_dmics; i++)
@@ -3697,6 +3786,18 @@ static int stac92xx_init(struct hda_codec *codec)
 	return 0;
 }

+static void stac92xx_free_jacks(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	if (spec->jacks.list) {
+		struct sigmatel_jack *jacks = spec->jacks.list;
+		int i;
+		for (i = 0; i < spec->jacks.used; i++)
+			snd_device_free(codec->bus->card, &jacks[i].jack);
+	}
+	snd_array_free(&spec->jacks);
+}
+
 static void stac92xx_free_kctls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -3717,11 +3818,10 @@ static void stac92xx_free(struct hda_codec *codec)
 	if (! spec)
 		return;

-	if (spec->jack)
-		snd_device_free(codec->bus->card, spec->jack);
-
 	if (spec->bios_pin_configs)
 		kfree(spec->bios_pin_configs);
+	stac92xx_free_jacks(codec);
+	snd_array_free(&spec->events);

 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
@@ -3804,8 +3904,6 @@ static void stac92xx_hp_detect(struct hda_codec *codec,
unsigned int res)
 			break;
 		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}
-	snd_jack_report(spec->jack,
-		presence ? SND_JACK_HEADPHONE : 0);

 	if (presence) {
 		/* disable lineouts, enable hp */
@@ -3862,24 +3960,57 @@ static void stac92xx_pin_sense(struct hda_codec *codec,
int idx)

 	/* power down unused output ports */
 	snd_hda_codec_write(codec, codec->afg, 0, 0x7ec, val);
-};
+}
+
+static void stac92xx_report_jack(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct sigmatel_jack *jacks = spec->jacks.list;
+
+	if (jacks) {
+		int i;
+		for (i = 0; i < spec->jacks.used; i++) {
+			if (jacks->nid == nid) {
+				unsigned int pin_ctl =
+					snd_hda_codec_read(codec, nid,
+					0, AC_VERB_GET_PIN_WIDGET_CONTROL,
+					 0x00);
+				int type = jacks->type;
+				if (type == (SND_JACK_LINEOUT
+						| SND_JACK_HEADPHONE))
+					type = (pin_ctl & AC_PINCTL_HP_EN)
+					? SND_JACK_HEADPHONE : SND_JACK_LINEOUT;
+				snd_jack_report(jacks->jack,
+					get_hp_pin_presence(codec, nid)
+					? type : 0);
+			}
+			jacks++;
+		}
+	}
+}

 static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	int idx = res >> 26 & 0x0f;
+	int event = (res >> 26) & 0x70;
+	int nid = res >> 26 & 0x0f;

-	switch ((res >> 26) & 0x70) {
+	switch (event) {
 	case STAC_HP_EVENT:
 		stac92xx_hp_detect(codec, res);
 		/* fallthru */
+	case STAC_INSERT_EVENT:
 	case STAC_PWR_EVENT:
-		if (spec->num_pwrs > 0)
-			stac92xx_pin_sense(codec, idx);
+		if (nid) {
+			if (spec->num_pwrs > 0)
+				stac92xx_pin_sense(codec, nid);
+			stac92xx_report_jack(codec, nid);
+		}
 		break;
 	case STAC_VREF_EVENT: {
 		int data = snd_hda_codec_read(codec, codec->afg, 0,
 			AC_VERB_GET_GPIO_DATA, 0);
+		int idx = stac92xx_event_data(codec, nid);
 		/* toggle VREF state based on GPIOx status */
 		snd_hda_codec_write(codec, codec->afg, 0, 0x7e0,
 			!!(data & (1 << idx)));
@@ -4402,8 +4533,11 @@ again:
 			snd_hda_codec_write(codec, codec->afg, 0,
 				AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
 			snd_hda_codec_write_cache(codec, codec->afg, 0,
-					AC_VERB_SET_UNSOLICITED_ENABLE,
-					(AC_USRSP_EN | STAC_VREF_EVENT | 0x01));
+				AC_VERB_SET_UNSOLICITED_ENABLE,
+				(AC_USRSP_EN | STAC_VREF_EVENT | codec->afg));
+			err = stac92xx_add_event(spec, codec->afg, 0x02);
+			if (err < 0)
+				return err;
 			spec->gpio_mask |= 0x02;
 			break;
 		}
@@ -4802,8 +4936,11 @@ static int patch_stac9205(struct hda_codec *codec)
 		snd_hda_codec_write(codec, codec->afg, 0,
 			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
 		snd_hda_codec_write_cache(codec, codec->afg, 0,
-					  AC_VERB_SET_UNSOLICITED_ENABLE,
-					  (AC_USRSP_EN | STAC_HP_EVENT));
+			AC_VERB_SET_UNSOLICITED_ENABLE,
+			(AC_USRSP_EN | STAC_VREF_EVENT | codec->afg));
+		err = stac92xx_add_event(spec, codec->afg, 0x01);
+		if (err < 0)
+			return err;

 		spec->gpio_dir = 0x0b;
 		spec->eapd_mask = 0x01;
