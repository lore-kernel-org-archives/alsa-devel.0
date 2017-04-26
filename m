From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Register dsp_fw_ops for
	kabylake" to the asoc tree
Date: Wed, 26 Apr 2017 15:49:04 +0100
Message-ID: <E1d3OFc-0000R1-QX@finisterre>
References: <1492786693-24167-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC56267445
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:22 +0200 (CEST)
In-Reply-To: <1492786693-24167-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Register dsp_fw_ops for kabylake

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 89b0d8a5bae91cb8ef23b1834c97d1db367f2db6 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 25 Apr 2017 12:18:22 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Register dsp_fw_ops for kabylake

For audio kabylake is same as skylake except the module load approach.
This patch registers different dsp_fw_ops for kabylake and next patch
adds the module load support for kabylake.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 +++
 sound/soc/intel/skylake/skl-sst.c      | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 09730dd8e6a3..ab1adc0c9cc3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -209,7 +209,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 	{
 		.id = 0x9d71,
 		.loader_ops = skl_get_loader_ops,
-		.init = skl_sst_dsp_init,
+		.init = kbl_sst_dsp_init,
 		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 6d9aed23d5cd..eba20d37ba8c 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -230,6 +230,9 @@ int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
+int kbl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
+		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
+		struct skl_sst **dsp);
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index b4c3b5c63115..20968e5ec86d 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -470,6 +470,15 @@ static struct skl_dsp_fw_ops skl_fw_ops = {
 	.unload_mod = skl_unload_module,
 };
 
+static struct skl_dsp_fw_ops kbl_fw_ops = {
+	.set_state_D0 = skl_set_dsp_D0,
+	.set_state_D3 = skl_set_dsp_D3,
+	.load_fw = skl_load_base_firmware,
+	.get_fw_errcode = skl_get_errorcode,
+	.load_mod = skl_load_module,
+	.unload_mod = skl_unload_module,
+};
+
 static struct sst_ops skl_ops = {
 	.irq_handler = skl_dsp_sst_interrupt,
 	.write = sst_shim32_write,
@@ -512,6 +521,27 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
+int kbl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
+		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
+		struct skl_sst **dsp)
+{
+	struct sst_dsp *sst;
+	int ret;
+
+	ret = skl_sst_dsp_init(dev, mmio_base, irq, fw_name, dsp_ops, dsp);
+	if (ret < 0) {
+		dev_err(dev, "%s: Init failed %d\n", __func__, ret);
+		return ret;
+	}
+
+	sst = (*dsp)->dsp;
+	sst->fw_ops = kbl_fw_ops;
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(kbl_sst_dsp_init);
+
 int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 {
 	int ret;
-- 
2.11.0
