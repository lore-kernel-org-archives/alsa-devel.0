From: Florin Tudorache <florin_tudorache@live.com>
Subject: [PATCH v2] ALSA: hda - Add mute led support for HP
	EliteBook 840 G3
Date: Fri, 5 May 2017 19:40:06 +0000
Message-ID: <DB6PR0801MB2037E991967B48A6F25D7FE89BEB0@DB6PR0801MB2037.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-oln040092070027.outbound.protection.outlook.com [40.92.70.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E398266B17
 for <alsa-devel@alsa-project.org>; Fri,  5 May 2017 21:40:07 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Florin Tudorache <florin_tudorache@live.com>
---
 sound/pci/hda/patch_conexant.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e825373..63bc894 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -860,7 +860,9 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ 0x16, 0x21011020 }, /* line-out */
 			{ 0x18, 0x2181103f }, /* line-in */
 			{ }
-		}
+		},
+		.chained = true,
+		.chain_id = CXT_FIXUP_MUTE_LED_GPIO,
 	},
 	[CXT_FIXUP_HP_SPECTRE] = {
 		.type = HDA_FIXUP_PINS,
-- 
2.7.4
