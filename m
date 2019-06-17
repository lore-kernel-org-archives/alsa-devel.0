From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: use the SOF defined
	ppcap functions" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:21 +0100 (BST)
Message-ID: <20190617152421.BFDFE440049@finisterre.sirena.org.uk>
References: <20190612172347.22338-11-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAFD9F89732
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:22 +0200 (CEST)
In-Reply-To: <20190612172347.22338-11-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: use the SOF defined ppcap functions

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

>From 24b6ff686fce808346c129bce52836c3339733bf Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:42 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: use the SOF defined ppcap functions

Unify ppcap function setup by using SOF common functions
for both HDA and non-HDA cases.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index c6eea3079ab7..883134d535b3 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -307,18 +307,14 @@ static int hda_suspend(struct snd_sof_dev *sdev, int state)
 		return ret;
 	}
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* disable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
-	snd_hdac_ext_bus_ppcap_enable(bus, false);
+	hda_dsp_ctrl_ppcap_enable(sdev, false);
+	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* disable hda bus irq and i/o */
 	snd_hdac_bus_stop_chip(bus);
 #else
-	/* disable ppcap interrupt */
-	hda_dsp_ctrl_ppcap_enable(sdev, false);
-	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
-
 	/* disable hda bus irq */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
@@ -370,10 +366,6 @@ static int hda_resume(struct snd_sof_dev *sdev)
 		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
-
-	/* enable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_enable(bus, true);
-	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 #else
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
@@ -400,11 +392,11 @@ static int hda_resume(struct snd_sof_dev *sdev)
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+#endif
 
 	/* enable ppcap interrupt */
 	hda_dsp_ctrl_ppcap_enable(sdev, true);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
-#endif
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* turn off the links that were off before suspend */
-- 
2.20.1
