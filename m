From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: ICL add Icelake chip info
	struct" to the asoc tree
Date: Mon, 13 May 2019 13:30:28 +0100 (BST)
Message-ID: <20190513123028.6720A1129234@debutante.sirena.org.uk>
References: <20190509201027.3906-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4047F8972C
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <20190509201027.3906-7-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: ICL add Icelake chip info struct

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

>From 630be964b5d8d37d3dff9fc5c8af8a516aa94af0 Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Thu, 9 May 2019 15:10:27 -0500
Subject: [PATCH] ASoC: SOF: Intel: ICL add Icelake chip info struct

Icelake has different count of SSP other than CNL, using
the new defined ICL SSP count, and copy other parameters
from CNL chip info.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/cnl.c   | 19 +++++++++++++++++++
 sound/soc/sof/intel/hda.h   |  1 +
 sound/soc/sof/sof-pci-dev.c |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 08a1a3d3c08d..c059d1170bab 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -266,3 +266,22 @@ const struct sof_intel_dsp_desc cnl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 };
 EXPORT_SYMBOL(cnl_chip_info);
+
+const struct sof_intel_dsp_desc icl_chip_info = {
+	/* Icelake */
+	.cores_num = 4,
+	.init_core_mask = 1,
+	.cores_mask = HDA_DSP_CORE_MASK(0) |
+				HDA_DSP_CORE_MASK(1) |
+				HDA_DSP_CORE_MASK(2) |
+				HDA_DSP_CORE_MASK(3),
+	.ipc_req = CNL_DSP_REG_HIPCIDR,
+	.ipc_req_mask = CNL_DSP_REG_HIPCIDR_BUSY,
+	.ipc_ack = CNL_DSP_REG_HIPCIDA,
+	.ipc_ack_mask = CNL_DSP_REG_HIPCIDA_DONE,
+	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
+	.rom_init_timeout	= 300,
+	.ssp_count = ICL_SSP_COUNT,
+	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
+};
+EXPORT_SYMBOL(icl_chip_info);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 15ea50aff4ea..455046612b94 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -580,5 +580,6 @@ extern const struct snd_sof_dsp_ops sof_skl_ops;
 extern const struct sof_intel_dsp_desc apl_chip_info;
 extern const struct sof_intel_dsp_desc cnl_chip_info;
 extern const struct sof_intel_dsp_desc skl_chip_info;
+extern const struct sof_intel_dsp_desc icl_chip_info;
 
 #endif
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index d736806c2e0d..e2b19782f01a 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -157,7 +157,7 @@ static const struct sof_dev_desc icl_desc = {
 	.resindex_imr_base      = -1,
 	.irqindex_host_ipc      = -1,
 	.resindex_dma_base      = -1,
-	.chip_info = &cnl_chip_info,
+	.chip_info = &icl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
 	.nocodec_fw_filename = "sof-icl.ri",
-- 
2.20.1
