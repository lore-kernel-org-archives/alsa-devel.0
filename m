From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: Initialize HDA
	controller after i915 init" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:50 +0100 (BST)
Message-ID: <20190807133050.3531D2742B9E@ypsilon.sirena.org.uk>
References: <20190806221958.19180-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DA0CF805F6
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:51 +0200 (CEST)
In-Reply-To: <20190806221958.19180-1-ranjani.sridharan@linux.intel.com>
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

   ASoC: SOF: Intel: hda: Initialize HDA controller after i915 init

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

>From cc352735d49c9c25fd711795bee35d3d001ddffa Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Tue, 6 Aug 2019 15:19:58 -0700
Subject: [PATCH] ASoC: SOF: Intel: hda: Initialize HDA controller after i915
 init

On some platforms, sound card registration fails when a HDMI
monitor is not connected. This is caused by a recent commit
that switched the order in which the HDA controller and the
i915 are initialized. Initializing the i915 before initializing
the HDA controller fixes the problem.

Fixes: be1b577d01787c ("ASoC: SOF: Intel: hda: fix the hda init chip"
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20190806221958.19180-1-ranjani.sridharan@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 136f98bf5d7e..82f61c4e74bd 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -321,10 +321,23 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	if (bus->ppcap)
 		dev_dbg(sdev->dev, "PP capability, will probe DSP later.\n");
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* init i915 and HDMI codecs */
+	ret = hda_codec_i915_init(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: init i915 and HDMI codec failed\n");
+		return ret;
+	}
+#endif
+
+	/* Init HDA controller after i915 init */
 	ret = hda_dsp_ctrl_init_chip(sdev, true);
 	if (ret < 0) {
 		dev_err(bus->dev, "error: init chip failed with ret: %d\n",
 			ret);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+		hda_codec_i915_exit(sdev);
+#endif
 		return ret;
 	}
 
@@ -332,13 +345,6 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
-	/* init i915 and HDMI codecs */
-	ret = hda_codec_i915_init(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: no HDMI audio devices found\n");
-		return ret;
-	}
-
 	/* codec detection */
 	if (!bus->codec_mask) {
 		dev_info(bus->dev, "no hda codecs found!\n");
-- 
2.20.1
