From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Removed unused non-standard name
	"C/LFE"
Date: Fri,  9 Nov 2012 07:03:59 +0100
Message-ID: <1352441039-5405-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A5726163A
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 07:04:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A closer look shows that the name is not even used and can be removed.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 9ae8cfc..7ae5f85 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1938,7 +1938,7 @@ static int via_auto_create_multi_out_ctls(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	struct nid_path *path;
 	static const char * const chname[4] = {
-		"Front", "Surround", "C/LFE", "Side"
+		"Front", "Surround", NULL /* "CLFE" */, "Side"
 	};
 	int i, idx, err;
 	int old_line_outs;
-- 
1.7.9.5
