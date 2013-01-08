From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 105/112] ALSA: hda - Use direct path reference
	in assign_out_path_ctls()
Date: Tue,  8 Jan 2013 12:39:38 +0100
Message-ID: <1357645185-7645-106-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B1CA265237
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0C1D5A53F3
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

Instead of looking through paths with the dac -> pin connection at
each time, just pass the already parsed path index to
assign_out_path_ctls().  This simplifies the code a bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 990a79e..27b5e02 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -757,23 +757,26 @@ enum {
 	BAD_SHARED_VOL = 0x10,
 };
 
-/* look for widgets in the path between the given NIDs appropriate for
+/* look for widgets in the given path which are appropriate for
  * volume and mute controls, and assign the values to ctls[].
  *
  * When no appropriate widget is found in the path, the badness value
  * is incremented depending on the situation.  The function returns the
  * total badness for both volume and mute controls.
  */
-static int assign_out_path_ctls(struct hda_codec *codec, hda_nid_t pin,
-				hda_nid_t dac)
+static int assign_out_path_ctls(struct hda_codec *codec, struct nid_path *path)
 {
-	struct nid_path *path = snd_hda_get_nid_path(codec, dac, pin);
 	hda_nid_t nid;
 	unsigned int val;
 	int badness = 0;
 
 	if (!path)
 		return BAD_SHARED_VOL * 2;
+
+	if (path->ctls[NID_PATH_VOL_CTL] ||
+	    path->ctls[NID_PATH_MUTE_CTL])
+		return 0; /* already evaluated */
+
 	nid = look_for_out_vol_nid(codec, path);
 	if (nid) {
 		val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
@@ -866,8 +869,9 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		struct nid_path *path;
 		hda_nid_t pin = pins[i];
 
-		if (dacs[i]) {
-			badness += assign_out_path_ctls(codec, pin, dacs[i]);
+		path = snd_hda_get_path_from_idx(codec, path_idx[i]);
+		if (path) {
+			badness += assign_out_path_ctls(codec, path);
 			continue;
 		}
 
@@ -916,9 +920,8 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			print_nid_path("output", path);
 			path->active = true;
 			path_idx[i] = snd_hda_get_path_idx(codec, path);
+			badness += assign_out_path_ctls(codec, path);
 		}
-		if (dac)
-			badness += assign_out_path_ctls(codec, pin, dac);
 	}
 
 	return badness;
@@ -1001,6 +1004,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 	unsigned int defcfg = snd_hda_codec_get_pincfg(codec, reference_pin);
 	unsigned int location = get_defcfg_location(defcfg);
 	int badness = 0;
+	struct nid_path *path;
 
 	old_pins = spec->multi_ios;
 	if (old_pins >= 2)
@@ -1012,7 +1016,6 @@ static int fill_multi_ios(struct hda_codec *codec,
 
 	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
 		for (i = 0; i < cfg->num_inputs; i++) {
-			struct nid_path *path;
 			hda_nid_t nid = cfg->inputs[i].pin;
 			hda_nid_t dac = 0;
 
@@ -1067,9 +1070,10 @@ static int fill_multi_ios(struct hda_codec *codec,
 	}
 
 	/* assign volume and mute controls */
-	for (i = old_pins; i < spec->multi_ios; i++)
-		badness += assign_out_path_ctls(codec, spec->multi_io[i].pin,
-						spec->multi_io[i].dac);
+	for (i = old_pins; i < spec->multi_ios; i++) {
+		path = snd_hda_get_path_from_idx(codec, spec->out_paths[cfg->line_outs + i]);
+		badness += assign_out_path_ctls(codec, path);
+	}
 
 	return badness;
 }
-- 
1.8.0.1
