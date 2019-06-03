From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: cnl-ipc: move code around
	for clarity" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:58 +0100 (BST)
Message-ID: <20190603180159.06297440046@finisterre.sirena.org.uk>
References: <20190603162032.7626-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39C02F896DB
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:00 +0200 (CEST)
In-Reply-To: <20190603162032.7626-4-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: cnl-ipc: move code around for clarity

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

>From ddbe9223393e4d067f010de65a05c9a6cb7790c1 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 3 Jun 2019 11:20:27 -0500
Subject: [PATCH] ASoC: SOF: Intel: cnl-ipc: move code around for clarity

Move all register access to cnl_ipc_host_done()
No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/cnl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 1fae75fc313f..4ecba1d8ec7f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -99,15 +99,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 			snd_sof_ipc_msgs_rx(sdev);
 		}
 
-		/*
-		 * clear busy interrupt to tell dsp controller this
-		 * interrupt has been accepted, not trigger it again
-		 */
-		snd_sof_dsp_update_bits_forced(sdev, HDA_DSP_BAR,
-					       CNL_DSP_REG_HIPCTDR,
-					       CNL_DSP_REG_HIPCTDR_BUSY,
-					       CNL_DSP_REG_HIPCTDR_BUSY);
-
 		cnl_ipc_host_done(sdev);
 
 		ret = IRQ_HANDLED;
@@ -118,6 +109,14 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 static void cnl_ipc_host_done(struct snd_sof_dev *sdev)
 {
+	/*
+	 * clear busy interrupt to tell dsp controller this
+	 * interrupt has been accepted, not trigger it again
+	 */
+	snd_sof_dsp_update_bits_forced(sdev, HDA_DSP_BAR,
+				       CNL_DSP_REG_HIPCTDR,
+				       CNL_DSP_REG_HIPCTDR_BUSY,
+				       CNL_DSP_REG_HIPCTDR_BUSY);
 	/*
 	 * set done bit to ack dsp the msg has been
 	 * processed and send reply msg to dsp
-- 
2.20.1
