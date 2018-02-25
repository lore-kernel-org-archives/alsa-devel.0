From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 24/32] ASoC: Intel: bytcr_rt5651: Add quirk
	micbias OVCD configuration
Date: Sun, 25 Feb 2018 11:47:05 +0100
Message-ID: <20180225104713.4745-25-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BDA39267441
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:51 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Add support for setting the micbias OVCD limits device-properties through
quirks.

And set the limits for this to 2000uA with a scale-factor of 0.75 for the
KIANO SlimNote 14.2 device, which is the only device on which
jack-detection is currently enabled.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4a9026a55ce9..e44851448118 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -50,14 +50,29 @@ enum {
 	BYT_RT5651_JD2		= (RT5651_JD2 << 4),
 };
 
+enum {
+	BYT_RT5651_OVCD_TH_600UA  = (6 << 8),
+	BYT_RT5651_OVCD_TH_1500UA = (15 << 8),
+	BYT_RT5651_OVCD_TH_2000UA = (20 << 8),
+};
+
+enum {
+	BYT_RT5651_OVCD_SF_0P5	= (RT5651_OVCD_SF_0P5 << 13),
+	BYT_RT5651_OVCD_SF_0P75	= (RT5651_OVCD_SF_0P75 << 13),
+	BYT_RT5651_OVCD_SF_1P0	= (RT5651_OVCD_SF_1P0 << 13),
+	BYT_RT5651_OVCD_SF_1P5	= (RT5651_OVCD_SF_1P5 << 13),
+};
+
 #define BYT_RT5651_MAP(quirk)		((quirk) & GENMASK(3, 0))
 #define BYT_RT5651_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
+#define BYT_RT5651_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
+#define BYT_RT5651_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
 #define BYT_RT5651_DMIC_EN		BIT(16)
 #define BYT_RT5651_MCLK_EN		BIT(17)
 #define BYT_RT5651_MCLK_25MHZ		BIT(18)
 
-/* jack-detect-source + dmic-en + terminating empty entry */
-#define MAX_NO_PROPS 3
+/* jack-detect-source + dmic-en + ovcd-th + -sf + terminating empty entry */
+#define MAX_NO_PROPS 5
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -77,9 +92,14 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
-	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
+		dev_info(dev, "quirk realtek,over-current-threshold %ld\n",
+			 BYT_RT5651_OVCD_TH(byt_rt5651_quirk) * 100);
+		dev_info(dev, "quirk realtek,over-current-scale-factor %ld\n",
+			 BYT_RT5651_OVCD_SF(byt_rt5651_quirk));
+	}
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -303,6 +323,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
 					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
@@ -379,6 +401,12 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 				BYT_RT5651_JDSRC(byt_rt5651_quirk));
 
+	props[cnt++] = PROPERTY_ENTRY_U32("realtek,over-current-threshold",
+				BYT_RT5651_OVCD_TH(byt_rt5651_quirk) * 100);
+
+	props[cnt++] = PROPERTY_ENTRY_U32("realtek,over-current-scale-factor",
+				BYT_RT5651_OVCD_SF(byt_rt5651_quirk));
+
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
 
-- 
2.14.3
