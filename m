From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 9/9] ASoC: Intel: bytcr_rt5651: Sort DMI table
	entries alphabetically
Date: Sun, 24 Jun 2018 16:06:34 +0200
Message-ID: <20180624140634.16835-10-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BAD4267716
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:52 +0200 (CEST)
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

As we get more entries in the DMI quirk table it is nice to have some
sort of ordering in the table, sort it alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index bc93020c7a05..f63e3698cb80 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -337,23 +337,29 @@ static int byt_rt5651_quirk_cb(const struct dmi_system_id *id)
 
 static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 	{
+		/* Chuwi Hi8 Pro (CWI513) */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN1_MAP),
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
+		/* Chuwi Vi8 Plus (CWI519) */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_IN1_MAP),
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
+		/* KIANO SlimNote 14.2 */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
@@ -363,26 +369,23 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{
-		/* Chuwi Hi8 Pro (CWI513) */
+		/* Minnowboard Max B3 */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+		.driver_data = (void *)(BYT_RT5651_IN1_MAP),
 	},
 	{
-		/* Chuwi Vi8 Plus (CWI519) */
+		/* Minnowboard Turbot */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_IN1_MAP),
 	},
 	{
 		/* VIOS LTH17 */
-- 
2.17.1
