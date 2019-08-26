From: <shumingf@realtek.com>
Subject: [PATCH 1/2] ASoC: rt1011: add mutex protection to
	set_fmt/set_tdm_slot
Date: Mon, 26 Aug 2019 17:00:52 +0800
Message-ID: <20190826090052.1875-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23F5DF80376
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 11:01:19 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, Shuming Fan <shumingf@realtek.com>, derek.fang@realtek.com, sathya.prakash.m.r@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The calibration process at booting will reset registers and bypass cache
to make sure the calibration is done.
We add mutex protection to avoid unexpected settings while
the registration process and calibration are interleaved.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index fa34565a3938..f9235764ad32 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1627,14 +1627,18 @@ static int rt1011_hw_params(struct snd_pcm_substream *substream,
 static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
 	unsigned int reg_val = 0, reg_bclk_inv = 0;
+	int ret = 0;
 
+	snd_soc_dapm_mutex_lock(dapm);
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		reg_val |= RT1011_I2S_TDM_MS_S;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -1644,7 +1648,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		reg_bclk_inv |= RT1011_TDM_INV_BCLK;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -1660,7 +1664,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		reg_val |= RT1011_I2S_TDM_DF_PCM_B;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	switch (dai->id) {
@@ -1675,9 +1679,11 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	default:
 		dev_err(component->dev, "Invalid dai->id: %d\n", dai->id);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+
+	snd_soc_dapm_mutex_unlock(dapm);
+	return ret;
 }
 
 static int rt1011_set_component_sysclk(struct snd_soc_component *component,
@@ -1796,8 +1802,12 @@ static int rt1011_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
 	unsigned int val = 0, tdm_en = 0;
+	int ret = 0;
 
+	snd_soc_dapm_mutex_lock(dapm);
 	if (rx_mask || tx_mask)
 		tdm_en = RT1011_TDM_I2S_DOCK_EN_1;
 
@@ -1817,7 +1827,7 @@ static int rt1011_set_tdm_slot(struct snd_soc_dai *dai,
 	case 2:
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	switch (slot_width) {
@@ -1836,7 +1846,7 @@ static int rt1011_set_tdm_slot(struct snd_soc_dai *dai,
 	case 16:
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	snd_soc_component_update_bits(component, RT1011_TDM1_SET_1,
@@ -1853,7 +1863,8 @@ static int rt1011_set_tdm_slot(struct snd_soc_dai *dai,
 		RT1011_ADCDAT1_PIN_CONFIG | RT1011_ADCDAT2_PIN_CONFIG,
 		RT1011_ADCDAT1_OUTPUT | RT1011_ADCDAT2_OUTPUT);
 
-	return 0;
+	snd_soc_dapm_mutex_unlock(dapm);
+	return ret;
 }
 
 static int rt1011_probe(struct snd_soc_component *component)
-- 
2.23.0
