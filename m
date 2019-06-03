From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: cnl-ipc: re-enable IPC IRQ
	at end of handler" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:58 +0100 (BST)
Message-ID: <20190603180158.61B1F440049@finisterre.sirena.org.uk>
References: <20190603162032.7626-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B106F89717
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:01:59 +0200 (CEST)
In-Reply-To: <20190603162032.7626-5-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: cnl-ipc: re-enable IPC IRQ at end of handler

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

>From 3f58521bc81455bdfec2a44febf25ace8988a47f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 3 Jun 2019 11:20:28 -0500
Subject: [PATCH] ASoC: SOF: Intel: cnl-ipc: re-enable IPC IRQ at end of
 handler

Align with Skylake driver and enable the IRQ at end of handler,
instead of at beginning.

Also add an error log if we have nothing to do in this handler.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/cnl.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 4ecba1d8ec7f..b794a881542f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -37,7 +37,7 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	u32 hipctdd;
 	u32 msg;
 	u32 msg_ext;
-	irqreturn_t ret = IRQ_NONE;
+	bool ipc_irq = false;
 
 	hipcida = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDA);
 	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCCTL);
@@ -45,10 +45,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	hipctdd = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDD);
 	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR);
 
-	/* reenable IPC interrupt */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
-				HDA_DSP_ADSPIC_IPC, HDA_DSP_ADSPIC_IPC);
-
 	/* reply message from DSP */
 	if (hipcida & CNL_DSP_REG_HIPCIDA_DONE &&
 	    hipcctl & CNL_DSP_REG_HIPCCTL_DONE) {
@@ -79,7 +75,7 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 		spin_unlock_irq(&sdev->ipc_lock);
 
-		ret = IRQ_HANDLED;
+		ipc_irq = true;
 	}
 
 	/* new message from DSP */
@@ -101,10 +97,22 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 		cnl_ipc_host_done(sdev);
 
-		ret = IRQ_HANDLED;
+		ipc_irq = true;
+	}
+
+	if (!ipc_irq) {
+		/*
+		 * This interrupt is not shared so no need to return IRQ_NONE.
+		 */
+		dev_err_ratelimited(sdev->dev,
+				    "error: nothing to do in IRQ thread\n");
 	}
 
-	return ret;
+	/* re-enable IPC interrupt */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
+				HDA_DSP_ADSPIC_IPC, HDA_DSP_ADSPIC_IPC);
+
+	return IRQ_HANDLED;
 }
 
 static void cnl_ipc_host_done(struct snd_sof_dev *sdev)
-- 
2.20.1
