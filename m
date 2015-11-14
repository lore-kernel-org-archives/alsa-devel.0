From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix detection of Loud devices
Date: Sat, 14 Nov 2015 16:42:04 +0900
Message-ID: <1447486924-24887-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EEB326048C
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 08:42:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, contact@etilem.net, erouge.externe@m6.fr, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Commit a471fcde8c2c ("ALSA: dice: fix detection of Weiss devices") adds
a quirk of Weiss models. According to users' reports, Loud models also
have the similar quirk. They have 0x10 in the category field.

This commit adds support for Mackie Onyx Blackbird and Onyx-i series.
As long as I know, Dice-based models produced by
Focusrite/Alesis/PreSonus/M-Audio/TC Electronic have default value (0x04)
in their category field, thus it may be reasonable to add a condition
statement for Loud models, instead of removing the check of category value.

Reported-by: Rouge Etienne <erouge.externe@m6.fr>
Reported-by: Etilem <contact@etilem.net>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 5d99436..0cda05c 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -12,9 +12,11 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
 #define OUI_WEISS		0x001c6a
+#define OUI_LOUD		0x000ff2
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
+#define LOUD_CATEGORY_ID	0x10
 
 static int dice_interface_check(struct fw_unit *unit)
 {
@@ -57,6 +59,8 @@ static int dice_interface_check(struct fw_unit *unit)
 	}
 	if (vendor == OUI_WEISS)
 		category = WEISS_CATEGORY_ID;
+	else if (vendor == OUI_LOUD)
+		category = LOUD_CATEGORY_ID;
 	else
 		category = DICE_CATEGORY_ID;
 	if (device->config_rom[3] != ((vendor << 8) | category) ||
-- 
2.5.0
