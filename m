From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] HDA: Generic input jack handling
Date: Fri, 07 Oct 2011 13:49:46 +0200
Message-ID: <4E8EE75A.3050809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 93DB4103B55
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:49:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

So, this is what I had in mind for 3.2. Assuming positive feedback from 
Takashi I'll go ahead and make a real patch out of this, and to clean up 
the Realtek implementation, as well as probably add this method for more 
codecs.

Thoughts:

1) The unsol event tags vary wildly between different vendors. How about 
standardising that as well?

2) If alc_init_jacks would call the new method, that might regress 
model-based (non auto) parsers. Is that a big deal these days?

3) Todo for realtek parser is to clean up all other calls to 
snd_input_jack_report so that jacks are not reported twice.

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e9b039c..69390fd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5284,6 +5284,142 @@ int snd_hda_input_jack_add(struct hda_codec 
*codec, hda_nid_t nid, int type,
  }
  EXPORT_SYMBOL_HDA(snd_hda_input_jack_add);

+/**
+ * snd_hda_input_auto_jack_add - Add relevant input jacks based on
+ * auto pin configuration.
+ * @param unsol_tags lists of jack types to enable, terminate with
+ * list entry with jack_type set to 0. If unsol_tag is set to 0,
+ * unsol events will not be enabled for that jack type.
+ * @return 0 or error code
+ */
+int snd_hda_input_auto_jack_add(struct hda_codec *codec,
+				const struct auto_pin_cfg *cfg,
+				const struct hda_unsol_jack_tag* unsol_tags)
+{
+	for (; unsol_tags->jack_type; unsol_tags++) {
+		hda_nid_t nid_list_storage[AUTO_CFG_MAX_INS];
+		const hda_nid_t *nid_list;
+		int nid_count = 0;
+		int i;
+		int input_match = AUTO_PIN_MIC;
+
+		switch (unsol_tags->jack_type) {
+		case SND_JACK_LINEIN:
+			input_match = AUTO_PIN_LINE_IN;
+			/* Fall through */
+		case SND_JACK_MICROPHONE:
+			for (i = 0; i < cfg->num_inputs; i++) {
+				if (cfg->inputs[i].type == input_match)
+					nid_list_storage[nid_count++] = cfg->inputs[i].pin;
+			}
+			nid_list = nid_list_storage;
+			break;
+		case SND_JACK_HEADPHONE:
+			if (cfg->line_out_type == AUTO_PIN_HP_OUT) {
+				nid_list = cfg->line_out_pins;
+				nid_count = cfg->line_outs;
+			} else {
+				nid_list = cfg->hp_pins;
+				nid_count = cfg->hp_outs;
+			}
+			break;
+		case SND_JACK_LINEOUT:
+			if (cfg->line_out_type == AUTO_PIN_LINE_OUT) {
+				nid_list = cfg->line_out_pins;
+				nid_count = cfg->line_outs;
+			}
+			break;			
+		}
+
+		for (i = 0; i < nid_count; i++) {
+			int pin = nid_list[i];
+			int err;
+			if (!is_jack_detectable(codec, pin))
+				continue;
+
+			if (unsol_tags->unsol_tag) {
+				err = snd_hda_codec_write(codec, pin, 0,
+					AC_VERB_SET_UNSOLICITED_ENABLE,
+					AC_USRSP_EN | unsol_tags->unsol_tag);
+				if (err)
+					return err;
+			}
+
+			err = snd_hda_input_jack_add(codec, pin,
+					unsol_tags->jack_type, NULL);
+			if (err)
+				return err;
+			snd_hda_input_jack_report(codec, pin);
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_input_auto_jack_add);
+
+void snd_hda_input_jack_report_type(struct hda_codec *codec, int jack_type)
+{
+	struct hda_jack_item *jacks = codec->jacks.list;
+	int i;
+
+	if (!jacks)
+		return;
+
+	for (i = 0; i < codec->jacks.used; i++, jacks++)
+		if (jacks->type == jack_type)
+			snd_hda_input_jack_report(codec, jacks->nid);
+}
+EXPORT_SYMBOL_HDA(snd_hda_input_jack_report_type);
+
+
  void snd_hda_input_jack_report(struct hda_codec *codec, hda_nid_t nid)
  {
  	struct hda_jack_item *jacks = codec->jacks.list;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 46c581c..bb59a3f 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -678,11 +678,21 @@ void snd_print_channel_allocation(int spk_alloc, 
char *buf, int buflen);
  /*
   * Input-jack notification support
   */
+
+struct hda_unsol_jack_tag {
+	int jack_type; /* SND_JACK_xxx constant */
+	int unsol_tag; /* event tag */
+};
+
  #ifdef CONFIG_SND_HDA_INPUT_JACK
  int snd_hda_input_jack_add(struct hda_codec *codec, hda_nid_t nid, int 
type,
  			   const char *name);
  void snd_hda_input_jack_report(struct hda_codec *codec, hda_nid_t nid);
+void snd_hda_input_jack_report_type(struct hda_codec *codec, int 
jack_type);
  void snd_hda_input_jack_free(struct hda_codec *codec);
+int snd_hda_input_auto_jack_add(struct hda_codec *codec,
+				const struct auto_pin_cfg *cfg,
+				const struct hda_unsol_jack_tag *unsol_tags);
  #else /* CONFIG_SND_HDA_INPUT_JACK */
  static inline int snd_hda_input_jack_add(struct hda_codec *codec,
  					 hda_nid_t nid, int type,
@@ -694,9 +704,19 @@ static inline void snd_hda_input_jack_report(struct 
hda_codec *codec,
  					     hda_nid_t nid)
  {
  }
+static inline void snd_hda_input_jack_report_type(struct hda_codec *codec,
+						  int jack_type)
+{
+}
  static inline void snd_hda_input_jack_free(struct hda_codec *codec)
  {
  }
+static inline int snd_hda_input_auto_jack_add(struct hda_codec *codec,
+				const struct auto_pin_cfg *cfg,
+				const struct hda_unsol_jack_tag *unsol_tags)
+{
+	return 0;
+}
  #endif /* CONFIG_SND_HDA_INPUT_JACK */

  #endif /* __SOUND_HDA_LOCAL_H */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bf53663..90cdd6c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -38,6 +38,7 @@
  #define ALC_DCVOL_EVENT		0x02
  #define ALC_HP_EVENT		0x04
  #define ALC_MIC_EVENT		0x08
+#define ALC_LINEIN_EVENT	0x10

  /* for GPIO Poll */
  #define GPIO_MASK	0x03
@@ -441,11 +442,21 @@ static void alc_fix_pll_init(struct hda_codec 
*codec, hda_nid_t nid,
   * Jack-reporting via input-jack layer
   */

+static const struct hda_unsol_jack_tag unsol_tags[] = {
+	{.jack_type = SND_JACK_HEADPHONE, .unsol_tag = ALC_HP_EVENT },
+	{.jack_type = SND_JACK_LINEOUT, .unsol_tag = ALC_FRONT_EVENT },
+	{.jack_type = SND_JACK_MICROPHONE, .unsol_tag = ALC_MIC_EVENT },
+	{.jack_type = SND_JACK_LINEIN, .unsol_tag = ALC_LINEIN_EVENT },
+	{} /* Zero terminator */
+};
+
  /* initialization of jacks; currently checks only a few known pins */
  static int alc_init_jacks(struct hda_codec *codec)
  {
  #ifdef CONFIG_SND_HDA_INPUT_JACK
  	struct alc_spec *spec = codec->spec;
+	snd_hda_input_auto_jack_add(codec, &spec->autocfg, unsol_tags);
+/*	;
  	int err;
  	unsigned int hp_nid = spec->autocfg.hp_pins[0];
  	unsigned int mic_nid = spec->ext_mic_pin;
@@ -472,7 +483,7 @@ static int alc_init_jacks(struct hda_codec *codec)
  		if (err < 0)
  			return err;
  		snd_hda_input_jack_report(codec, dock_nid);
-	}
+	}*/
  #endif /* CONFIG_SND_HDA_INPUT_JACK */
  	return 0;
  }
@@ -645,12 +656,18 @@ static void alc_sku_unsol_event(struct hda_codec 
*codec, unsigned int res)
  	switch (res) {
  	case ALC_HP_EVENT:
  		alc_hp_automute(codec);
+		snd_hda_input_jack_report_type(codec, SND_JACK_HEADPHONE);
  		break;
  	case ALC_FRONT_EVENT:
  		alc_line_automute(codec);
+		snd_hda_input_jack_report_type(codec, SND_JACK_LINEOUT);
  		break;
  	case ALC_MIC_EVENT:
  		alc_mic_automute(codec);
+		snd_hda_input_jack_report_type(codec, SND_JACK_MICROPHONE);
+		break;
+	case ALC_LINEIN_EVENT:
+		snd_hda_input_jack_report_type(codec, SND_JACK_LINEIN);
  		break;
  	}
  }

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
