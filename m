From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5677: Align the reg_default table
	with tab character
Date: Wed, 19 Nov 2014 13:52:18 +0800
Message-ID: <1416376340-4789-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B392265382
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 06:53:05 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Align the reg_default table with tab character

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9ae2e84..b2d88bb 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -55,13 +55,13 @@ static const struct regmap_range_cfg rt5677_ranges[] = {
 };
 
 static const struct reg_default init_list[] = {
-	{RT5677_ASRC_12, 0x0018},
-	{RT5677_PR_BASE + 0x3d, 0x364d},
-	{RT5677_PR_BASE + 0x17, 0x4fc0},
-	{RT5677_PR_BASE + 0x13, 0x0312},
-	{RT5677_PR_BASE + 0x1e, 0x0000},
-	{RT5677_PR_BASE + 0x12, 0x0eaa},
-	{RT5677_PR_BASE + 0x14, 0x018a},
+	{RT5677_ASRC_12,	0x0018},
+	{RT5677_PR_BASE + 0x3d,	0x364d},
+	{RT5677_PR_BASE + 0x17,	0x4fc0},
+	{RT5677_PR_BASE + 0x13,	0x0312},
+	{RT5677_PR_BASE + 0x1e,	0x0000},
+	{RT5677_PR_BASE + 0x12,	0x0eaa},
+	{RT5677_PR_BASE + 0x14,	0x018a},
 };
 #define RT5677_INIT_REG_LEN ARRAY_SIZE(init_list)
 
-- 
1.8.1.1.439.g50a6b54
