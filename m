From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: core: fix undefined nocodec
	reference" to the asoc tree
Date: Wed,  8 May 2019 07:47:07 +0100 (BST)
Message-ID: <20190508064707.AA0FB440010@finisterre.sirena.org.uk>
References: <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A79FAF8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:47:22 +0200 (CEST)
In-Reply-To: <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: core: fix undefined nocodec reference

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From ce38a75089f70f6380fc63a5478a7659b4eb3f47 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 7 May 2019 11:32:36 -0500
Subject: [PATCH] ASoC: SOF: core: fix undefined nocodec reference

The existing code mistakenly uses IS_ENABLED in C code instead of as
in conditional compilation, leading to the following error:

ld: sound/soc/sof/core.o: in function `sof_machine_check':
sound/soc/sof/core.c:279: undefined reference to `sof_nocodec_setup'

Fix by using #if !IS_ENABLED()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 39cbd84ff9c8..5ddbfa8f1a28 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -265,11 +265,10 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
 	if (plat_data->machine)
 		return 0;
 
-	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)) {
-		dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
-		return -ENODEV;
-	}
-
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
+	dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
+	return -ENODEV;
+#else
 	/* fallback to nocodec mode */
 	dev_warn(sdev->dev, "No ASoC machine driver found - using nocodec\n");
 	machine = devm_kzalloc(sdev->dev, sizeof(*machine), GFP_KERNEL);
@@ -284,6 +283,7 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
 	plat_data->machine = machine;
 
 	return 0;
+#endif
 }
 
 static int sof_probe_continue(struct snd_sof_dev *sdev)
-- 
2.20.1
