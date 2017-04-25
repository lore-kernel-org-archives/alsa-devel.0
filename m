From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 4/6] ASoC: Intel: Skylake: Register
	dsp_fw_ops for kabylake
Date: Tue, 25 Apr 2017 12:18:22 +0530
Message-ID: <1493102904-12624-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1493102904-12624-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A7F762669D8
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 09:01:41 +0200 (CEST)
In-Reply-To: <1493102904-12624-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For audio kabylake is same as skylake except the module load approach.
This patch registers different dsp_fw_ops for kabylake and next patch
adds the module load support for kabylake.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 +++
 sound/soc/intel/skylake/skl-sst.c      | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 09730dd8e6a3..ab1adc0c9cc3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -209,7 +209,7 @@ static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
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
@@ -230,6 +230,9 @@ int skl_dsp_core_unset_reset_state(struct sst_dsp *ctx,
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
@@ -470,6 +470,15 @@ static void skl_clear_module_table(struct sst_dsp *ctx)
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
1.9.1
