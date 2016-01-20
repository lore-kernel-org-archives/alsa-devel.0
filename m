From: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Subject: [PATCH v3] ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode
Date: Wed, 20 Jan 2016 12:45:39 +0000
Message-ID: <1453293939-32220-2-git-send-email-stuarth@opensource.wolfsonmicro.com>
References: <1453293939-32220-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 578FF265AB9
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 13:46:21 +0100 (CET)
In-Reply-To: <1453293939-32220-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
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
Cc: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

With the introduction of WM8960_SYSCLK_AUTO mode, WM8960_SYSCLK_PLL mode was
made unusable.  Ensure we're not PLL mode before trying to use MCLK.

Fixes: 3176bf2d7ccd ("ASoC: wm8960: update pll and clock setting function")
Signed-off-by: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 7f20fb2..d7f444f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -643,29 +643,31 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	/* check if the sysclk frequency is available. */
-	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-		if (sysclk_divs[i] == -1)
-			continue;
-		sysclk = freq_out / sysclk_divs[i];
-		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-			if (sysclk == dac_divs[j] * lrclk) {
+	if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
+		/* check if the sysclk frequency is available. */
+		for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+			if (sysclk_divs[i] == -1)
+				continue;
+			sysclk = freq_out / sysclk_divs[i];
+			for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
+				if (sysclk != dac_divs[j] * lrclk)
+					continue;
 				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
 					if (sysclk == bclk * bclk_divs[k] / 10)
 						break;
 				if (k != ARRAY_SIZE(bclk_divs))
 					break;
 			}
+			if (j != ARRAY_SIZE(dac_divs))
+				break;
 		}
-		if (j != ARRAY_SIZE(dac_divs))
-			break;
-	}
 
-	if (i != ARRAY_SIZE(sysclk_divs)) {
-		goto configure_clock;
-	} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
-		dev_err(codec->dev, "failed to configure clock\n");
-		return -EINVAL;
+		if (i != ARRAY_SIZE(sysclk_divs)) {
+			goto configure_clock;
+		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
+			dev_err(codec->dev, "failed to configure clock\n");
+			return -EINVAL;
+		}
 	}
 	/* get a available pll out frequency and set pll */
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-- 
2.1.4
