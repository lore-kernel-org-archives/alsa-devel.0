From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 4/7] ASoC: Intel: Skylake: Register clock device and ops
Date: Mon, 18 Sep 2017 10:26:47 +0530
Message-ID: <1505710610-17952-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>

Create a platform device and register the clock ops. Clock
prepare/unprepare are used to enable/disable the clock as the IPC will be
sent in non-atomic context. The clk set_dma_control IPC structures are
populated during the set_rate callback and IPC is sent to enable the clock
during prepare callback.

Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl.c | 166 +++++++++++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h |   1 +
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 440caf1ced43..dc1a35ec1399 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -452,6 +452,133 @@ static int skl_free(struct hdac_ext_bus *ebus)
 						{.name = "ssp5_sclkfs"},
 };
 
+static enum skl_clk_type skl_get_clk_type(u32 index)
+{
+	switch (index) {
+	case 0 ... (SKL_SCLK_OFS - 1):
+		return SKL_MCLK;
+
+	case SKL_SCLK_OFS ... (SKL_SCLKFS_OFS - 1):
+		return SKL_SCLK;
+
+	case SKL_SCLKFS_OFS ... (SKL_MAX_CLK_CNT - 1):
+		return SKL_SCLK_FS;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int skl_get_vbus_id(u32 index, u8 clk_type)
+{
+	switch (clk_type) {
+	case SKL_MCLK:
+		return index;
+
+	case SKL_SCLK:
+		return index - SKL_SCLK_OFS;
+
+	case SKL_SCLK_FS:
+		return index - SKL_SCLKFS_OFS;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct skl_clk_rate_cfg_table *skl_get_rate_cfg(
+		struct skl_clk_rate_cfg_table *rcfg,
+				unsigned long rate)
+{
+	int i;
+
+	for (i = 0; (i < SKL_MAX_CLK_RATES) && rcfg[i].rate; i++) {
+		if (rcfg[i].rate == rate)
+			return &rcfg[i];
+	}
+
+	return NULL;
+}
+
+static int skl_clk_prepare(void *pvt_data, u32 id, unsigned long rate)
+{
+	struct skl *skl = pvt_data;
+	struct skl_clk_rate_cfg_table *rcfg;
+	int vbus_id, clk_type, ret;
+
+	clk_type = skl_get_clk_type(id);
+	if (clk_type < 0)
+		return -EINVAL;
+
+	ret = skl_get_vbus_id(id, clk_type);
+	if (ret < 0)
+		return ret;
+
+	vbus_id = ret;
+
+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
+	if (!rcfg)
+		return -EINVAL;
+
+	ret = skl_send_clk_dma_control(skl, rcfg, vbus_id, clk_type, true);
+
+	return ret;
+}
+
+static int skl_clk_unprepare(void *pvt_data, u32 id, unsigned long rate)
+{
+	struct skl *skl = pvt_data;
+	struct skl_clk_rate_cfg_table *rcfg;
+	int vbus_id, ret;
+	u8 clk_type;
+
+	clk_type = skl_get_clk_type(id);
+	ret = skl_get_vbus_id(id, clk_type);
+	if (ret < 0)
+		return ret;
+
+	vbus_id = ret;
+
+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
+	if (!rcfg)
+		return -EINVAL;
+
+	return skl_send_clk_dma_control(skl, rcfg, vbus_id, clk_type, false);
+}
+
+static int skl_clk_set_rate(u32 id, unsigned long rate)
+{
+	struct skl_clk_rate_cfg_table *rcfg;
+	u8 clk_type;
+
+	if (!rate)
+		return -EINVAL;
+
+	clk_type = skl_get_clk_type(id);
+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
+	if (!rcfg)
+		return -EINVAL;
+
+	skl_fill_clk_ipc(rcfg, clk_type);
+
+	return 0;
+}
+
+unsigned long skl_clk_recalc_rate(u32 id, unsigned long parent_rate)
+{
+	struct skl_clk_rate_cfg_table *rcfg;
+	u8 clk_type;
+
+	clk_type = skl_get_clk_type(id);
+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, parent_rate);
+	if (!rcfg)
+		return 0;
+
+	skl_fill_clk_ipc(rcfg, clk_type);
+
+	return rcfg->rate;
+}
+
 static int skl_machine_device_register(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
@@ -555,10 +682,21 @@ void init_skl_xtal_rate(int pci_id)
 	}
 }
 
+/*
+ * prepare/unprepare are used instead of enable/disable as IPC will be sent
+ * in non-atomic context.
+ */
+static struct skl_clk_ops clk_ops = {
+	.prepare = skl_clk_prepare,
+	.unprepare = skl_clk_unprepare,
+	.set_rate = skl_clk_set_rate,
+	.recalc_rate = skl_clk_recalc_rate,
+};
+
 static int skl_clock_device_register(struct skl *skl)
 {
 	struct skl_clk_pdata *clk_pdata;
-
+	struct platform_device_info pdevinfo = {NULL};
 
 	clk_pdata = devm_kzalloc(&skl->pci->dev, sizeof(*clk_pdata),
 							GFP_KERNEL);
@@ -573,10 +711,28 @@ static int skl_clock_device_register(struct skl *skl)
 
 	/* Query NHLT to fill the rates and parent */
 	skl_get_clks(skl, clk_pdata->ssp_clks);
+	clk_pdata->ops = &clk_ops;
+	clk_pdata->pvt_data = skl;
+
+	/* Register Platform device */
+	pdevinfo.parent = &skl->pci->dev;
+	pdevinfo.id = -1;
+	pdevinfo.name = "skl-ssp-clk";
+	pdevinfo.data = clk_pdata;
+	pdevinfo.size_data = sizeof(*clk_pdata);
+	skl->clk_dev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(skl->clk_dev))
+		return PTR_ERR(skl->clk_dev);
 
 	return 0;
 }
 
+static void skl_clock_device_unregister(struct skl *skl)
+{
+	if (skl->clk_dev)
+		platform_device_unregister(skl->clk_dev);
+}
+
 /*
  * Probe the given codec address
  */
@@ -859,6 +1015,11 @@ static int skl_probe(struct pci_dev *pci,
 
 	/* check if dsp is there */
 	if (bus->ppcap) {
+		/* create device for dsp clk */
+		err = skl_clock_device_register(skl);
+		if (err < 0)
+			goto out_clk_free;
+
 		err = skl_machine_device_register(skl,
 				  (void *)pci_id->driver_data);
 		if (err < 0)
@@ -890,6 +1051,8 @@ static int skl_probe(struct pci_dev *pci,
 	skl_free_dsp(skl);
 out_mach_free:
 	skl_machine_device_unregister(skl);
+out_clk_free:
+	skl_clock_device_unregister(skl);
 out_nhlt_free:
 	skl_nhlt_free(skl->nhlt);
 out_free:
@@ -940,6 +1103,7 @@ static void skl_remove(struct pci_dev *pci)
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
 	skl_dmic_device_unregister(skl);
+	skl_clock_device_unregister(skl);
 	skl_nhlt_remove_sysfs(skl);
 	skl_nhlt_free(skl->nhlt);
 	skl_free(ebus);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f06e98962a0b..df0fcf1bfe40 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -57,6 +57,7 @@ struct skl {
 	unsigned int init_done:1; /* delayed init status */
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
+	struct platform_device *clk_dev;
 	struct snd_soc_platform *platform;
 
 	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
-- 
1.9.1

