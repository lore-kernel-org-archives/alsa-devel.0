From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: remove misleading
	error trace from IRQ thread" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:15 +0100 (BST)
Message-ID: <20190723112915.A2AE12742BAB@ypsilon.sirena.org.uk>
References: <20190722141402.7194-21-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2431F803D0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:16 +0200 (CEST)
In-Reply-To: <20190722141402.7194-21-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: remove misleading error trace from IRQ thread

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 717dedb1dcee92788b81233aa0a221573c95daff Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Mon, 22 Jul 2019 09:14:01 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: remove misleading error trace from IRQ
 thread

Downgrade "nothing to do in IRQ thread" message from error to a debug
message in the IPC interrupt handler thread.

The spurious wake-up can happen if a HDA stream interrupt is
raised while the IPC interrupt thread is running. IPC functionality
is not impacted by this condition, so debug is a more appropriate
trace level.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-21-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/cnl.c     | 4 ++--
 sound/soc/sof/intel/hda-ipc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index f2b392998f20..ffd8d4394537 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -101,8 +101,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 		/*
 		 * This interrupt is not shared so no need to return IRQ_NONE.
 		 */
-		dev_err_ratelimited(sdev->dev,
-				    "error: nothing to do in IRQ thread\n");
+		dev_dbg_ratelimited(sdev->dev,
+				    "nothing to do in IPC IRQ thread\n");
 	}
 
 	/* re-enable IPC interrupt */
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 50244b82600c..2ecba91f5219 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -224,8 +224,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 		/*
 		 * This interrupt is not shared so no need to return IRQ_NONE.
 		 */
-		dev_err_ratelimited(sdev->dev,
-				    "error: nothing to do in IRQ thread\n");
+		dev_dbg_ratelimited(sdev->dev,
+				    "nothing to do in IPC IRQ thread\n");
 	}
 
 	/* re-enable IPC interrupt */
-- 
2.20.1
