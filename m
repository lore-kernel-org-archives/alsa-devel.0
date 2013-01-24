From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/13] ALSA: hda - Small code refactoring about
	path re-initialization
Date: Thu, 24 Jan 2013 18:37:52 +0100
Message-ID: <1359049082-5880-4-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AE20D2616EE
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E6D1CA41E0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

Introduce a helper function to do the same thing.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 06e203d..921582d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -735,6 +735,14 @@ static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
 				   enable ? 0x02 : 0x00);
 }
 
+/* re-initialize the path specified by the given path index */
+static void resume_path_from_idx(struct hda_codec *codec, int path_idx)
+{
+	struct nid_path *path = snd_hda_get_path_from_idx(codec, path_idx);
+	if (path)
+		snd_hda_activate_path(codec, path, path->active, false);
+}
+
 
 /*
  * Helper functions for creating mixer ctl elements
@@ -4684,16 +4692,8 @@ static void init_analog_input(struct hda_codec *codec)
 
 		/* init loopback inputs */
 		if (spec->mixer_nid) {
-			struct nid_path *path;
-			path = snd_hda_get_path_from_idx(codec, spec->loopback_paths[i]);
-			if (path)
-				snd_hda_activate_path(codec, path,
-						      path->active, false);
-			path = snd_hda_get_path_from_idx(codec,
-							 spec->loopback_merge_path);
-			if (path)
-				snd_hda_activate_path(codec, path, path->active,
-						      false);
+			resume_path_from_idx(codec, spec->loopback_paths[i]);
+			resume_path_from_idx(codec, spec->loopback_merge_path);
 		}
 	}
 }
@@ -4741,11 +4741,8 @@ static void init_digital(struct hda_codec *codec)
 		set_output_and_unmute(codec, spec->digout_paths[i]);
 	pin = spec->autocfg.dig_in_pin;
 	if (pin) {
-		struct nid_path *path;
 		restore_pin_ctl(codec, pin);
-		path = snd_hda_get_path_from_idx(codec, spec->digin_path);
-		if (path)
-			snd_hda_activate_path(codec, path, path->active, false);
+		resume_path_from_idx(codec, spec->digin_path);
 	}
 }
 
-- 
1.8.1.1
