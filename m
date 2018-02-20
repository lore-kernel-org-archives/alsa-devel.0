From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/11] ASoC: rt5651: Allow specifying micbias
	over-current thresholds through pdata
Date: Tue, 20 Feb 2018 23:15:05 +0100
Message-ID: <20180220221511.22861-5-hdegoede@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8068126752D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:25 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

OVer-Current-Detection (OVCD) for the micbias current is used to detect if
an inserted jack is a headset or headphones (mic shorted to ground).

Some boards may need different values for the OVCD threshold because of a
resistor on the board in serial with or parallel to the jack mic contact.

This commit adds support for the sofar unset OVCD scale-factor register
values and adds support for specifying both the current threshold and the
scale-factor to pdata and this commets sets these values only once from
rt5651_set_jack() instead of setting them every time we do jack-detection.

This commit sets the new pdata values for this to 2000uA with a
scale-factor of 0.75 for the KIANO SlimNote 14.2 device, which is the
only rt5652 using device on which jack-detection is currently enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/sound/rt5651.h                | 29 +++++++++++++++++++++++++++-
 sound/soc/codecs/rt5651.c             | 27 +++++++++++++++++---------
 sound/soc/codecs/rt5651.h             | 10 ++++++++++
 sound/soc/intel/boards/bytcr_rt5651.c | 36 +++++++++++++++++++++++++++++------
 4 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 18b79a761f10..7b000406589c 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -18,12 +18,39 @@ enum rt5651_jd_src {
 	RT5651_JD2,
 };
 
