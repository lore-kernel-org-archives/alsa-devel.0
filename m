From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 098/112] ALSA: hda - Drop bind-volume workaround
Date: Tue,  8 Jan 2013 12:39:31 +0100
Message-ID: <1357645185-7645-99-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 31BF426522E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 02B25A53AB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
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

The bind-volume workaround was introduced for simplifying the mixer
abstraction in the case where one or more pins of multiple outputs
lack of individual volume controls.  This was essentially the case
like Acer Aspire 5935, which has 5.1 speakers and 5.1 (multi-io)
jacks although there are 5 DACs, so some of them must share a DAC.

However, the recent code rewrite changed the DAC assignment policy to
share with the same channel instead of binding to the front, thus
binding the volumes for all channels makes little sense now, rather
it's confusing.  So in this patch, the ugly workaround is finally
dropped and simply create the volume control corresponding to the
parsed path position.

For dual headphones or 2.1 speakers with a shared volume control, it's
anyway bound to the same DAC if needed, so this change shouldn't bring
any practical difference.

And, as a good bonus, we can cut off the whole code handling the bind
volume elements.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 114 +++++++-------------------------------------
 sound/pci/hda/hda_generic.h |   3 --
 2 files changed, 17 insertions(+), 100 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index dd65d2a..15b742a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -39,7 +39,6 @@
 int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
 {
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
-	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
 	snd_array_init(&spec->paths, sizeof(struct nid_path), 8);
 	mutex_init(&spec->pcm_mutex);
 	return 0;
@@ -75,39 +74,11 @@ static void free_kctls(struct hda_gen_spec *spec)
 	snd_array_free(&spec->kctls);
 }
 
-static struct hda_bind_ctls *new_bind_ctl(struct hda_codec *codec,
-					  unsigned int nums,
-					  struct hda_ctl_ops *ops)
-{
-	struct hda_gen_spec *spec = codec->spec;
-	struct hda_bind_ctls **ctlp, *ctl;
-	ctlp = snd_array_new(&spec->bind_ctls);
-	if (!ctlp)
-		return NULL;
-	ctl = kzalloc(sizeof(*ctl) + sizeof(long) * (nums + 1), GFP_KERNEL);
-	*ctlp = ctl;
-	if (ctl)
-		ctl->ops = ops;
-	return ctl;
-}
-
-static void free_bind_ctls(struct hda_gen_spec *spec)
-{
-	if (spec->bind_ctls.list) {
-		struct hda_bind_ctls **ctl = spec->bind_ctls.list;
-		int i;
-		for (i = 0; i < spec->bind_ctls.used; i++)
-			kfree(ctl[i]);
-	}
-	snd_array_free(&spec->bind_ctls);
-}
-
 void snd_hda_gen_spec_free(struct hda_gen_spec *spec)
 {
 	if (!spec)
 		return;
 	free_kctls(spec);
-	free_bind_ctls(spec);
 	snd_array_free(&spec->paths);
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
@@ -1489,8 +1460,7 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 	return 0;
 }
 
