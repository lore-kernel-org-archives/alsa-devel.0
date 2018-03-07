From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add quirk micbias
	OVCD configuration" to the asoc tree
Date: Wed, 07 Mar 2018 14:22:26 +0000
Message-ID: <E1etZxa-0002oI-Ru@debutante>
References: <20180304143610.21125-15-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D12267439
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:32 +0100 (CET)
In-Reply-To: <20180304143610.21125-15-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Add quirk micbias OVCD configuration

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8ffaa6a136e6f30e053e78fb9742c7748bef8576 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:02 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add quirk micbias OVCD
 configuration

Add support for setting the micbias OVCD limits device-properties through
quirks.

And set the limits for this to 2000uA with a scale-factor of 0.75 for the
KIANO SlimNote 14.2 device, which is the only device on which
jack-detection is currently enabled.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 56f1f076d92c..91b5841af622 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -51,14 +51,29 @@ enum {
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
@@ -78,9 +93,14 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
-	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
+		dev_info(dev, "quirk realtek,over-current-threshold-microamp %ld\n",
+			 BYT_RT5651_OVCD_TH(byt_rt5651_quirk) * 100);
+		dev_info(dev, "quirk realtek,over-current-scale-factor %ld\n",
+			 BYT_RT5651_OVCD_SF(byt_rt5651_quirk));
+	}
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -304,6 +324,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
 					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
@@ -326,6 +348,12 @@ static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
 	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 				BYT_RT5651_JDSRC(byt_rt5651_quirk));
 
+	props[cnt++] = PROPERTY_ENTRY_U32("realtek,over-current-threshold-microamp",
+				BYT_RT5651_OVCD_TH(byt_rt5651_quirk) * 100);
+
+	props[cnt++] = PROPERTY_ENTRY_U32("realtek,over-current-scale-factor",
+				BYT_RT5651_OVCD_SF(byt_rt5651_quirk));
+
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
 
-- 
2.16.2
