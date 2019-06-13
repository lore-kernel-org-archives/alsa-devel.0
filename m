From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: ignore unrecoverable CTX_SAVE IPC
	errors at suspend" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:06 +0100 (BST)
Message-ID: <20190613190606.69A68440046@finisterre.sirena.org.uk>
References: <20190612165705.1858-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F645F89766
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:07 +0200 (CEST)
In-Reply-To: <20190612165705.1858-5-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: ignore unrecoverable CTX_SAVE IPC errors at suspend

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

>From e2eba551d2f4226400a6bb7871fef439ad1318dd Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Wed, 12 Jun 2019 11:57:04 -0500
Subject: [PATCH] ASoC: SOF: ignore unrecoverable CTX_SAVE IPC errors at
 suspend

As part of the suspend flow, a context save IPC message is
sent to the firmware before powering down the DSP. If errors
are met, the suspend flow is aborted with current code.

Change the behaviour such that if firmware returns -EBUSY or
-EAGAIN, return the error codes to PM core as before. The device
is left in active state in this case.

If other errors are reported, print a warning but do not block the
suspend flow. As per interface specification, no valid error can be
returned in this scenario. If the hardware has hit a fatal error and
is not able to respond successfully, best recovery method is to
proceed with suspend and power off the DSP.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 8ef1d51025d8..b7843f02ef67 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -343,11 +343,20 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 #endif
 	/* notify DSP of upcoming power down */
 	ret = sof_send_pm_ipc(sdev, SOF_IPC_PM_CTX_SAVE);
-	if (ret < 0) {
+	if (ret == -EBUSY || ret == -EAGAIN) {
+		/*
+		 * runtime PM has logic to handle -EBUSY/-EAGAIN so
+		 * pass these errors up
+		 */
 		dev_err(sdev->dev,
 			"error: ctx_save ipc error during suspend %d\n",
 			ret);
 		return ret;
+	} else if (ret < 0) {
+		/* FW in unexpected state, continue to power down */
+		dev_warn(sdev->dev,
+			 "ctx_save ipc error %d, proceeding with suspend\n",
+			 ret);
 	}
 
 	/* power down all DSP cores */
-- 
2.20.1
