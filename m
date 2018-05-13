From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 07/10] ASoC: Intel: bytcr_rt5640: Sort DMI
	quirk list alphabetically
Date: Sun, 13 May 2018 09:24:32 +0200
Message-ID: <20180513072435.3358-8-hdegoede@redhat.com>
References: <20180513072435.3358-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 38B8C2676D1
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:25:07 +0200 (CEST)
In-Reply-To: <20180513072435.3358-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

As we add more quirks it is useful to have some sort of order in the
quirk list, sort it alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b00f21ed4357..965721663749 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -401,7 +401,19 @@ static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+/* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+						 BYT_RT5640_MCLK_EN |
+						 BYT_RT5640_SSP0_AIF1),
+
+	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -426,6 +438,14 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
+	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -448,14 +468,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_MCLK_EN),
 	},
-	{
-		.callback = byt_rt5640_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
-		},
-		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
-	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -466,18 +478,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN |
 					BYT_RT5640_SSP0_AIF1),
 	},
-	{
-		.callback = byt_rt5640_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
-		},
-		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MCLK_EN |
-						 BYT_RT5640_SSP0_AIF1),
-
-	},
-	{
+	{	/* Catch-all for generic Insyde tablets, must be last */
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-- 
2.17.0
