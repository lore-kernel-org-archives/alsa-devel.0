From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bdw-rt5677: Switch to
	devm_acpi_dev_add_driver_gpios()" to the asoc tree
Date: Fri, 16 Jun 2017 18:50:31 +0100
Message-ID: <E1dLvOB-0005lk-J1@debutante>
References: <20170615124638.65971-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B464E26752B
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 19:51:23 +0200 (CEST)
In-Reply-To: <20170615124638.65971-4-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bdw-rt5677: Switch to devm_acpi_dev_add_driver_gpios()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0931352dcb4d2019bf1ec2a5457a41d1d6566509 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 15 Jun 2017 15:46:38 +0300
Subject: [PATCH] ASoC: Intel: bdw-rt5677: Switch to
 devm_acpi_dev_add_driver_gpios()

Switch to use managed variant of acpi_dev_add_driver_gpios() to simplify
error path and fix potentially wrong assignment if ->probe() fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5677.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index bb98e94dd6f9..058b8ccedf02 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -207,8 +207,7 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int ret;
 
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(codec->dev),
-			bdw_rt5677_gpios);
+	ret = devm_acpi_dev_add_driver_gpios(codec->dev, bdw_rt5677_gpios);
 	if (ret)
 		dev_warn(codec->dev, "Failed to add driver gpios\n");
 
-- 
2.11.0
