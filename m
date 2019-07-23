From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: reduce ifdef usage for
	hda" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:13 +0100 (BST)
Message-ID: <20190723112913.306E12742B59@ypsilon.sirena.org.uk>
References: <20190722141402.7194-12-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95373F80483
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-12-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rander Wang <rander.wang@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: reduce ifdef usage for hda

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

>From 6aa232e1ccfcd2b55306b86803dc547c36f8ad15 Mon Sep 17 00:00:00 2001
From: Rander Wang <rander.wang@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:52 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: reduce ifdef usage for hda

Move the code for hda to one point

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-12-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 4315896b3f07..3d711d354fb9 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -359,6 +359,16 @@ static int hda_resume(struct snd_sof_dev *sdev)
 		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+
+	/* turn off the links that were off before suspend */
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
+		if (!hlink->ref_count)
+			snd_hdac_ext_bus_link_power_down(hlink);
+	}
+
+	/* check dma status and clean up CORB/RIRB buffers */
+	if (!bus->cmd_dma_state)
+		snd_hdac_bus_stop_cmd_io(bus);
 #else
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
@@ -391,18 +401,6 @@ static int hda_resume(struct snd_sof_dev *sdev)
 	hda_dsp_ctrl_ppcap_enable(sdev, true);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* turn off the links that were off before suspend */
-	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		if (!hlink->ref_count)
-			snd_hdac_ext_bus_link_power_down(hlink);
-	}
-
-	/* check dma status and clean up CORB/RIRB buffers */
-	if (!bus->cmd_dma_state)
-		snd_hdac_bus_stop_cmd_io(bus);
-#endif
-
 	return 0;
 }
 
-- 
2.20.1
