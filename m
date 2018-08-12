From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for 2
	more devices
Date: Sun, 12 Aug 2018 13:42:06 +0200
Message-ID: <20180812114206.10826-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 12AF62673A0
 for <alsa-devel@alsa-project.org>; Sun, 12 Aug 2018 13:42:23 +0200 (CEST)
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
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add quirks to select the right input-map, jack-detect pin, etc. for:

Linx Linx7 tablet
Onda V975w tablet

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index d32844f94d74..b6dc524830b2 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -575,6 +575,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MONO_SPEAKER |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Linx Linx7 tablet */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LINX"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LINX7"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* MSI S100 tablet */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
@@ -602,6 +613,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Onda v975w */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* The above are too generic, also match BIOS info */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "5.6.5"),
+			DMI_EXACT_MATCH(DMI_BIOS_DATE, "07/25/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Pipo W4 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-- 
2.18.0
