From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: use the defined ppcap
	functions" to the asoc tree
Date: Thu, 30 May 2019 17:33:09 +0100 (BST)
Message-ID: <20190530163309.C5DFA440046@finisterre.sirena.org.uk>
References: <20190524190925.5931-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E70B0F80C1B
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:33:12 +0200 (CEST)
In-Reply-To: <20190524190925.5931-10-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: use the defined ppcap functions

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

>From 970c43d1783539b75a5e234ff5e51fc5c888112f Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Fri, 24 May 2019 14:09:25 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: use the defined ppcap functions

There are already defined ppcap and ppcap interrupt functions, use
the already defined functions for easy code read.

Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel DSP")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b1f4db0a6895..92c546e93400 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -544,13 +544,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		goto free_ipc_irq;
 
-	/* enable DSP features */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
-				SOF_HDA_PPCTL_GPROCEN, SOF_HDA_PPCTL_GPROCEN);
-
-	/* enable DSP IRQ */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
-				SOF_HDA_PPCTL_PIE, SOF_HDA_PPCTL_PIE);
+	/* enable ppcap interrupt */
+	hda_dsp_ctrl_ppcap_enable(sdev, true);
+	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
 
 	/* initialize waitq for code loading */
 	init_waitqueue_head(&sdev->waitq);
-- 
2.20.1
