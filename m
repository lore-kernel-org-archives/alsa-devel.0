From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 32/35] ASoC: Intel: Skylake: Remove skl_dsp_ops
Date: Thu, 22 Aug 2019 21:04:22 +0200
Message-ID: <20190822190425.23001-33-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA22DF80677
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:33 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

All declaration simplication and addition of FIRMWARE_CONFIG and
HARDWARE_CONFIG led to ultimate goal of removal of struct skl_dsp_ops.
Strike it down, struct sst_pdata is more than enough is providing
description for SST platforms.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 53 --------------------------
 sound/soc/intel/skylake/skl.h          |  8 ----
 2 files changed, 61 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e401edd8d44b..5f63c3052db9 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -140,72 +140,19 @@ int skl_dsp_cleanup(struct device *dev,
 	return 0;
 }
 
-static const struct skl_dsp_ops dsp_ops[] = {
-	{
-		.id = 0x9d70,
-		.init = skl_sst_dsp_init,
-	},
-	{
-		.id = 0x9d71,
-		.init = skl_sst_dsp_init,
-	},
-	{
-		.id = 0x5a98,
-		.init = bxt_sst_dsp_init,
-	},
-	{
-		.id = 0x3198,
-		.init = bxt_sst_dsp_init,
-	},
-	{
-		.id = 0x9dc8,
-		.init = cnl_sst_dsp_init,
-	},
-	{
-		.id = 0xa348,
-		.init = cnl_sst_dsp_init,
-	},
-	{
-		.id = 0x02c8,
-		.init = cnl_sst_dsp_init,
-	},
-	{
-		.id = 0x06c8,
-		.init = cnl_sst_dsp_init,
-	},
-};
-
-const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dsp_ops); i++) {
-		if (dsp_ops[i].id == pci_id)
-			return &dsp_ops[i];
-	}
-
-	return NULL;
-}
-
 int skl_init_dsp(struct skl_dev *skl, struct sst_pdata *pdata)
 {
 	struct hdac_bus *bus = skl_to_bus(skl);
-	const struct skl_dsp_ops *ops;
 	int ret;
 
 	/* enable ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_enable(bus, true);
 	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
-	ops = skl_get_dsp_ops(skl->pci->device);
-	if (!ops)
-		return -EIO;
-
 	ret = skl_sst_ctx_init(skl, pdata);
 	if (ret < 0)
 		return ret;
 
-	skl->dsp_ops = ops;
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
 	return 0;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f4cd5ccc1ff9..218e8bda6cae 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -135,8 +135,6 @@ struct skl_dev {
 
 	struct skl_d0i3_data d0i3;
 
-	const struct skl_dsp_ops *dsp_ops;
-
 	/* Callback to update dynamic clock and power gating registers */
 	void (*clock_power_gating)(struct device *dev, bool enable);
 };
@@ -157,11 +155,6 @@ struct skl_machine_pdata {
 	bool use_tplg_pcm; /* use dais and dai links from topology */
 };
 
-struct skl_dsp_ops {
-	int id;
-	int (*init)(struct sst_dsp *dsp, struct sst_pdata *pdata);
-};
-
 int skl_platform_unregister(struct device *dev);
 int skl_platform_register(struct device *dev);
 
@@ -178,7 +171,6 @@ int skl_suspend_late_dsp(struct skl_dev *skl);
 int skl_suspend_dsp(struct skl_dev *skl);
 int skl_resume_dsp(struct skl_dev *skl);
 void skl_cleanup_resources(struct skl_dev *skl);
-const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id);
 void skl_update_d0i3c(struct device *dev, bool enable);
 int skl_nhlt_create_sysfs(struct skl_dev *skl);
 void skl_nhlt_remove_sysfs(struct skl_dev *skl);
-- 
2.17.1
