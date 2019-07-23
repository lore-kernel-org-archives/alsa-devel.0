From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: use SOF defined init
	chip in resume" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:12 +0100 (BST)
Message-ID: <20190723112912.7919F2742B60@ypsilon.sirena.org.uk>
References: <20190722141402.7194-15-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03A12F8044A
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-15-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: use SOF defined init chip in resume

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From d06973515f95ac74d68fb3e1f1fb4b055531296c Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:55 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: use SOF defined init chip in resume

Unify resume code by using SOF common function hda_dsp_ctrl_init_chip()
which can handle both HDA and non-HDA cases. Move code to reset
stream-to-link mapping into hda_dsp_ctrl_init_chip().

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-15-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-ctrl.c |  9 +++++++++
 sound/soc/sof/intel/hda-dsp.c  | 26 --------------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 015760284969..8b856dc35e20 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -164,6 +164,9 @@ int hda_dsp_ctrl_clock_power_gating(struct snd_sof_dev *sdev, bool enable)
 int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_ext_link *hlink;
+#endif
 	struct hdac_stream *stream;
 	int sd_offset, ret = 0;
 
@@ -253,6 +256,12 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 				  upper_32_bits(bus->posbuf.addr));
 	}
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* Reset stream-to-link mapping */
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
+#endif
+
 	bus->chip_init = true;
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f9579edbca68..f08a5d649346 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -368,32 +368,6 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 	/* check dma status and clean up CORB/RIRB buffers */
 	if (!bus->cmd_dma_state)
 		snd_hdac_bus_stop_cmd_io(bus);
-#else
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, false);
-
-	/* reset controller */
-	ret = hda_dsp_ctrl_link_reset(sdev, true);
-	if (ret < 0) {
-		dev_err(sdev->dev,
-			"error: failed to reset controller during resume\n");
-		return ret;
-	}
-
-	/* take controller out of reset */
-	ret = hda_dsp_ctrl_link_reset(sdev, false);
-	if (ret < 0) {
-		dev_err(sdev->dev,
-			"error: failed to ready controller during resume\n");
-		return ret;
-	}
-
-	/* enable hda bus irq */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
-				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
-				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, true);
 #endif
 
 	/* enable ppcap interrupt */
-- 
2.20.1
