From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda: ignore assoc when comparing pin
	configurations
Date: Tue,  6 Dec 2016 14:39:41 +0800
Message-ID: <20161206063941.13876-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7687E266F01
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 07:40:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

Commit [64047d7f4912 ALSA: hda - ignore the assoc and seq when comparing
pin configurations] may still fail to match pins on some machines,
because the bitmask it used only ignore seq but not assoc.
Change the bitmask to also ignore assoc.

Thanks to Hui Wang for the analysis.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 4ad29f8..fdc30d0 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -901,7 +901,7 @@ static bool pin_config_match(struct hda_codec *codec,
 		for (; t_pins->nid; t_pins++) {
 			if (t_pins->nid == nid) {
 				found = 1;
-				if ((t_pins->val & 0xfffffff0) == (cfg & 0xfffffff0))
+				if ((t_pins->val & 0xffffff00) == (cfg & 0xffffff00))
 					break;
 				else if ((cfg & 0xf0000000) == 0x40000000 && (t_pins->val & 0xf0000000) == 0x40000000)
 					break;
-- 
2.10.2
