From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/9] ASoC: Intel: bytcr_rt5651: Add
	BYT_RT5651_DEFAULT_QUIRKS define
Date: Sun, 24 Jun 2018 16:06:26 +0200
Message-ID: <20180624140634.16835-2-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BA216267611
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:41 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Almost all boards use the mclk and use the same jack-detect settings, add
a BYT_RT5651_DEFAULT_QUIRKS define for this.

This shaves of some lines and makes it easier to see which settings are
unique to a certain model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 925dfb46b4fe..c45ad99d7ac6 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -79,6 +79,11 @@ enum {
 #define BYT_RT5651_SSP0_AIF1		BIT(20)
 #define BYT_RT5651_SSP0_AIF2		BIT(21)
 
+#define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
+					 BYT_RT5651_JD1_1   | \
+					 BYT_RT5651_OVCD_TH_2000UA | \
+					 BYT_RT5651_OVCD_SF_0P75)
+
 /* jack-detect-source + dmic-en + ovcd-th + -sf + terminating empty entry */
 #define MAX_NO_PROPS 5
 
@@ -88,10 +93,7 @@ struct byt_rt5651_private {
 };
 
 /* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
-static unsigned long byt_rt5651_quirk = BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_HS_IN3_MAP;
 
 static void log_quirks(struct device *dev)
@@ -381,10 +383,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{
@@ -394,10 +393,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_HS_IN3_MAP),
 	},
 	{
@@ -407,10 +403,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_1P0 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
-- 
2.17.1
