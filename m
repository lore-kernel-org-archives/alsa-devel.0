From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 30/35] ASoC: Intel: Reuse sst_pdata::fw_name
	field
Date: Thu, 22 Aug 2019 21:04:20 +0200
Message-ID: <20190822190425.23001-31-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89C5FF80673
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:30 +0200 (CEST)
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

struct sst_pdata is equipped with fw_name field - a platform specific
filename for basefw module. Usage of such allows for suther
simplification of declaration of handlers directly involved with Skylake
initialization procedure.

This change invalidates mach::fw_filename field and skl::fw_name.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-acpi.c       | 5 ++---
 sound/soc/intel/common/sst-firmware.c   | 1 +
 sound/soc/intel/skylake/skl-messages.c  | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   | 3 +--
 sound/soc/intel/skylake/skl-sst-utils.c | 4 +---
 sound/soc/intel/skylake/skl.c           | 4 ----
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 53ac23f05966..15f2b27e643f 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -28,11 +28,10 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
 	struct sst_acpi_desc *desc = sst_acpi->desc;
 	struct sst_pdata *sst_pdata = desc->pdata;
-	struct snd_soc_acpi_mach *mach = sst_acpi->mach;
 
 	sst_pdata->fw = fw;
 	if (!fw) {
-		dev_err(dev, "Cannot load firmware %s\n", mach->fw_filename);
+		dev_err(dev, "Cannot load firmware %s\n", sst_pdata->fw_name);
 		return;
 	}
 
@@ -119,7 +118,7 @@ int sst_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(sst_acpi->pdev_mach);
 
 	/* continue SST probing after firmware is loaded */
-	ret = request_firmware_nowait(THIS_MODULE, true, mach->fw_filename,
+	ret = request_firmware_nowait(THIS_MODULE, true, sst_pdata->fw_name,
 				      dev, GFP_KERNEL, pdev, sst_acpi_fw_cb);
 	if (ret)
 		platform_device_unregister(sst_acpi->pdev_mach);
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 61d3e6e46b98..cc88849eb10f 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1218,6 +1218,7 @@ struct sst_dsp *sst_dsp_new(struct device *dev, struct sst_pdata *pdata)
 	sst->thread_context = pdata->dsp;
 	sst->id = pdata->id;
 	sst->irq = pdata->irq;
+	sst->fw_name = pdata->fw_name;
 	sst->ops = pdata->ops;
 	sst->pdata = pdata;
 	INIT_LIST_HEAD(&sst->used_block_list);
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 372c5fb83ddb..e401edd8d44b 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -201,7 +201,7 @@ int skl_init_dsp(struct skl_dev *skl, struct sst_pdata *pdata)
 	if (!ops)
 		return -EIO;
 
-	ret = skl_sst_ctx_init(skl, skl->fw_name, pdata);
+	ret = skl_sst_ctx_init(skl, pdata);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 8483c60f29ba..a3714b706b8e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -223,8 +223,7 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw);
 
 void skl_dsp_set_astate_cfg(struct skl_dev *skl, u32 cnt, void *data);
 
-int skl_sst_ctx_init(struct skl_dev *skl, const char *fw_name,
-		struct sst_pdata *pdata);
+int skl_sst_ctx_init(struct skl_dev *skl, struct sst_pdata *pdata);
 int skl_prepare_lib_load(struct skl_dev *skl, struct skl_lib_info *linfo,
 			struct firmware *stripped_fw,
 			unsigned int hdr_offset, int index);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index a4ad213d34e0..ea5419012312 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -354,8 +354,7 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 	return 0;
 }
 
-int skl_sst_ctx_init(struct skl_dev *skl, const char *fw_name,
-	struct sst_pdata *pdata)
+int skl_sst_ctx_init(struct skl_dev *skl, struct sst_pdata *pdata)
 {
 	struct sst_dsp *sst;
 	struct device *dev = skl->dev;
@@ -372,7 +371,6 @@ int skl_sst_ctx_init(struct skl_dev *skl, const char *fw_name,
 	}
 
 	skl->dsp = sst;
-	sst->fw_name = fw_name;
 	init_waitqueue_head(&skl->mod_load_wait);
 	skl->is_first_boot = true;
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 39442c80a179..3225f4f8793e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -491,9 +491,6 @@ static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl_dev *skl,
 	/* point to common table */
 	mach = snd_soc_acpi_intel_hda_machines;
 
-	/* all entries in the machine table use the same firmware */
-	mach->fw_filename = machines->fw_filename;
-
 	return mach;
 }
 
@@ -514,7 +511,6 @@ static int skl_find_machine(struct skl_dev *skl, void *driver_data)
 	}
 
 	skl->mach = mach;
-	skl->fw_name = mach->fw_filename;
 	pdata = mach->pdata;
 
 	if (pdata) {
-- 
2.17.1
