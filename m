From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 6/7] ASoC: arizona: Add support for setting the
	output volume limits
Date: Mon, 4 Sep 2017 16:41:53 +0100
Message-ID: <20170904154154.4395-7-ckeepax@opensource.cirrus.com>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 41B37266F9D
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 17:41:57 +0200 (CEST)
In-Reply-To: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The output volume limits allow signals to be limited to specific levels
appropriate for the hardware attached. As this is a property of the
hardware itself these will be configured through device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/mfd/arizona/pdata.h |  3 +++
 sound/soc/codecs/arizona.c        | 25 +++++++++++++++++++++++++
 sound/soc/codecs/arizona.h        |  1 +
 sound/soc/codecs/cs47l24.c        |  3 +++
 sound/soc/codecs/wm5102.c         |  3 +++
 sound/soc/codecs/wm5110.c         |  3 +++
 sound/soc/codecs/wm8997.c         |  3 +++
 7 files changed, 41 insertions(+)

diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index bfeecf179895..f72dc53848d7 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -174,6 +174,9 @@ struct arizona_pdata {
 	/** Mode for outputs */
 	int out_mono[ARIZONA_MAX_OUTPUT];
 
+	/** Limit output volumes */
+	unsigned int out_vol_limit[2 * ARIZONA_MAX_OUTPUT];
+
 	/** PDM speaker mute setting */
 	unsigned int spk_mute[ARIZONA_MAX_PDM_SPK];
 
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e6967385dccb..b3375e19598a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -372,6 +372,22 @@ int arizona_init_common(struct arizona *arizona)
 }
 EXPORT_SYMBOL_GPL(arizona_init_common);
 
+int arizona_init_vol_limit(struct arizona *arizona)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(arizona->pdata.out_vol_limit); ++i) {
+		if (arizona->pdata.out_vol_limit[i])
+			regmap_update_bits(arizona->regmap,
+					   ARIZONA_DAC_VOLUME_LIMIT_1L + i * 4,
+					   ARIZONA_OUT1L_VOL_LIM_MASK,
+					   arizona->pdata.out_vol_limit[i]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_vol_limit);
+
 const char * const arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"None",
 	"Tone Generator 1",
@@ -2810,6 +2826,15 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 		count++;
 	}
 
+	count = 0;
+	of_property_for_each_u32(np, "wlf,out-volume-limit", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->out_vol_limit))
+			break;
+
+		pdata->out_vol_limit[count] = val;
+		count++;
+	}
+
 	ret = of_property_read_u32_array(np, "wlf,spk-fmt",
 					 pdm_val, ARRAY_SIZE(pdm_val));
 
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 2d198fb2ce97..dfdf6d8c9687 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -315,6 +315,7 @@ int arizona_init_gpio(struct snd_soc_codec *codec);
 int arizona_init_mono(struct snd_soc_codec *codec);
 
 int arizona_init_common(struct arizona *arizona);
+int arizona_init_vol_limit(struct arizona *arizona);
 
 int arizona_init_spk_irqs(struct arizona *arizona);
 int arizona_free_spk_irqs(struct arizona *arizona);
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 0fe7d7a87ff3..94c0209977d0 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1297,6 +1297,9 @@ static int cs47l24_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 5a917dd73f32..4f0481d3c7a7 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2107,6 +2107,9 @@ static int wm5102_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ba1e90ca8be4..6ed1e1f9ce51 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2463,6 +2463,9 @@ static int wm5110_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index c5aef9ecdecc..77f512767273 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1176,6 +1176,9 @@ static int wm8997_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		return ret;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		return ret;
-- 
2.11.0
