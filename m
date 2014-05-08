From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: Fix a serious typo
Date: Thu, 8 May 2014 15:42:36 +0800
Message-ID: <1399534957-23937-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C27265483
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 09:43:29 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch corrects a serious typo in struct reg_default.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 6db6f81..30410eb 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -50,10 +50,10 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 
 static const struct reg_default init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
-	{RT5645_PR_BASE + 0x1c, 0xfd20);
-	{RT5645_PR_BASE + 0x20, 0x611f);
-	{RT5645_PR_BASE + 0x21, 0x4040);
-	{RT5645_PR_BASE + 0x23, 0x0004);
+	{RT5645_PR_BASE + 0x1c,	0xfd20},
+	{RT5645_PR_BASE + 0x20,	0x611f},
+	{RT5645_PR_BASE + 0x21,	0x4040},
+	{RT5645_PR_BASE + 0x23,	0x0004},
 };
 #define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
-- 
1.8.1.1.439.g50a6b54
