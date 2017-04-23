From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3] ASoC: bytcr_rt5640: Allow quirk set via
	module option
Date: Sun, 23 Apr 2017 09:22:56 +0200
Message-ID: <20170423072256.26750-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB4E26664F
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 09:22:58 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The bytcr-rt5640 driver has a few quirk setups depending on the board,
where the quirk value is set by DMI matching.  When you have a new
device to add the support, you often experience to try the different
quirk by trial-and-error.  Or, you may have a development model that
still has no proper DMI string.  In either case, you'd need to compile
the driver at each time.

This patch introduces a module option to override the quirk value on
the fly.  User can boot like snd-soc-sst-bytcr-rt5640.quirk=0x4004 to
override the default value without recompilation.  It's a raw value,
so user needs to check the source code for the meaning of each bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: override the quirk value completely
v2->v3: print the override information

 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5c7219fb3aa8..0ac32788f216 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -19,6 +19,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -58,6 +59,9 @@ struct byt_rt5640_private {
 };
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
+static unsigned int quirk_override;
+module_param_named(quirk, quirk_override, int, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
@@ -806,6 +810,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
+	if (quirk_override) {
+		dev_info(&pdev->dev, "Overriding quirk %0x => 0x%x\n",
+			 (unsigned int)byt_rt5640_quirk, quirk_override);
+		byt_rt5640_quirk = quirk_override;
+	}
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-- 
2.11.1
