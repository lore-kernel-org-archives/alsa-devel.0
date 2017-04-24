From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: bytcr_rt5640: Fix a typo and quirk
	parameter type
Date: Mon, 24 Apr 2017 23:34:30 +0200
Message-ID: <20170424213430.24835-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4E6266AF7
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 23:34:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The previous patch for adding the quirk module option had a typo in
its info print, which results in a weird output.  Also, the parameter
type should be rather unsigned int instead of signed int.

Fixes: 9f2cf73ed65b ("ASoC: bytcr_rt5640: Allow quirk set via module option")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0ac32788f216..5ca09cadf39f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -60,7 +60,7 @@ struct byt_rt5640_private {
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 static unsigned int quirk_override;
-module_param_named(quirk, quirk_override, int, 0444);
+module_param_named(quirk, quirk_override, uint, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
@@ -811,7 +811,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 	if (quirk_override) {
-		dev_info(&pdev->dev, "Overriding quirk %0x => 0x%x\n",
+		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
-- 
2.11.1
