From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda - Fix invalid mute in path
	activation
Date: Fri, 18 Jan 2013 11:24:02 +0100
Message-ID: <1358504643-13593-4-git-send-email-tiwai@suse.de>
References: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21990265E02
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:05 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id DFD1BA3DDF
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:04 +0100 (CET)
In-Reply-To: <1358504643-13593-1-git-send-email-tiwai@suse.de>
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

When an amp in the activation path is associated with mixer controls,
activate_amp() tries to skip the initialization.  It's good, but only
if the mixer really initializes both mute and volume.  Otherwise,
either the mute of the volume is left uninitialized.

This patch adds this missing check and properly initialize the
partially controlled amps in an activation path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 60 +++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ebb5584..edec98f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -315,11 +315,10 @@ static bool is_ctl_used(struct hda_codec *codec, unsigned int val, int type)
 
 /* check whether a control with the given (nid, dir, idx) was assigned */
 static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
-			      int dir, int idx)
+			      int dir, int idx, int type)
 {
 	unsigned int val = HDA_COMPOSE_AMP_VAL(nid, 3, idx, dir);
-	return is_ctl_used(codec, val, NID_PATH_VOL_CTL) ||
-		is_ctl_used(codec, val, NID_PATH_MUTE_CTL);
+	return is_ctl_used(codec, val, type);
 }
 
 static void print_nid_path(const char *pfx, struct nid_path *path)
@@ -590,12 +589,10 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 
 /* get the default amp value for the target state */
 static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
-				   int dir, bool enable)
+				   int dir, unsigned int caps, bool enable)
 {
-	unsigned int caps;
 	unsigned int val = 0;
 
-	caps = query_amp_caps(codec, nid, dir);
 	if (caps & AC_AMPCAP_NUM_STEPS) {
 		/* set to 0dB */
 		if (enable)
@@ -611,19 +608,49 @@ static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
 /* initialize the amp value (only at the first time) */
 static void init_amp(struct hda_codec *codec, hda_nid_t nid, int dir, int idx)
 {
-	int val = get_amp_val_to_activate(codec, nid, dir, false);
+	unsigned int caps = query_amp_caps(codec, nid, dir);
+	int val = get_amp_val_to_activate(codec, nid, dir, caps, false);
 	snd_hda_codec_amp_init_stereo(codec, nid, dir, idx, 0xff, val);
 }
 
+/* calculate amp value mask we can modify;
+ * if the given amp is controlled by mixers, don't touch it
+ */
+static unsigned int get_amp_mask_to_modify(struct hda_codec *codec,
+					   hda_nid_t nid, int dir, int idx,
+					   unsigned int caps)
+{
+	unsigned int mask = 0xff;
+
+	if (caps & AC_AMPCAP_MUTE) {
+		if (is_ctl_associated(codec, nid, dir, idx, NID_PATH_MUTE_CTL))
+			mask &= ~0x80;
+	}
+	if (caps & AC_AMPCAP_NUM_STEPS) {
+		if (is_ctl_associated(codec, nid, dir, idx, NID_PATH_VOL_CTL) ||
+		    is_ctl_associated(codec, nid, dir, idx, NID_PATH_BOOST_CTL))
+			mask &= ~0x7f;
+	}
+	return mask;
+}
+
 static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
-			 int idx, bool enable)
+			 int idx, int idx_to_check, bool enable)
 {
-	int val;
-	if (is_ctl_associated(codec, nid, dir, idx) ||
-	    (!enable && is_active_nid(codec, nid, dir, idx)))
+	unsigned int caps;
+	unsigned int mask, val;
+
+	if (!enable && is_active_nid(codec, nid, dir, idx))
+		return;
+
+	caps = query_amp_caps(codec, nid, dir);
+	val = get_amp_val_to_activate(codec, nid, dir, caps, enable);
+	mask = get_amp_mask_to_modify(codec, nid, dir, idx_to_check, caps);
+	if (!mask)
 		return;
-	val = get_amp_val_to_activate(codec, nid, dir, enable);
-	snd_hda_codec_amp_stereo(codec, nid, dir, idx, 0xff, val);
+
+	val &= mask;
+	snd_hda_codec_amp_stereo(codec, nid, dir, idx, mask, val);
 }
 
 static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
@@ -631,7 +658,7 @@ static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
 {
 	hda_nid_t nid = path->path[i];
 	init_amp(codec, nid, HDA_OUTPUT, 0);
-	activate_amp(codec, nid, HDA_OUTPUT, 0, enable);
+	activate_amp(codec, nid, HDA_OUTPUT, 0, 0, enable);
 }
 
 static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
@@ -655,16 +682,13 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	for (n = 0; n < nums; n++)
 		init_amp(codec, nid, HDA_INPUT, n);
 
-	if (is_ctl_associated(codec, nid, HDA_INPUT, idx))
-		return;
-
 	/* here is a little bit tricky in comparison with activate_amp_out();
 	 * when aa-mixer is available, we need to enable the path as well
 	 */
 	for (n = 0; n < nums; n++) {
 		if (n != idx && (!add_aamix || conn[n] != spec->mixer_nid))
 			continue;
-		activate_amp(codec, nid, HDA_INPUT, n, enable);
+		activate_amp(codec, nid, HDA_INPUT, n, idx, enable);
 	}
 }
 
-- 
1.8.1
