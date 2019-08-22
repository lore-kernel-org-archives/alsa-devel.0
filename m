From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 34/35] ASoC: Intel: Skylake: Merge
	skl_sst_ctx_init into skl_init_dsp
Date: Thu, 22 Aug 2019 21:04:24 +0200
Message-ID: <20190822190425.23001-35-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08B75F8068A
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:36 +0200 (CEST)
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

skl_init_dsp and skl_sst_ctx_init share the exact same purpose: trigger
for sst_dsp creation. Merge them together. While adding code, change
reorders certain blocks, so skl_dev instance is always initialized
before sst_dsp_new cascade begins.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c  | 21 +++++++++++++++------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  1 -
 sound/soc/intel/skylake/skl-sst-utils.c | 23 -----------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 5f63c3052db9..7a161bbf8f26 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -142,18 +142,27 @@ int skl_dsp_cleanup(struct device *dev,
 
 int skl_init_dsp(struct skl_dev *skl, struct sst_pdata *pdata)
 {
+	struct sst_dsp *dsp;
 	struct hdac_bus *bus = skl_to_bus(skl);
-	int ret;
+	struct device *dev = skl->dev;
 
 	/* enable ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_enable(bus, true);
 	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
-	ret = skl_sst_ctx_init(skl, pdata);
-	if (ret < 0)
-		return ret;
-
-	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
+	skl->is_first_boot = true;
+	INIT_LIST_HEAD(&skl->uuid_list);
+	init_waitqueue_head(&skl->mod_load_wait);
+
+	pdata->id = skl->pci->device;
+	pdata->irq = skl->pci->irq;
+	pdata->dma_base = -1;
+	pdata->dsp = skl;
+	dsp = sst_dsp_new(dev, pdata);
+	if (!dsp) {
+		dev_err(dev, "%s: no device\n", __func__);
+		return -ENODEV;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 3294826d5cf7..eb8cc5606fc6 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -221,7 +221,6 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw);
 
 void skl_dsp_set_astate_cfg(struct skl_dev *skl, u32 cnt, void *data);
 
-int skl_sst_ctx_init(struct skl_dev *skl, struct sst_pdata *pdata);
 int skl_prepare_lib_load(struct skl_dev *skl, struct skl_lib_info *linfo,
 			struct firmware *stripped_fw,
 			unsigned int hdr_offset, int index);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index ea5419012312..34ac21b85cd9 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -354,29 +354,6 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 	return 0;
 }
 
-int skl_sst_ctx_init(struct skl_dev *skl, struct sst_pdata *pdata)
-{
-	struct sst_dsp *sst;
-	struct device *dev = skl->dev;
-
-	pdata->id = skl->pci->device;
-	pdata->irq = skl->pci->irq;
-	pdata->dma_base = -1;
-	pdata->dsp = skl;
-	INIT_LIST_HEAD(&skl->uuid_list);
-	sst = sst_dsp_new(dev, pdata);
-	if (!sst) {
-		dev_err(dev, "%s: no device\n", __func__);
-		return -ENODEV;
-	}
-
-	skl->dsp = sst;
-	init_waitqueue_head(&skl->mod_load_wait);
-	skl->is_first_boot = true;
-
-	return 0;
-}
-
 int skl_prepare_lib_load(struct skl_dev *skl, struct skl_lib_info *linfo,
 		struct firmware *stripped_fw,
 		unsigned int hdr_offset, int index)
-- 
2.17.1
