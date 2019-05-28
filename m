From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: core: remove DSP after
	unregistering machine driver" to the asoc tree
Date: Tue, 28 May 2019 16:07:06 +0100 (BST)
Message-ID: <20190528150706.40EB0440046@finisterre.sirena.org.uk>
References: <20190524190925.5931-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A18FDF8973E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:07:07 +0200 (CEST)
In-Reply-To: <20190524190925.5931-2-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: core: remove DSP after unregistering machine driver

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

>From b85459aafae63f250606bd406d4f7537fda33b51 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 24 May 2019 14:09:17 -0500
Subject: [PATCH] ASoC: SOF: core: remove DSP after unregistering machine
 driver

snd_sof_remove() disables the DSP and unmaps the DSP BAR.
Removing topology after disabling the DSP results in a
kernel panic while unloading the pipeline widget. This is
because pipeline widget unload attempts to power down
the core it is scheduled on by accessing the DSP registers.

So, the suggested fix here is to unregister the machine driver
first to remove the topology and then disable the DSP
to avoid the situation described above.

Note that the kernel panic only happens in cases where the
HDaudio link is not managed by the hdac library,
e.g. no codec or when HDMI is not supported.
When the hdac library is used, snd_sof_remove() calls
snd_hdac_ext_bus_device_remove() to remove the codec which
unregisters the component driver thereby also removing the
topology before the DSP is disabled.

Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 32105e0fabe8..0bc4a8472c10 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -484,7 +484,6 @@ int snd_sof_device_remove(struct device *dev)
 	snd_sof_ipc_free(sdev);
 	snd_sof_free_debug(sdev);
 	snd_sof_free_trace(sdev);
-	snd_sof_remove(sdev);
 
 	/*
 	 * Unregister machine driver. This will unbind the snd_card which
@@ -494,6 +493,14 @@ int snd_sof_device_remove(struct device *dev)
 	if (!IS_ERR_OR_NULL(pdata->pdev_mach))
 		platform_device_unregister(pdata->pdev_mach);
 
+	/*
+	 * Unregistering the machine driver results in unloading the topology.
+	 * Some widgets, ex: scheduler, attempt to power down the core they are
+	 * scheduled on, when they are unloaded. Therefore, the DSP must be
+	 * removed only after the topology has been unloaded.
+	 */
+	snd_sof_remove(sdev);
+
 	/* release firmware */
 	release_firmware(pdata->fw);
 	pdata->fw = NULL;
-- 
2.20.1
