From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - Handle Headphone Mic jack more
	generic
Date: Thu, 11 Apr 2013 11:30:30 +0200
Message-ID: <1365672630-15411-4-git-send-email-david.henningsson@canonical.com>
References: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB05266018
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 11:30:24 +0200 (CEST)
In-Reply-To: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Now that we have a flag for headphone mics, we can use that flag
in the jack creation instead of creating the jack manually.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |   11 -----------
 sound/pci/hda/hda_jack.c    |   43 ++++++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d7a8eb3..c7b59dd 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4366,17 +4366,6 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 
 	free_kctls(spec); /* no longer needed */
 
-	if (spec->hp_mic_pin) {
-		int err;
-		int nid = spec->hp_mic_pin;
-		err = snd_hda_jack_add_kctl(codec, nid, "Headphone Mic", 0);
-		if (err < 0)
-			return err;
-		err = snd_hda_jack_detect_enable(codec, nid, 0);
-		if (err < 0)
-			return err;
-	}
-
 	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 1d035ef..9e0a952 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -394,7 +394,8 @@ static int get_unique_index(struct hda_codec *codec, const char *name, int idx)
 }
 
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
-			 const struct auto_pin_cfg *cfg)
+			 const struct auto_pin_cfg *cfg,
+			 const char *base_name)
 {
 	unsigned int def_conf, conn;
 	char name[44];
@@ -410,7 +411,11 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	phantom_jack = (conn != AC_JACK_PORT_COMPLEX) ||
 		       !is_jack_detectable(codec, nid);
 
-	snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
+	if (base_name) {
+		strlcpy(name, base_name, sizeof(name));
+		idx = 0;
+	} else
+		snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
 	if (phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
@@ -433,39 +438,51 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
 	const hda_nid_t *p;
 	int i, err;
 
+	for (i = 0; i < cfg->num_inputs; i++) {
+		/* If we have headphone mics; make sure they get the right name
+		   before grabbed by output pins */
+		if (cfg->inputs[i].is_headphone_mic) {
+			if (auto_cfg_hp_outs(cfg) == 1)
+				err = add_jack_kctl(codec, auto_cfg_hp_pins(cfg)[0],
+						    cfg, "Headphone Mic");
+			else
+				err = add_jack_kctl(codec, cfg->inputs[i].pin,
+						    cfg, "Headphone Mic");
+		} else
+			err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
+					    NULL);
+		if (err < 0)
+			return err;
+	}
+
 	for (i = 0, p = cfg->line_out_pins; i < cfg->line_outs; i++, p++) {
-		err = add_jack_kctl(codec, *p, cfg);
+		err = add_jack_kctl(codec, *p, cfg, NULL);
 		if (err < 0)
 			return err;
 	}
 	for (i = 0, p = cfg->hp_pins; i < cfg->hp_outs; i++, p++) {
 		if (*p == *cfg->line_out_pins) /* might be duplicated */
 			break;
-		err = add_jack_kctl(codec, *p, cfg);
+		err = add_jack_kctl(codec, *p, cfg, NULL);
 		if (err < 0)
 			return err;
 	}
 	for (i = 0, p = cfg->speaker_pins; i < cfg->speaker_outs; i++, p++) {
 		if (*p == *cfg->line_out_pins) /* might be duplicated */
 			break;
-		err = add_jack_kctl(codec, *p, cfg);
-		if (err < 0)
-			return err;
-	}
-	for (i = 0; i < cfg->num_inputs; i++) {
-		err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg);
+		err = add_jack_kctl(codec, *p, cfg, NULL);
 		if (err < 0)
 			return err;
 	}
 	for (i = 0, p = cfg->dig_out_pins; i < cfg->dig_outs; i++, p++) {
-		err = add_jack_kctl(codec, *p, cfg);
+		err = add_jack_kctl(codec, *p, cfg, NULL);
 		if (err < 0)
 			return err;
 	}
-	err = add_jack_kctl(codec, cfg->dig_in_pin, cfg);
+	err = add_jack_kctl(codec, cfg->dig_in_pin, cfg, NULL);
 	if (err < 0)
 		return err;
-	err = add_jack_kctl(codec, cfg->mono_out_pin, cfg);
+	err = add_jack_kctl(codec, cfg->mono_out_pin, cfg, NULL);
 	if (err < 0)
 		return err;
 	return 0;
-- 
1.7.9.5
