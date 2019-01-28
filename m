From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_da7213: platform name
	fixup support" to the asoc tree
Date: Mon, 28 Jan 2019 18:25:27 +0000 (GMT)
Message-ID: <20190128182527.11E161127D2D@debutante.sirena.org.uk>
References: <20190125203509.22994-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C492679BE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:27 +0100 (CET)
In-Reply-To: <20190125203509.22994-8-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: bytcht_da7213: platform name fixup support

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

>From 686338c12a2bd2d27f8444901fb9ce1a4c0c0b58 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:35:01 -0600
Subject: [PATCH] ASoC: Intel: bytcht_da7213: platform name fixup support

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_da7213.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 2179dedb28ad..b8e884803777 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -225,6 +225,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
 	int ret_val = 0;
@@ -250,6 +251,13 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 		dailink[dai_index].codec_name = codec_name;
 	}
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(card, platform_name);
+	if (ret_val)
+		return ret_val;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
 		dev_err(&pdev->dev,
-- 
2.20.1
