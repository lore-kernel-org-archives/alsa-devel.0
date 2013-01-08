From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 049/112] ALSA: hda - Move the call of
	snd_hda_parse_pin_defcfg() from snd_hda_gen_parse_auto_config()
Date: Tue,  8 Jan 2013 12:38:42 +0100
Message-ID: <1357645185-7645-50-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A6DEE2651C6
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 025E8A525C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

In some cases, we want to manipulate the auto_pin_cfg table before
passing to snd_hda_gen_parse_auto_config() (e.g. Realtek SSID check
code fiddles with the headphone pin).   Also passing ignore_pins just
for snd_hda_parse_pin_defcfg() isn't good.

In this patch, snd_hda_gen_parse_auto_config() is changed to receive
the auto_pin_cfg table to be parsed.  The passed auto_pin_cfg table
must have been initialized (typically by calling
snd_hda_gen_parse_auto_config()) beforehand by the caller.

Also together with this change, spec->parse_flags is also removed.
Since this was referred only at the place calling
snd_hda_parse_pin_defcfg(), no longer needed to be kept in spec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 24 +++++++++++++++---------
 sound/pci/hda/hda_generic.h |  4 +---
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 49e968c..e512cab 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2785,21 +2785,23 @@ static int check_auto_mic_availability(struct hda_codec *codec)
 }
 
 
-/* parse the BIOS configuration and set up the hda_gen_spec */
-/* return 1 if successful, 0 if the proper config is not found,
+/*
+ * Parse the given BIOS configuration and set up the hda_gen_spec
+ *
+ * return 1 if successful, 0 if the proper config is not found,
  * or a negative error code
  */
 int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
-				  const hda_nid_t *ignore_nids)
+				  struct auto_pin_cfg *cfg)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int err;
 
-	err = snd_hda_parse_pin_defcfg(codec, cfg, ignore_nids,
-				       spec->parse_flags);
-	if (err < 0)
-		return err;
+	if (cfg != &spec->autocfg) {
+		spec->autocfg = *cfg;
+		cfg = &spec->autocfg;
+	}
+
 	if (!cfg->line_outs) {
 		if (cfg->dig_outs || cfg->dig_in_pin) {
 			spec->multiout.max_channels = 2;
@@ -3586,7 +3588,11 @@ int snd_hda_parse_generic_codec(struct hda_codec *codec)
 	snd_hda_gen_spec_init(spec);
 	codec->spec = spec;
 
-	err = snd_hda_gen_parse_auto_config(codec, NULL);
+	err = snd_hda_parse_pin_defcfg(codec, &spec->autocfg, NULL, 0);
+	if (err < 0)
+		return err;
+
+	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index d71e86d..1a3b404 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -152,8 +152,6 @@ struct hda_gen_spec {
 	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
 	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
 
-	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
-
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
 	struct hda_vmaster_mute_hook vmaster_mute;
@@ -197,7 +195,7 @@ snd_hda_gen_add_kctl(struct hda_gen_spec *spec, const char *name,
 		     const struct snd_kcontrol_new *temp);
 
 int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
-				  const hda_nid_t *ignore_nids);
+				  struct auto_pin_cfg *cfg);
 int snd_hda_gen_build_controls(struct hda_codec *codec);
 int snd_hda_gen_build_pcms(struct hda_codec *codec);
 
-- 
1.8.0.1
