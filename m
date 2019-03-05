From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ASoC: Intel: bytcr_rt5651: Add
	BYT_RT5651_JD_NOT_INV quirk
Date: Tue,  5 Mar 2019 12:39:00 +0100
Message-ID: <20190305113900.8893-2-hdegoede@redhat.com>
References: <20190305113900.8893-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEBEAF896EB
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 12:39:10 +0100 (CET)
In-Reply-To: <20190305113900.8893-1-hdegoede@redhat.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add BYT_RT5651_JD_NOT_INV quirk for devices with an inverted
(active-high instead of the normal active-low) jack-detect switch.

And add a quirk for the Complet Electro Serv MY8307 tablet which has
an inverted jack-detect switch (and a mono-speaker).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 99d0c01a1bec..1bf97a784c4e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -79,14 +79,15 @@ enum {
 #define BYT_RT5651_SSP0_AIF2		BIT(21)
 #define BYT_RT5651_HP_LR_SWAPPED	BIT(22)
 #define BYT_RT5651_MONO_SPEAKER		BIT(23)
+#define BYT_RT5651_JD_NOT_INV		BIT(24)
 
 #define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
 					 BYT_RT5651_JD1_1   | \
 					 BYT_RT5651_OVCD_TH_2000UA | \
 					 BYT_RT5651_OVCD_SF_0P75)
 
-/* jack-detect-source + dmic-en + ovcd-th + -sf + terminating empty entry */
-#define MAX_NO_PROPS 5
+/* jack-detect-source + inv + dmic-en + ovcd-th + -sf + terminating entry */
+#define MAX_NO_PROPS 6
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -137,6 +138,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0_AIF2 enabled\n");
 	if (byt_rt5651_quirk & BYT_RT5651_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
+	if (byt_rt5651_quirk & BYT_RT5651_JD_NOT_INV)
+		dev_info(dev, "quirk JD_NOT_INV enabled\n");
 }
 
 #define BYT_CODEC_DAI1	"rt5651-aif1"
@@ -414,6 +417,18 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_HP_LR_SWAPPED |
 					BYT_RT5651_MONO_SPEAKER),
 	},
+	{
+		/* Complet Electro Serv MY8307 */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
+		},
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN2_MAP |
+					BYT_RT5651_MONO_SPEAKER |
+					BYT_RT5651_JD_NOT_INV),
+	},
 	{
 		/* I.T.Works TW701, Ployer Momo7w and Trekstor ST70416-6
 		 * (these all use the same mainboard) */
@@ -525,6 +540,9 @@ static int byt_rt5651_add_codec_device_props(struct device *i2c_dev)
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
 
+	if (byt_rt5651_quirk & BYT_RT5651_JD_NOT_INV)
+		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
+
 	return device_add_properties(i2c_dev, props);
 }
 
-- 
2.20.1
