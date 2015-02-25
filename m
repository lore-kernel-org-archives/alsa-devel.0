From: han.lu@intel.com
Subject: [PATCH 1/1] ASoC: Intel: remove conflicts when
	load/unload multiple firmware images
Date: Wed, 25 Feb 2015 08:26:21 +0800
Message-ID: <1424823981-14133-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6F9260515
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 01:28:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Details:
  1. Unload all modules on fw_list of dsp when suspend, and reload all
modules on fw_list when resume.
  2. A DSP expects only one scratch, but hsw_parse_fw_image() allocates
scratch blocks for each firmware image it parses. Move the allocate function
sst_block_alloc_scratch() out of hsw_parse_fw_image() to make sure a scratch
be allocated only after all firmware images be parsed.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index c42ffae..402b728 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -207,9 +207,6 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 		module = (void *)module + sizeof(*module) + module->mod_size;
 	}
 
-	/* allocate scratch mem regions */
-	sst_block_alloc_scratch(dsp);
-
 	return 0;
 }
 
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 394af56..863a9ca 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1732,6 +1732,7 @@ static void sst_hsw_drop_all(struct sst_hsw *hsw)
 int sst_hsw_dsp_load(struct sst_hsw *hsw)
 {
 	struct sst_dsp *dsp = hsw->dsp;
+	struct sst_fw *sst_fw, *t;
 	int ret;
 
 	dev_dbg(hsw->dev, "loading audio DSP....");
@@ -1748,12 +1749,17 @@ int sst_hsw_dsp_load(struct sst_hsw *hsw)
 		return ret;
 	}
 
-	ret = sst_fw_reload(hsw->sst_fw);
-	if (ret < 0) {
-		dev_err(hsw->dev, "error: SST FW reload failed\n");
-		sst_dsp_dma_put_channel(dsp);
-		return -ENOMEM;
+	list_for_each_entry_safe_reverse(sst_fw, t, &dsp->fw_list, list) {
+		ret = sst_fw_reload(sst_fw);
+		if (ret < 0) {
+			dev_err(hsw->dev, "error: SST FW reload failed\n");
+			sst_dsp_dma_put_channel(dsp);
+			return -ENOMEM;
+		}
 	}
+	ret = sst_block_alloc_scratch(hsw->dsp);
+	if (ret < 0)
+		return -EINVAL;
 
 	sst_dsp_dma_put_channel(dsp);
 	return 0;
@@ -1809,12 +1815,17 @@ int sst_hsw_dsp_runtime_suspend(struct sst_hsw *hsw)
 
 int sst_hsw_dsp_runtime_sleep(struct sst_hsw *hsw)
 {
-	sst_fw_unload(hsw->sst_fw);
-	sst_block_free_scratch(hsw->dsp);
+	struct sst_fw *sst_fw, *t;
+	struct sst_dsp *dsp = hsw->dsp;
+
+	list_for_each_entry_safe(sst_fw, t, &dsp->fw_list, list) {
+		sst_fw_unload(sst_fw);
+	}
+	sst_block_free_scratch(dsp);
 
 	hsw->boot_complete = false;
 
-	sst_dsp_sleep(hsw->dsp);
+	sst_dsp_sleep(dsp);
 
 	return 0;
 }
@@ -1943,6 +1954,11 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		goto fw_err;
 	}
 
+	/* allocate scratch mem regions */
+	ret = sst_block_alloc_scratch(hsw->dsp);
+	if (ret < 0)
+		goto boot_err;
+
 	/* wait for DSP boot completion */
 	sst_dsp_boot(hsw->dsp);
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
-- 
1.9.1
