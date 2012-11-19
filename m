From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 1/2] ALSA: hda - Allow jack state to depend on
	another jack.
Date: Sun, 18 Nov 2012 22:56:39 -0800
Message-ID: <1353308200-18944-2-git-send-email-dgreid@chromium.org>
References: <1353308200-18944-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f201.google.com (mail-gg0-f201.google.com
 [209.85.161.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 000B02650E5
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 07:56:46 +0100 (CET)
Received: by mail-gg0-f201.google.com with SMTP id i24so514772ggk.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 22:56:46 -0800 (PST)
In-Reply-To: <1353308200-18944-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Introduce the concept of a "gated" jack.  The gated jack's pin sense is
only valid when the "gating" jack is plugged.  This requires checking
the gating jack when the gated jack changes and re-checking the gated
jack when the gating jack is plugged/unplugged.

This allows handling of devices where the mic jack detect floats when
the headphone jack is unplugged.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_jack.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/pci/hda/hda_jack.h |  4 ++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 5bdbada..e851d88 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -122,6 +122,8 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 	snd_array_free(&codec->jacktbl);
 }
 
+#define get_jack_plug_state(sense) !!(sense & AC_PINSENSE_PRESENCE)
+
 /* update the cached value and notification flag if needed */
 static void jack_detect_update(struct hda_codec *codec,
 			       struct hda_jack_tbl *jack)
@@ -134,6 +136,27 @@ static void jack_detect_update(struct hda_codec *codec,
 	else
 		jack->pin_sense = read_pin_sense(codec, jack->nid);
 
+	/* A gating jack indicates the jack is invalid if gating is unplugged */
+	if (jack->gating_jack &&
+	    !get_jack_plug_state(jack->gating_jack->pin_sense))
+		jack->pin_sense &= ~AC_PINSENSE_PRESENCE;
+
+	/* If a jack is gated by this one update it. */
+	if (jack->gated_jack) {
+		struct hda_jack_tbl *gated = jack->gated_jack;
+
+		if (gated->callback)
+			gated->callback(codec, gated);
+
+		/* If this jack is plugged, then check the gated jack, otherwise
+		 * not plugged.
+		 */
+		if (get_jack_plug_state(jack->pin_sense))
+			gated->pin_sense = read_pin_sense(codec, gated->nid);
+		else
+			gated->pin_sense &= ~AC_PINSENSE_PRESENCE;
+	}
+
 	jack->jack_dirty = 0;
 }
 
@@ -173,8 +196,6 @@ u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 }
 EXPORT_SYMBOL_HDA(snd_hda_pin_sense);
 
-#define get_jack_plug_state(sense) !!(sense & AC_PINSENSE_PRESENCE)
-
 /**
  * snd_hda_jack_detect - query pin Presence Detect status
  * @codec: the CODEC to sense
@@ -222,6 +243,27 @@ int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid,
 EXPORT_SYMBOL_HDA(snd_hda_jack_detect_enable);
 
 /**
+ * snd_hda_jack_set_gating_jack - Set gating jack.
+ *
+ * Indicates the gated jack is only valid when the gating jack is plugged.
+ */
+int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
+				 hda_nid_t gating_nid)
+{
+	struct hda_jack_tbl *gated = snd_hda_jack_tbl_get(codec, gated_nid);
+	struct hda_jack_tbl *gating = snd_hda_jack_tbl_get(codec, gating_nid);
+
+	if (!gated || !gating)
+		return -EINVAL;
+
+	gated->gating_jack = gating;
+	gating->gated_jack = gated;
+
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_jack_set_gating_jack);
+
+/**
  * snd_hda_jack_report_sync - sync the states of all jacks and report if changed
  */
 void snd_hda_jack_report_sync(struct hda_codec *codec)
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 4487785..71553b2 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -29,6 +29,8 @@ struct hda_jack_tbl {
 	unsigned int jack_dirty:1;	/* needs to update? */
 	unsigned int phantom_jack:1;    /* a fixed, always present port? */
 	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
+	struct hda_jack_tbl *gating_jack;/* valid when gating jack plugged */
+	struct hda_jack_tbl *gated_jack;/* gated is dependent on this jack */
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
 	struct snd_jack *jack;
@@ -69,6 +71,8 @@ int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 					unsigned char action,
 					hda_jack_callback cb);
 
+int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
+				 hda_nid_t gating_nid);
 
 u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid);
-- 
1.8.0
