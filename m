From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: core: fix error handling with the
	probe workqueue" to the asoc tree
Date: Tue, 28 May 2019 16:07:04 +0100 (BST)
Message-ID: <20190528150704.ED9A3440046@finisterre.sirena.org.uk>
References: <20190524190925.5931-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D205F8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:07:06 +0200 (CEST)
In-Reply-To: <20190524190925.5931-4-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: core: fix error handling with the probe workqueue

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

>From 0bce512e784d137700275f7839c4547eddbd4b6a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 24 May 2019 14:09:19 -0500
Subject: [PATCH] ASoC: SOF: core: fix error handling with the probe workqueue

In some configurations, it's a requirement to split the probe in two,
with a second part handled in a workqueue (e.g. for HDMI support
which depends on the DRM modules).

SOF already handles these configurations but the error flow is
incorrect. When an error occurs in the workqueue, the probe has
technically already completed. If we release the resources on errors,
this generates kernel oops/use-after-free when the resources are
released a second time on module removal.

GitHub issue: https://github.com/thesofproject/linux/issues/945
Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 693ad83bffc9..5beda47cdf9f 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -393,6 +393,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 	return 0;
 
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
 fw_run_err:
 	snd_sof_fw_unload(sdev);
 fw_load_err:
@@ -401,6 +402,21 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	snd_sof_free_debug(sdev);
 dbg_err:
 	snd_sof_remove(sdev);
+#else
+
+	/*
+	 * when the probe_continue is handled in a work queue, the
+	 * probe does not fail so we don't release resources here.
+	 * They will be released with an explicit call to
+	 * snd_sof_device_remove() when the PCI/ACPI device is removed
+	 */
+
+fw_run_err:
+fw_load_err:
+ipc_err:
+dbg_err:
+
+#endif
 
 	return ret;
 }
-- 
2.20.1
