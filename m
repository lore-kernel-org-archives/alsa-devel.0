From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: clear stream status
	and wakests properly" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:19 +0100 (BST)
Message-ID: <20190617152419.E5E53440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30C9FF8972F
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:21 +0200 (CEST)
In-Reply-To: <20190612172347.22338-14-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: clear stream status and wakests properly

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

>From 3a39e0eae80919a15831f66324d4530454b4f495 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:45 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: clear stream status and wakests
 properly

Stream status and WAKESTS registers need to be cleared by writing
to them with snd_sof_dsp_write(). snd_sof_dsp_update_bits() only
writes if the value is changed and will result in not clearing
the status.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-ctrl.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 688ab8d895a9..ea63f83a509b 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -217,17 +217,14 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 	/* clear stream status */
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		sd_offset = SOF_STREAM_SD_OFFSET(stream);
-		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
-					sd_offset +
-					SOF_HDA_ADSP_REG_CL_SD_STS,
-					SOF_HDA_CL_DMA_SD_INT_MASK,
-					SOF_HDA_CL_DMA_SD_INT_MASK);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
+				  SOF_HDA_CL_DMA_SD_INT_MASK);
 	}
 
 	/* clear WAKESTS */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
-				SOF_HDA_WAKESTS_INT_MASK,
-				SOF_HDA_WAKESTS_INT_MASK);
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
+			  SOF_HDA_WAKESTS_INT_MASK);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* clear rirb status */
@@ -295,17 +292,14 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev)
 	/* clear stream status */
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		sd_offset = SOF_STREAM_SD_OFFSET(stream);
-		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
-					sd_offset +
-					SOF_HDA_ADSP_REG_CL_SD_STS,
-					SOF_HDA_CL_DMA_SD_INT_MASK,
-					SOF_HDA_CL_DMA_SD_INT_MASK);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
+				  SOF_HDA_CL_DMA_SD_INT_MASK);
 	}
 
 	/* clear WAKESTS */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
-				SOF_HDA_WAKESTS_INT_MASK,
-				SOF_HDA_WAKESTS_INT_MASK);
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
+			  SOF_HDA_WAKESTS_INT_MASK);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* clear rirb status */
-- 
2.20.1
