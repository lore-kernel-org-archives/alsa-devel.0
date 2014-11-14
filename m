From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Modify the default value and add
	it to patch table
Date: Fri, 14 Nov 2014 16:47:33 +0800
Message-ID: <1415954853-2768-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C60D1266573
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 09:47:41 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Modify the default value and add it to patch table

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 5d317c68..9ae2e84 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -55,7 +55,8 @@ static const struct regmap_range_cfg rt5677_ranges[] = {
 };
 
 static const struct reg_default init_list[] = {
-	{RT5677_PR_BASE + 0x3d,	0x364d},
+	{RT5677_ASRC_12, 0x0018},
+	{RT5677_PR_BASE + 0x3d, 0x364d},
 	{RT5677_PR_BASE + 0x17, 0x4fc0},
 	{RT5677_PR_BASE + 0x13, 0x0312},
 	{RT5677_PR_BASE + 0x1e, 0x0000},
@@ -173,7 +174,7 @@ static const struct reg_default rt5677_reg[] = {
 	{RT5677_ASRC_9			, 0x0000},
 	{RT5677_ASRC_10			, 0x0000},
 	{RT5677_ASRC_11			, 0x0000},
-	{RT5677_ASRC_12			, 0x0008},
+	{RT5677_ASRC_12			, 0x0018},
 	{RT5677_ASRC_13			, 0x0000},
 	{RT5677_ASRC_14			, 0x0000},
 	{RT5677_ASRC_15			, 0x0000},
-- 
1.9.1
