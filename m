From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Check all inputs for
	is_active_nid_for_any()
Date: Tue, 25 Aug 2015 07:59:41 +0200
Message-ID: <1440482382-1967-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 212EA264F0D
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 07:59:47 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C50B9ACD4
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 05:59:46 +0000 (UTC)
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

The is_active_nid_for_any() function in the generic parser is supposed
to check all connections from/to the given widget, but the current
code checks only the first input connection (index = 0).

This patch corrects the code to check all inputs by passing -1 to
index argument.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=102521
Cc: <stable@vger.kernel.org> [v4.1+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b077bb644434..368181d8b0ce 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -671,7 +671,8 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 		}
 		for (i = 0; i < path->depth; i++) {
 			if (path->path[i] == nid) {
-				if (dir == HDA_OUTPUT || path->idx[i] == idx)
+				if (dir == HDA_OUTPUT || idx == -1 ||
+				    path->idx[i] == idx)
 					return true;
 				break;
 			}
@@ -682,7 +683,7 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 
 /* check whether the NID is referred by any active paths */
 #define is_active_nid_for_any(codec, nid) \
-	is_active_nid(codec, nid, HDA_OUTPUT, 0)
+	is_active_nid(codec, nid, HDA_OUTPUT, -1)
 
 /* get the default amp value for the target state */
 static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
-- 
2.5.0
