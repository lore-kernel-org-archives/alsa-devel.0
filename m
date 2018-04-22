From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix OUI for TC group
Date: Sun, 22 Apr 2018 21:19:24 +0900
Message-ID: <20180422121924.16122-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C5B79267265
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 14:19:31 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

OUI for TC Electronic is 0x000166, for TC GROUP A/S. 0x001486 is for Echo
Digital Audio Corporation.

Fixes: 7cafc65b3aa1 ('ALSA: dice: force to add two pcm devices for listed models')
Cc: <stable@vger.kernel.org> # v4.6+
Reference: http://standards-oui.ieee.org/oui/oui.txt
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 4ddb4cdd054b..96bb01b6b751 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_WEISS		0x001c6a
 #define OUI_LOUD		0x000ff2
 #define OUI_FOCUSRITE		0x00130e
-#define OUI_TCELECTRONIC	0x001486
+#define OUI_TCELECTRONIC	0x000166
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
-- 
2.14.1
