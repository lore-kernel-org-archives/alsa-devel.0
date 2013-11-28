From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: adsp: Use async writes where possible
Date: Thu, 28 Nov 2013 18:12:15 +0000
Message-ID: <1385662335-12172-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EA36265263
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 19:12:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This will allow a marginal speed improvement when used with a bus that
supports async I/O by reducing the amount of context thrashing between
writes, allowing the bus to be more fully utilised.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm_adsp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 46ec0e9744d4..6b1c01c66e64 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1468,8 +1468,8 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	unsigned int val;
 	int ret, count;
 
-	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
 	if (ret != 0)
 		return ret;
 
@@ -1521,9 +1521,9 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		val = (val & ARIZONA_SYSCLK_FREQ_MASK)
 			>> ARIZONA_SYSCLK_FREQ_SHIFT;
 
-		ret = regmap_update_bits(dsp->regmap,
-					 dsp->base + ADSP2_CLOCKING,
-					 ADSP2_CLK_SEL_MASK, val);
+		ret = regmap_update_bits_async(dsp->regmap,
+					       dsp->base + ADSP2_CLOCKING,
+					       ADSP2_CLK_SEL_MASK, val);
 		if (ret != 0) {
 			adsp_err(dsp, "Failed to set clock rate: %d\n",
 				 ret);
@@ -1586,10 +1586,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = regmap_update_bits(dsp->regmap,
-					 dsp->base + ADSP2_CONTROL,
-					 ADSP2_CORE_ENA | ADSP2_START,
-					 ADSP2_CORE_ENA | ADSP2_START);
+		ret = regmap_update_bits_async(dsp->regmap,
+					       dsp->base + ADSP2_CONTROL,
+					       ADSP2_CORE_ENA | ADSP2_START,
+					       ADSP2_CORE_ENA | ADSP2_START);
 		if (ret != 0)
 			goto err;
 
-- 
1.8.4.4
