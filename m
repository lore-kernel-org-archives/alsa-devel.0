From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bdw-rt5677: platform name fixup
	support" to the asoc tree
Date: Mon, 28 Jan 2019 18:25:33 +0000 (GMT)
Message-ID: <20190128182533.0D0BA1127D29@debutante.sirena.org.uk>
References: <20190125203509.22994-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B16142674D1
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:33 +0100 (CET)
In-Reply-To: <20190125203509.22994-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bdw-rt5677: platform name fixup support

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

>From 7e40ddcf974a970e750420f88365174cfd207b24 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:34:58 -0600
Subject: [PATCH] ASoC: Intel: bdw-rt5677: platform name fixup support

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5677.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index efcfd906c856..1844c88ea4e2 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -26,6 +26,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 
 #include "../common/sst-dsp.h"
 #include "../haswell/sst-haswell-ipc.h"
@@ -339,6 +340,9 @@ static struct snd_soc_card bdw_rt5677_card = {
 static int bdw_rt5677_probe(struct platform_device *pdev)
 {
 	struct bdw_rt5677_priv *bdw_rt5677;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name = NULL;
+	int ret;
 
 	bdw_rt5677_card.dev = &pdev->dev;
 
@@ -350,6 +354,16 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	if (mach) /* extra check since legacy does not pass parameters */
+		platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&bdw_rt5677_card,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	snd_soc_card_set_drvdata(&bdw_rt5677_card, bdw_rt5677);
 
 	return devm_snd_soc_register_card(&pdev->dev, &bdw_rt5677_card);
-- 
2.20.1
