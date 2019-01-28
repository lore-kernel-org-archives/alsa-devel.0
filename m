From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_rt5672: platform name
	fixup support" to the asoc tree
Date: Mon, 28 Jan 2019 18:25:16 +0000 (GMT)
Message-ID: <20190128182516.73FCF1127D2D@debutante.sirena.org.uk>
References: <20190125203509.22994-13-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C80D2674A1
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:17 +0100 (CET)
In-Reply-To: <20190125203509.22994-13-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: cht_bsw_rt5672: platform name fixup support

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

>From f403906da05cdea38c222ef472fdc4df29ece47f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:35:06 -0600
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: platform name fixup support

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 9de64f447e7b..f1c1f9dd5353 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -400,6 +400,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int ret_val = 0;
 	struct cht_mc_private *drv;
 	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
+	const char *platform_name;
 	const char *i2c_name;
 	int i;
 
@@ -426,6 +427,14 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
+							platform_name);
+	if (ret_val)
+		return ret_val;
+
 	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-- 
2.20.1
