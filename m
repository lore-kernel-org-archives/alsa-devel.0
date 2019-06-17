From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: use the defined stop
	chip in suspend" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:20 +0100 (BST)
Message-ID: <20190617152420.87999440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-13-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53381F89730
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:21 +0200 (CEST)
In-Reply-To: <20190612172347.22338-13-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: use the defined stop chip in suspend

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

>From 9a50ee58b8b11300788d41cd1c0f370833424823 Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:44 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: use the defined stop chip in suspend

Unify suspend code by using SOF common function
hda_dsp_ctrl_stop_chip() which can handle both HDA
and non-HDA cases.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 883134d535b3..f2c5a12db930 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -311,15 +311,8 @@ static int hda_suspend(struct snd_sof_dev *sdev, int state)
 	hda_dsp_ctrl_ppcap_enable(sdev, false);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* disable hda bus irq and i/o */
-	snd_hdac_bus_stop_chip(bus);
-#else
-	/* disable hda bus irq */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
-				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
-				0);
-#endif
+	/* disable hda bus irq and streams */
+	hda_dsp_ctrl_stop_chip(sdev);
 
 	/* disable LP retention mode */
 	snd_sof_pci_update_bits(sdev, PCI_PGCTL,
-- 
2.20.1