+/* These mirror the RT5651_MIC1_OVTH_*UA consts and MUST be in the same order */
+enum rt5651_ovth_curr {
+	RT5651_OVTH_600UA,
+	RT5651_OVTH_1500UA,
+	RT5651_OVTH_2000UA,
+};
+
+/* These mirror the RT5651_MIC_OVCD_SF* consts and MUST be in the same order */
+enum rt5651_ovcd_sf {
+	RT5651_OVCD_SF_0P5,
+	RT5651_OVCD_SF_0P75,
+	RT5651_OVCD_SF_1P0,
+	RT5651_OVCD_SF_1P5,
+};
+
+/*
+ * Note testing on various boards has shown that good defaults for ovth_curr
+ * and ovth_sf are 2000UA and 0.75. For an effective threshold of 1500UA,
+ * this seems to be more reliable then 1500UA and 1.0. Some boards may need
+ * different values because of a resistor on the board in serial with or
+ * parallel to the jack mic contact.
+ */
 struct rt5651_platform_data {
 	/* IN2 can optionally be differential */
 	bool in2_diff;
-
+	/* Configure GPIO2 as DMIC1 SCL */
 	bool dmic_en;
+	/* Jack detect source or JD_NULL to disable jack-detect */
 	enum rt5651_jd_src jd_src;
+	/* Jack micbias overcurrent detect current threshold */
+	enum rt5651_ovth_curr ovth_curr;
+	/* Jack micbias overcurrent detect current scale-factor */
+	enum rt5651_ovcd_sf ovth_sf;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 4b0509f7e001..1e20cdb8b569 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1575,6 +1575,7 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 	regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
 			   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
 
+	/* Select jack detect source */
 	switch (rt5651->pdata.jd_src) {
 	case RT5651_JD1_1:
 		regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
@@ -1607,11 +1608,25 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 		break;
 	}
 
+	/* Enable jack detect power */
 	regmap_update_bits(rt5651->regmap, RT5651_PWR_ANLG2, RT5651_PWR_JD_M,
 			   RT5651_PWR_JD_M);
 
+	/*
+	 * Set OVCD threshold current and scale-factor from pdata.
+	 */
+	regmap_write(rt5651->regmap, RT5651_PR_BASE + RT5651_BIAS_CUR4, 0xa800 |
+		     (rt5651->pdata.ovth_sf << RT5651_MIC_OVCD_SF_SFT));
+
 	regmap_update_bits(rt5651->regmap, RT5651_MICBIAS,
-			   0x38, 0x38);
+			   RT5651_MIC1_OVCD_MASK |
+			   RT5651_MIC1_OVTH_MASK |
+			   RT5651_PWR_CLK12M_MASK |
+			   RT5651_PWR_MB_MASK,
+			   RT5651_MIC1_OVCD_DIS |
+			   (rt5651->pdata.ovth_curr << RT5651_MIC1_OVTH_SFT) |
+			   RT5651_PWR_MB_PU |
+			   RT5651_PWR_CLK12M_PU);
 
 	ret = devm_request_threaded_irq(codec->dev, rt5651->irq, NULL,
 					rt5651_irq,
@@ -1795,14 +1810,8 @@ static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		snd_soc_dapm_mutex_unlock(dapm);
 
 		snd_soc_update_bits(codec, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK |
-				    RT5651_MIC1_OVTH_MASK |
-				    RT5651_PWR_CLK12M_MASK |
-				    RT5651_PWR_MB_MASK,
-				    RT5651_MIC1_OVCD_EN |
-				    RT5651_MIC1_OVTH_600UA |
-				    RT5651_PWR_MB_PU |
-				    RT5651_PWR_CLK12M_PU);
+				    RT5651_MIC1_OVCD_MASK,
+				    RT5651_MIC1_OVCD_EN);
 		msleep(100);
 		if (snd_soc_read(codec, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
 			jack_type = SND_JACK_HEADPHONE;
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 151ac92f6bad..96168a1e87c1 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -138,6 +138,7 @@
 /* Index of Codec Private Register definition */
 #define RT5651_BIAS_CUR1			0x12
 #define RT5651_BIAS_CUR3			0x14
+#define RT5651_BIAS_CUR4			0x15
 #define RT5651_CLSD_INT_REG1			0x1c
 #define RT5651_CHPUMP_INT_REG1			0x24
 #define RT5651_MAMP_INT_REG2			0x37
@@ -1966,6 +1967,15 @@
 #define RT5651_D_GATE_EN_SFT			0
 
 /* Codec Private Register definition */
+
+/* MIC Over current threshold scale factor (0x15) */
+#define RT5651_MIC_OVCD_SF_MASK			(0x3 << 8)
+#define RT5651_MIC_OVCD_SF_SFT			8
+#define RT5651_MIC_OVCD_SF_0P5			(0x0 << 8)
+#define RT5651_MIC_OVCD_SF_0P75			(0x1 << 8)
+#define RT5651_MIC_OVCD_SF_1P0			(0x2 << 8)
+#define RT5651_MIC_OVCD_SF_1P5			(0x3 << 8)
+
 /* 3D Speaker Control (0x63) */
 #define RT5651_3D_SPK_MASK			(0x1 << 15)
 #define RT5651_3D_SPK_SFT			15
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8ef5b5500fb7..a6cc0bc85db8 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -49,11 +49,26 @@ enum {
 	BYT_RT5651_JD2		= (RT5651_JD2 << 4),
 };
 
-#define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(3, 0))
-#define BYT_RT5651_JDSRC(quirk)	(((quirk) & GENMASK(7, 4)) >> 4)
-#define BYT_RT5651_DMIC_EN	BIT(16)
-#define BYT_RT5651_MCLK_EN	BIT(17)
-#define BYT_RT5651_MCLK_25MHZ	BIT(18)
+enum {
+	BYT_RT5651_OVTH_600UA	= (RT5651_OVTH_600UA << 8),
+	BYT_RT5651_OVTH_1500UA	= (RT5651_OVTH_1500UA << 8),
+	BYT_RT5651_OVTH_2000UA	= (RT5651_OVTH_2000UA << 8),
+};
+
+enum {
+	BYT_RT5651_OVCD_SF_0P5	= (RT5651_OVCD_SF_0P5 << 12),
+	BYT_RT5651_OVCD_SF_0P75	= (RT5651_OVCD_SF_0P75 << 12),
+	BYT_RT5651_OVCD_SF_1P0	= (RT5651_OVCD_SF_1P0 << 12),
+	BYT_RT5651_OVCD_SF_1P5	= (RT5651_OVCD_SF_1P5 << 12),
+};
+
+#define BYT_RT5651_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_RT5651_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
+#define BYT_RT5651_OVTH(quirk)		(((quirk) & GENMASK(11, 8)) >> 8)
+#define BYT_RT5651_OVCD_SF(quirk)	(((quirk) & GENMASK(15, 12)) >> 12)
+#define BYT_RT5651_DMIC_EN		BIT(16)
+#define BYT_RT5651_MCLK_EN		BIT(17)
+#define BYT_RT5651_MCLK_25MHZ		BIT(18)
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -73,9 +88,14 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
-	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk jack-detect src %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
+		dev_info(dev, "quirk ovth_curr %ld\n",
+			 BYT_RT5651_OVTH(byt_rt5651_quirk));
+		dev_info(dev, "quirk ovth_sf %ld\n",
+			 BYT_RT5651_OVCD_SF(byt_rt5651_quirk));
+	}
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -299,6 +319,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
 					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVTH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
@@ -373,6 +395,8 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	pdata.jd_src = BYT_RT5651_JDSRC(byt_rt5651_quirk);
+	pdata.ovth_curr = BYT_RT5651_OVTH(byt_rt5651_quirk);
+	pdata.ovth_sf = BYT_RT5651_OVCD_SF(byt_rt5651_quirk);
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		pdata.dmic_en = true;
 	rt5651_set_pdata(codec, &pdata);
-- 
2.14.3
