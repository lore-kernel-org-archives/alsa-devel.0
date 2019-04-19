From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/3] ASoC: Intel: bytcr_rt5640: align quirk
	override handling
Date: Fri, 19 Apr 2019 15:12:17 -0500
Message-ID: <20190419201218.19821-3-pierre-louis.bossart@linux.intel.com>
References: <20190419201218.19821-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D867BF896EC
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 22:12:25 +0200 (CEST)
In-Reply-To: <20190419201218.19821-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, hdegoede@redhat.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed on alsa-devel, a zero value is useful to get rid of all
quirks. Set default to -1 and align types as done in other machine
drivers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f9175cf6747e..dc22df9a99fb 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -98,8 +98,8 @@ struct byt_rt5640_private {
 static bool is_bytcr;
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
-static unsigned int quirk_override;
-module_param_named(quirk, quirk_override, uint, 0444);
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
@@ -1254,7 +1254,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	dmi_id = dmi_first_match(byt_rt5640_quirk_table);
 	if (dmi_id)
 		byt_rt5640_quirk = (unsigned long)dmi_id->driver_data;
-	if (quirk_override) {
+	if (quirk_override != -1) {
 		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
-- 
2.17.1
