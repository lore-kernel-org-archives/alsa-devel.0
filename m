From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: correct 5640's device ID
Date: Wed, 30 Apr 2014 14:08:45 +0800
Message-ID: <1398838125-13546-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E62A42651B5
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 08:09:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch correct rt5640's device ID

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
We will send another patch to fix the issue about the "Failed to add route"
error.
---
 sound/soc/codecs/rt5640.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index ded2059..895ca14 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -195,7 +195,7 @@
 /* SW Reset & Device ID (0x00) */
 #define RT5640_ID_MASK				(0x3 << 1)
 #define RT5640_ID_5639				(0x0 << 1)
-#define RT5640_ID_5640				(0x1 << 1)
+#define RT5640_ID_5640				(0x2 << 1)
 #define RT5640_ID_5642				(0x3 << 1)
 
 
-- 
1.8.1.1.439.g50a6b54
