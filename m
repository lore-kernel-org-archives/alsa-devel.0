From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 008/112] ALSA: hda/realtek - Make path->idx[]
	and path->multi[] consistent
Date: Tue,  8 Jan 2013 12:38:01 +0100
Message-ID: <1357645185-7645-9-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F332D265136
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1F5DBA51F5
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

So far, idx[i] and multi[i] indicate the attribute of the widget
path[i - 1].  This was just for simplifying the code in
__parse_output_path(), but this is rather confusing for later use.
It's more natural if both idx[i] and multi[i] point to the same widget
of path[i].  This patch changes to that way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a7899d1..5b8308d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -102,8 +102,8 @@ enum {
 #define MAX_NID_PATH_DEPTH	5
 
 /* output-path: DAC -> ... -> pin
- * idx[] contains the source index number of the next widget;
- * e.g. idx[0] is the index of the DAC selected by path[1] widget
+ * idx[i] contains the source index number to select on of the widget path[i];
+ * e.g. idx[1] is the index of the DAC (path[0]) selected by path[1] widget
  * multi[] indicates whether it's a selector widget with multi-connectors
  * (i.e. the connection selection is mandatory)
  * vol_ctl and mute_ctl contains the NIDs for the assigned mixers
@@ -2937,9 +2937,9 @@ static bool __parse_output_path(struct hda_codec *codec, hda_nid_t nid,
 
  found:
 	path->path[path->depth] = conn[i];
-	path->idx[path->depth] = i;
+	path->idx[path->depth + 1] = i;
 	if (nums > 1 && get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_MIX)
-		path->multi[path->depth] = 1;
+		path->multi[path->depth + 1] = 1;
 	path->depth++;
 	return true;
 }
@@ -3846,10 +3846,10 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 
 	for (i = path->depth - 1; i >= 0; i--) {
 		hda_nid_t nid = path->path[i];
-		if (i > 0 && path->multi[i - 1])
+		if (path->multi[i])
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
-					    path->idx[i - 1]);
+					    path->idx[i]);
 
 		if (i != 0 && i != path->depth - 1 &&
 		    (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) &&
-- 
1.8.0.1
