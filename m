From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/17] ASoC: Intel: bytcr-rt5640: add Asus
	T100TAF quirks
Date: Fri, 12 Aug 2016 16:27:44 -0500
Message-ID: <1471037280-17433-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A3998265E24
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:45 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Add quirk based on DMI string matching
Also fix matching to use DMI_EXACT_MATCH otherwise T100TA and T100TAF
will be using same quirk

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 88efb62..2d3441d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -127,16 +127,24 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
 		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "DellInc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
+		},
+		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
+	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
 		.driver_data = (unsigned long *)(BYT_RT5640_DMIC2_MAP |
 						 BYT_RT5640_DMIC_EN),
@@ -144,8 +152,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
 		},
 		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
 	},
-- 
2.5.0
