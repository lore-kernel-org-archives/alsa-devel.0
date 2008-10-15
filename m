From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add support for jack detection on
	IDT/Sigmatel
Date: Wed, 15 Oct 2008 10:43:28 -0400
Message-ID: <48F60190.5060601@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 0B5CD24733
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 16:43:52 +0200 (CEST)
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

Added support for jack detection reporting to userspace for
IDT/Sigmatel codecs.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/core/jack.c b/core/jack.c
index 8133a2b..7a5b07b 100644
--- a/core/jack.c
+++ b/core/jack.c
@@ -95,7 +95,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		goto fail_input;
 	}

-	jack->input_dev->phys = "ALSA";
+	jack->input_dev->phys = "ALSA Jack Detection";

 	jack->type = type;

diff --git a/pci/Kconfig b/pci/Kconfig
index 7003711..7e40890 100644
--- a/pci/Kconfig
+++ b/pci/Kconfig
@@ -501,6 +501,7 @@ config SND_HDA_INTEL
 	tristate "Intel HD Audio"
 	select SND_PCM
 	select SND_VMASTER
+	select SND_JACK if INPUT=y || INPUT=SND
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) motherboard devices.
diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index 60468f5..93dc961 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -729,6 +729,9 @@ struct hda_codec {

 	struct snd_hwdep *hwdep;	/* assigned hwdep device */

+	/* jack detection */
+	struct snd_jack *jack;
+
 	/* misc flags */
 	unsigned int spdif_status_reset :1; /* needs to toggle SPDIF for each
 					     * status change
diff --git a/pci/hda/hda_proc.c b/pci/hda/hda_proc.c
index 743d779..e07652a 100644
--- a/pci/hda/hda_proc.c
+++ b/pci/hda/hda_proc.c
@@ -425,6 +425,22 @@ static void print_unsol_cap(struct snd_info_buffer *buffer,
 		    (unsol & AC_UNSOL_ENABLED) ? 1 : 0);
 }

+static void print_presence_cap(struct snd_info_buffer *buffer,
+			      struct hda_codec *codec, hda_nid_t nid)
+{
+	int presence = snd_hda_codec_read(codec, nid, 0,
+			AC_VERB_GET_PIN_SENSE, 0);
+	int def_conf = snd_hda_codec_read(codec, nid, 0,
+			AC_VERB_GET_CONFIG_DEFAULT, 0x00);
+	def_conf = get_defcfg_connect(def_conf);
+	if (def_conf && def_conf != AC_JACK_PORT_FIXED)
+		return;
+	snd_iprintf(buffer,
+			"  Jack Presence: %s\n",
+			(presence & AC_PINSENSE_PRESENCE)
+				? "Plugged in" : "Unplugged");
+}
+
 static void print_proc_caps(struct snd_info_buffer *buffer,
 			    struct hda_codec *codec, hda_nid_t nid)
 {
@@ -552,6 +568,9 @@ static void print_codec_info(struct snd_info_entry *entry,
 					   AC_PAR_AUDIO_WIDGET_CAP);
 		unsigned int wid_type =
 			(wid_caps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+		unsigned int pincap = snd_hda_param_read(codec, nid,
+					 AC_PAR_PIN_CAP);
+
 		hda_nid_t conn[HDA_MAX_CONNECTIONS];
 		int conn_len = 0;

@@ -632,6 +651,9 @@ static void print_codec_info(struct snd_info_entry *entry,
 		if (wid_caps & AC_WCAP_UNSOL_CAP)
 			print_unsol_cap(buffer, codec, nid);

+		if (pincap & AC_PINCAP_PRES_DETECT)
+			print_presence_cap(buffer, codec, nid);
+
 		if (wid_caps & AC_WCAP_POWER)
 			print_power_state(buffer, codec, nid);

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index a2ac720..a406fa7 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
+#include <sound/jack.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
@@ -3617,7 +3618,7 @@ static int stac92xx_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
+	int i, err;

 	snd_hda_sequence_write(codec, spec->init);

@@ -3639,6 +3640,12 @@ static int stac92xx_init(struct hda_codec *codec)
 		stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
 					 AC_PINCTL_OUT_EN);
 		stac92xx_auto_init_hp_out(codec);
+		/* jack detection */
+		err = snd_jack_new(codec->bus->card,
+			"Headphone Jack Detection",
+			SND_JACK_HEADPHONE, &codec->jack);
+		if (err < 0)
+			return err;
 		/* fake event to set up pins */
 		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
 	} else {
@@ -3797,6 +3804,10 @@ static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}

+	if (codec->jack)
+		snd_jack_report(codec->jack,
+			presence ? SND_JACK_HEADPHONE : 0);
+
 	if (presence) {
 		/* disable lineouts, enable hp */
 		if (spec->hp_switch)
