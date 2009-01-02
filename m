From: Ulrich Dangel <uli@spamt.net>
Subject: [PATCH - 1/2] ALSA: hda - add basic jack reporting
	functions to patch_conexant.c
Date: Fri,  2 Jan 2009 19:30:13 +0100
Message-ID: <1230921014-7729-1-git-send-email-uli@spamt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ulrich Dangel <uli@spamt.net>
List-Id: alsa-devel@alsa-project.org

Added functions to report jack sense.
As CXT5051_PORTB_EVENT has the same value as CONEXANT_MIC_EVENT two input
devices for the microphone will be created if using CXT5051.

Signed-off-by: Ulrich Dangel <uli@spamt.net>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index 0760107..3cb640c 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <sound/core.h>
+#include <sound/jack.h>
+
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
@@ -38,8 +40,21 @@
 #define CONEXANT_HP_EVENT	0x37
 #define CONEXANT_MIC_EVENT	0x38
 
+/* Conexant 5051 specific */
+
+#define CXT5051_SPDIF_OUT	0x1C
+#define CXT5051_PORTB_EVENT	0x38
+#define CXT5051_PORTC_EVENT	0x39
 
 
+struct conexant_jack {
+
+	hda_nid_t nid;
+	int type;
+	struct snd_jack *jack;
+
+};
+
 struct conexant_spec {
 
 	struct snd_kcontrol_new *mixers[5];
@@ -84,6 +99,9 @@ struct conexant_spec {
 
 	unsigned int spdif_route;
 
+	/* jack detection */
+	struct snd_array jacks;
+
 	/* dynamic controls, init_verbs and input_mux */
 	struct auto_pin_cfg autocfg;
 	struct hda_input_mux private_imux;
@@ -330,6 +348,86 @@ static int conexant_mux_enum_put(struct snd_kcontrol *kcontrol,
 				     &spec->cur_mux[adc_idx]);
 }
 
+static int conexant_add_jack(struct hda_codec *codec,
+		hda_nid_t nid, int type)
+{
+	struct conexant_spec *spec;
+	struct conexant_jack *jack;
+	const char *name;
+
+	spec = codec->spec;
+	snd_array_init(&spec->jacks, sizeof(*jack), 32);
+	jack = snd_array_new(&spec->jacks);
+	name = (type == SND_JACK_HEADPHONE) ? "Headphone" : "Mic" ;
+
+	if (!jack)
+		return -ENOMEM;
+
+	jack->nid = nid;
+	jack->type = type;
+
+	return snd_jack_new(codec->bus->card, name, type, &jack->jack);
+}
+
+static void conexant_report_jack(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct conexant_spec *spec = codec->spec;
+	struct conexant_jack *jacks = spec->jacks.list;
+
+	if (jacks) {
+		int i;
+		for (i = 0; i < spec->jacks.used; i++) {
+			if (jacks->nid == nid) {
+				unsigned int present;
+				present = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_PIN_SENSE, 0) &
+					AC_PINSENSE_PRESENCE;
+
+				present = (present) ? jacks->type : 0 ;
+
+				snd_jack_report(jacks->jack,
+						present);
+			}
+			jacks++;
+		}
+	}
+}
+
+static int conexant_init_jacks(struct hda_codec *codec)
+{
+#ifdef CONFIG_SND_JACK
+	struct conexant_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->num_init_verbs; i++) {
+		const struct hda_verb *hv;
+
+		hv = spec->init_verbs[i];
+		while (hv->nid) {
+			int err = 0;
+			switch (hv->param ^ AC_USRSP_EN) {
+			case CONEXANT_HP_EVENT:
+				err = conexant_add_jack(codec, hv->nid,
+						SND_JACK_HEADPHONE);
+				conexant_report_jack(codec, hv->nid);
+				break;
+			case CXT5051_PORTC_EVENT:
+			case CONEXANT_MIC_EVENT:
+				err = conexant_add_jack(codec, hv->nid,
+						SND_JACK_MICROPHONE);
+				conexant_report_jack(codec, hv->nid);
+				break;
+			}
+			if (err < 0)
+				return err;
+			++hv;
+		}
+	}
+#endif
+	return 0;
+
+}
+
 static int conexant_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -342,6 +440,16 @@ static int conexant_init(struct hda_codec *codec)
 
 static void conexant_free(struct hda_codec *codec)
 {
+#ifdef CONFIG_SND_JACK
+	struct conexant_spec *spec = codec->spec;
+	if (spec->jacks.list) {
+		struct conexant_jack *jacks = spec->jacks.list;
+		int i;
+		for (i = 0; i < spec->jacks.used; i++)
+			snd_device_free(codec->bus->card, &jacks[i].jack);
+		snd_array_free(&spec->jacks);
+	}
+#endif
 	kfree(codec->spec);
 }
 
@@ -1527,9 +1635,6 @@ static int patch_cxt5047(struct hda_codec *codec)
 /* Conexant 5051 specific */
 static hda_nid_t cxt5051_dac_nids[1] = { 0x10 };
 static hda_nid_t cxt5051_adc_nids[2] = { 0x14, 0x15 };
-#define CXT5051_SPDIF_OUT	0x1C
-#define CXT5051_PORTB_EVENT	0x38
-#define CXT5051_PORTC_EVENT	0x39
 
 static struct hda_channel_mode cxt5051_modes[1] = {
 	{ 2, NULL },
-- 
1.6.0.6
