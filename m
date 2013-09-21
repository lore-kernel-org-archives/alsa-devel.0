From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: bells: Specify REFCLK for FLLs
Date: Sat, 21 Sep 2013 11:10:18 +0100
Message-ID: <1379758218-28580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C5FD261A64
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2013 12:21:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ben-linux@fluff.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Wolfson recommends using a higher frequency REFCLK for best performance
rather than the default 32kHz reference clock source. We should set a
good example and do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/bells.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 84f5d8b..89ad1d7 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -181,6 +181,24 @@ static int bells_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
+	ret = snd_soc_codec_set_pll(codec, WM5102_FLL1_REFCLK,
+				    ARIZONA_FLL_SRC_MCLK1,
+				    MCLK_RATE,
+				    bells->sysclk_rate);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set REFCLK for FLL1: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_codec_set_pll(codec, WM5102_FLL2_REFCLK,
+				    ARIZONA_FLL_SRC_MCLK1,
+				    MCLK_RATE,
+				    bells->asyncclk_rate);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set REFCLK for FLL2: %d\n", ret);
+		return ret;
+	}
+
 	aif2_dai = card->rtd[DAI_CODEC_CP].cpu_dai;
 
 	ret = snd_soc_dai_set_sysclk(aif2_dai, ARIZONA_CLK_ASYNCCLK, 0, 0);
-- 
1.7.2.5
