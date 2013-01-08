From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 010/112] ALSA: hda/realtek - Parse analog
	loopback paths more generically
Date: Tue,  8 Jan 2013 12:38:03 +0100
Message-ID: <1357645185-7645-11-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 169B8265176
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 2D871A51FF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

Improve the parser of analog loopback paths and handle in a more
generic way.  The following changes are included in this patch:

- Instead of assuming direct connections between pins and
  the mixer widget, track the whole path between them.  This fixes
  some missing connections like ALC660.

- Introduce the path list for loopback paths like input and output
  path lists.  Currently it's not used for any real purposes, yet.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9d983a2..6b3e67c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -203,6 +203,9 @@ struct alc_spec {
 	/* input paths */
 	struct snd_array in_path;
 
+	/* analog loopback paths */
+	struct snd_array loopback_path;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2436,6 +2439,7 @@ static void alc_free(struct hda_codec *codec)
 	alc_free_bind_ctls(codec);
 	snd_array_free(&spec->out_path);
 	snd_array_free(&spec->in_path);
+	snd_array_free(&spec->loopback_path);
 	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
@@ -2660,12 +2664,22 @@ static void add_loopback_list(struct alc_spec *spec, hda_nid_t mix, int idx)
 #endif
 
 /* create input playback/capture controls for the given pin */
-static int new_analog_input(struct alc_spec *spec, hda_nid_t pin,
+static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 			    const char *ctlname, int ctlidx,
-			    int idx, hda_nid_t mix_nid)
+			    hda_nid_t mix_nid)
 {
-	int err;
+	struct alc_spec *spec = codec->spec;
+	struct nid_path *path;
+	int err, idx;
+
+	path = snd_array_new(&spec->loopback_path);
+	if (!path)
+		return -ENOMEM;
+	memset(path, 0, sizeof(*path));
+	if (!parse_nid_path(codec, pin, mix_nid, 2, path))
+		return -EINVAL;
 
+	idx = path->idx[path->depth - 1];
 	err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, ctlname, ctlidx,
 			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
 	if (err < 0)
@@ -2706,6 +2720,15 @@ static int alc_is_input_pin(struct hda_codec *codec, hda_nid_t nid)
 	return (pincap & AC_PINCAP_IN) != 0;
 }
 
+/* check whether the given two widgets can be connected */
+static bool is_reachable_path(struct hda_codec *codec,
+			      hda_nid_t from_nid, hda_nid_t to_nid)
+{
+	if (!from_nid || !to_nid)
+		return false;
+	return snd_hda_get_conn_index(codec, to_nid, from_nid, true) >= 0;
+}
+
 /* Parse the codec tree and retrieve ADCs and corresponding capsrc MUXs */
 static int alc_auto_fill_adc_caps(struct hda_codec *codec)
 {
@@ -2787,11 +2810,9 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 		prev_label = label;
 
 		if (mixer) {
-			idx = get_connection_index(codec, mixer, pin);
-			if (idx >= 0) {
-				err = new_analog_input(spec, pin,
-						       label, type_idx,
-						       idx, mixer);
+			if (is_reachable_path(codec, pin, mixer)) {
+				err = new_analog_input(codec, pin,
+						       label, type_idx, mixer);
 				if (err < 0)
 					return err;
 			}
@@ -4572,6 +4593,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
 	snd_array_init(&spec->out_path, sizeof(struct nid_path), 8);
 	snd_array_init(&spec->in_path, sizeof(struct nid_path), 8);
+	snd_array_init(&spec->loopback_path, sizeof(struct nid_path), 8);
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
-- 
1.8.0.1
