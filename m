From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: broadwell: platform name fixup
	support" to the asoc tree
Date: Mon, 28 Jan 2019 18:25:35 +0000 (GMT)
Message-ID: <20190128182535.313321127D29@debutante.sirena.org.uk>
References: <20190125203509.22994-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC2712679E8
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:35 +0100 (CET)
In-Reply-To: <20190125203509.22994-4-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: broadwell: platform name fixup support

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

>From 2d067b2807f9d3381a37acef1b2f43682a868c7a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:34:57 -0600
Subject: [PATCH] ASoC: Intel: broadwell: platform name fixup support

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 99f2a0156ae8..b86c746d9b7a 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
+#include <sound/soc-acpi.h>
 
 #include "../common/sst-dsp.h"
 #include "../haswell/sst-haswell-ipc.h"
@@ -267,7 +268,22 @@ static struct snd_soc_card broadwell_rt286 = {
 
 static int broadwell_audio_probe(struct platform_device *pdev)
 {
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name = NULL;
+	int ret;
+
 	broadwell_rt286.dev = &pdev->dev;
+
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	if (mach) /* extra check since legacy does not pass parameters */
+		platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&broadwell_rt286,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
-- 
2.20.1
