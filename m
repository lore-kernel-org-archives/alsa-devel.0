From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Check the activity of the NID to
	be powered down
Date: Wed, 15 May 2013 07:18:40 +0200
Message-ID: <1368595120-30059-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85CFA26109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 07:18:45 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 343D2A41E0
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 07:18:45 +0200 (CEST)
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

When an inactive path is powered down with spec->power_down_unused
flag, we should check the activity of each widget in the path whether
it's still referred from any active path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ac079f9..ae85bbd2 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -606,6 +606,10 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 	return false;
 }
 
+/* check whether the NID is referred by any active paths */
+#define is_active_nid_for_any(codec, nid) \
+	is_active_nid(codec, nid, HDA_OUTPUT, 0)
+
 /* get the default amp value for the target state */
 static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
 				   int dir, unsigned int caps, bool enable)
@@ -759,7 +763,8 @@ static void path_power_down_sync(struct hda_codec *codec, struct nid_path *path)
 
 	for (i = 0; i < path->depth; i++) {
 		hda_nid_t nid = path->path[i];
-		if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D3)) {
+		if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D3) &&
+		    !is_active_nid_for_any(codec, nid)) {
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_POWER_STATE,
 					    AC_PWRST_D3);
@@ -4157,7 +4162,7 @@ static unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 		return power_state;
 	if (get_wcaps_type(get_wcaps(codec, nid)) >= AC_WID_POWER)
 		return power_state;
-	if (is_active_nid(codec, nid, HDA_OUTPUT, 0))
+	if (is_active_nid_for_any(codec, nid))
 		return power_state;
 	return AC_PWRST_D3;
 }
-- 
1.8.2.1
