From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: intel: extend IPC dump
	information" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:06 +0100 (BST)
Message-ID: <20190613190607.115DF440046@finisterre.sirena.org.uk>
References: <20190612165705.1858-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC54FF89761
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:07 +0200 (CEST)
In-Reply-To: <20190612165705.1858-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: intel: extend IPC dump information

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

>From f1fd9d0e6dbae9c7cdd7e82fe3055ec7b790abb6 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Wed, 12 Jun 2019 11:57:03 -0500
Subject: [PATCH] ASoC: SOF: intel: extend IPC dump information

Extend the HDA IPC dump implementation with status of key IRQ
registers. This is useful to debug IPC timeouts and similar
issues.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/cnl.c |  2 ++
 sound/soc/sof/intel/hda.c | 29 +++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 9a4927b6b6ae..d59305787fc3 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -168,6 +168,8 @@ static void cnl_ipc_dump(struct snd_sof_dev *sdev)
 	u32 hipcida;
 	u32 hipctdr;
 
+	hda_ipc_irq_dump(sdev);
+
 	/* read IPC status */
 	hipcida = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDA);
 	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCCTL);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 47b508463218..af546e42e1d9 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -15,6 +15,9 @@
  * Hardware interface for generic Intel audio DSP HDA IP
  */
 
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
+
 #include <linux/module.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/sof.h>
@@ -183,12 +186,38 @@ void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags)
 	}
 }
 
+void hda_ipc_irq_dump(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	u32 adspis;
+	u32 intsts;
+	u32 intctl;
+	u32 ppsts;
+	u8 rirbsts;
+
+	/* read key IRQ stats and config registers */
+	adspis = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIS);
+	intsts = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS);
+	intctl = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL);
+	ppsts = snd_sof_dsp_read(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPSTS);
+	rirbsts = snd_hdac_chip_readb(bus, RIRBSTS);
+
+	dev_err(sdev->dev,
+		"error: hda irq intsts 0x%8.8x intlctl 0x%8.8x rirb %2.2x\n",
+		intsts, intctl, rirbsts);
+	dev_err(sdev->dev,
+		"error: dsp irq ppsts 0x%8.8x adspis 0x%8.8x\n",
+		ppsts, adspis);
+}
+
 void hda_ipc_dump(struct snd_sof_dev *sdev)
 {
 	u32 hipcie;
 	u32 hipct;
 	u32 hipcctl;
 
+	hda_ipc_irq_dump(sdev);
+
 	/* read IPC status */
 	hipcie = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCIE);
 	hipct = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCT);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 455046612b94..6c7dee2627d0 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -61,6 +61,7 @@
 #define SOF_HDA_PP_CAP_ID		0x3
 #define SOF_HDA_REG_PP_PPCH		0x10
 #define SOF_HDA_REG_PP_PPCTL		0x04
+#define SOF_HDA_REG_PP_PPSTS		0x08
 #define SOF_HDA_PPCTL_PIE		BIT(31)
 #define SOF_HDA_PPCTL_GPROCEN		BIT(30)
 
@@ -449,6 +450,7 @@ void hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
 void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
 void hda_ipc_dump(struct snd_sof_dev *sdev);
+void hda_ipc_irq_dump(struct snd_sof_dev *sdev);
 
 /*
  * DSP PCM Operations.
-- 
2.20.1
