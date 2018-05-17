From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: improve PLL function's stability
Date: Thu, 17 May 2018 13:54:08 +0800
Message-ID: <1526536448-1603-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B0645266F4E
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 07:54:24 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Set PR-38 register to 0x1fe1 will make PLL function more stable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index dc7df33..732ef92 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -71,7 +71,7 @@ static const struct regmap_range_cfg rt5670_ranges[] = {
 
 static const struct reg_sequence init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
-	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
+	{ RT5670_PR_BASE + 0x38, 0x1fe1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
 	{ 0x8a, 0x0123 },
 };
-- 
2.7.4
