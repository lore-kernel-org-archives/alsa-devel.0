From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: haswell: Simplify device probe"
	to the asoc tree
Date: Fri, 30 Aug 2019 12:45:18 +0100 (BST)
Message-ID: <20190830114518.3BCB12742B61@ypsilon.sirena.org.uk>
References: <20190822113616.22702-3-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AEBAF80483
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:45:21 +0200 (CEST)
In-Reply-To: <20190822113616.22702-3-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, tiwai@suse.com, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: haswell: Simplify device probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 1fc3e6b2ac3f8125ae54685c600d594d690a268a Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Thu, 22 Aug 2019 13:36:14 +0200
Subject: [PATCH] ASoC: Intel: haswell: Simplify device probe

With legacy ADSP private context adjusted, there is no need for double
safety.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20190822113616.22702-3-cezary.rojewski@intel.com
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/haswell.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 4d3822cff98c..3dadf9bff796 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -188,18 +188,14 @@ static struct snd_soc_card haswell_rt5640 = {
 static int haswell_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach;
-	const char *platform_name = NULL;
 	int ret;
 
 	haswell_rt5640.dev = &pdev->dev;
 
 	/* override plaform name, if required */
 	mach = (&pdev->dev)->platform_data;
-	if (mach) /* extra check since legacy does not pass parameters */
-		platform_name = mach->mach_params.platform;
-
 	ret = snd_soc_fixup_dai_links_platform_name(&haswell_rt5640,
-						    platform_name);
+						    mach->mach_params.platform);
 	if (ret)
 		return ret;
 
-- 
2.20.1