-static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
-			    hda_nid_t dac, int path_idx,
+static int create_extra_out(struct hda_codec *codec, int path_idx,
 			    const char *pfx, int cidx)
 {
 	struct nid_path *path;
@@ -1499,12 +1469,9 @@ static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 	path = snd_hda_get_path_from_idx(codec, path_idx);
 	if (!path)
 		return 0;
-	/* bind volume control will be created in the case of dac = 0 */
-	if (dac) {
-		err = add_stereo_vol(codec, pfx, cidx, path);
-		if (err < 0)
-			return err;
-	}
+	err = add_stereo_vol(codec, pfx, cidx, path);
+	if (err < 0)
+		return err;
 	err = add_stereo_sw(codec, pfx, cidx, path);
 	if (err < 0)
 		return err;
@@ -1513,69 +1480,26 @@ static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 
 /* add playback controls for speaker and HP outputs */
 static int create_extra_outs(struct hda_codec *codec, int num_pins,
-			     const hda_nid_t *pins, const hda_nid_t *dacs,
 			     const int *paths, const char *pfx)
 {
-	struct hda_gen_spec *spec = codec->spec;
-	struct hda_bind_ctls *ctl;
-	char name[44];
-	int i, n, err;
-
-	if (!num_pins || !pins[0])
-		return 0;
-
-	if (num_pins == 1) {
-		hda_nid_t dac = *dacs;
-		if (!dac)
-			dac = spec->multiout.dac_nids[0];
-		return create_extra_out(codec, *pins, dac, paths[0], pfx, 0);
-	}
+	int i;
 
 	for (i = 0; i < num_pins; i++) {
-		hda_nid_t dac;
-		if (dacs[num_pins - 1])
-			dac = dacs[i]; /* with individual volumes */
-		else
-			dac = 0;
-		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker")) {
-			err = create_extra_out(codec, pins[i], dac, paths[i],
-					       "Bass Speaker", 0);
-		} else if (num_pins >= 3) {
-			snprintf(name, sizeof(name), "%s %s",
+		const char *name;
+		char tmp[44];
+		int err, idx = 0;
+
+		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker"))
+			name = "Bass Speaker";
+		else if (num_pins >= 3) {
+			snprintf(tmp, sizeof(tmp), "%s %s",
 				 pfx, channel_name[i]);
-			err = create_extra_out(codec, pins[i], dac, paths[i],
-					       name, 0);
+			name = tmp;
 		} else {
-			err = create_extra_out(codec, pins[i], dac, paths[i],
-					       pfx, i);
+			name = pfx;
+			idx = i;
 		}
-		if (err < 0)
-			return err;
-	}
-	if (dacs[num_pins - 1])
-		return 0;
-
-	/* Let's create a bind-controls for volumes */
-	ctl = new_bind_ctl(codec, num_pins, &snd_hda_bind_vol);
-	if (!ctl)
-		return -ENOMEM;
-	n = 0;
-	for (i = 0; i < num_pins; i++) {
-		hda_nid_t vol;
-		struct nid_path *path;
-		if (!pins[i] || !dacs[i])
-			continue;
-		path = snd_hda_get_path_from_idx(codec, paths[i]);
-		if (!path)
-			continue;
-		vol = look_for_out_vol_nid(codec, path);
-		if (vol)
-			ctl->values[n++] =
-				HDA_COMPOSE_AMP_VAL(vol, 3, 0, HDA_OUTPUT);
-	}
-	if (n) {
-		snprintf(name, sizeof(name), "%s Playback Volume", pfx);
-		err = add_control(spec, HDA_CTL_BIND_VOL, name, 0, (long)ctl);
+		err = create_extra_out(codec, paths[i], name, idx);
 		if (err < 0)
 			return err;
 	}
@@ -1586,8 +1510,6 @@ static int create_hp_out_ctls(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	return create_extra_outs(codec, spec->autocfg.hp_outs,
-				 spec->autocfg.hp_pins,
-				 spec->multiout.hp_out_nid,
 				 spec->hp_paths,
 				 "Headphone");
 }
@@ -1596,8 +1518,6 @@ static int create_speaker_out_ctls(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	return create_extra_outs(codec, spec->autocfg.speaker_outs,
-				 spec->autocfg.speaker_pins,
-				 spec->multiout.extra_out_nid,
 				 spec->speaker_paths,
 				 "Speaker");
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index d4a8f6c..4c0d9ad 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -186,9 +186,6 @@ struct hda_gen_spec {
 	int multi_ios;
 	struct hda_multi_io multi_io[4];
 
-	/* bind volumes */
-	struct snd_array bind_ctls;
-
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 	void (*automute_hook)(struct hda_codec *codec);
-- 
1.8.0.1
