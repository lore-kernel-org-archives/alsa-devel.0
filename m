From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: core: remove
	snd_soc_unregister_component in case of error" to the asoc tree
Date: Tue, 28 May 2019 16:07:05 +0100 (BST)
Message-ID: <20190528150705.A0491440049@finisterre.sirena.org.uk>
References: <20190524190925.5931-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D909DF89735
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:07:06 +0200 (CEST)
In-Reply-To: <20190524190925.5931-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: core: remove snd_soc_unregister_component in case of error

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

>From 13931ae31b67a8a26a4cd417088fc43e3d4a8591 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 24 May 2019 14:09:18 -0500
Subject: [PATCH] ASoC: SOF: core: remove snd_soc_unregister_component in case
 of error

No need to call snd_soc_unregister_component in case of error
because the component device is resource-managed.

Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 0bc4a8472c10..693ad83bffc9 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -382,7 +382,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 	if (IS_ERR(plat_data->pdev_mach)) {
 		ret = PTR_ERR(plat_data->pdev_mach);
-		goto comp_err;
+		goto fw_run_err;
 	}
 
 	dev_dbg(sdev->dev, "created machine %s\n",
@@ -393,8 +393,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 	return 0;
 
-comp_err:
-	snd_soc_unregister_component(sdev->dev);
 fw_run_err:
 	snd_sof_fw_unload(sdev);
 fw_load_err:
-- 
2.20.1
