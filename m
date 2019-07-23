From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: set position buffer in
	init chip" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:12 +0100 (BST)
Message-ID: <20190723112912.C28862742BAB@ypsilon.sirena.org.uk>
References: <20190722141402.7194-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EFDBF8044B
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-14-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: set position buffer in init chip

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

>From 061edb232505797aee53a955225af23fa30d45b8 Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:54 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: set position buffer in init chip

Set the HDA stream position buffer during init chip. The position buffer
needs to be set in both HDA codec and nocodec cases. Using SOF defined
function and move it to common code.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-14-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-ctrl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index ea63f83a509b..015760284969 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -245,14 +245,13 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* program the position buffer */
 	if (bus->use_posbuf && bus->posbuf.addr) {
-		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
-		snd_hdac_chip_writel(bus, DPUBASE,
-				     upper_32_bits(bus->posbuf.addr));
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_ADSP_DPLBASE,
+				  (u32)bus->posbuf.addr);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_ADSP_DPUBASE,
+				  upper_32_bits(bus->posbuf.addr));
 	}
-#endif
 
 	bus->chip_init = true;
 
-- 
2.20.1
