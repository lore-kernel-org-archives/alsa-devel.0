From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v3 1/5] ASoC: Intel: Skylake: Add api to
	retrieve dmic array info from nhlt
Date: Thu, 26 May 2016 21:30:15 -0700
Message-ID: <1464323415-28753-1-git-send-email-yong.zhi@intel.com>
References: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 395A726520A
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 06:27:26 +0200 (CEST)
In-Reply-To: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Skylake can be configured with either both 2 and 4 channel DMIC
array, or 2 channel DMIC array only, this patch provides an API to
retrieve the DMIC info from nhlt.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 40 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.h | 22 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.c      | 12 ++++++++++--
 sound/soc/intel/skylake/skl.h      |  6 ++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 7d73648..3f8e6f0 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -17,6 +17,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
+#include <linux/pci.h>
 #include "skl.h"
 
 /* Unique identification for getting NHLT blobs */
@@ -149,6 +150,45 @@ struct nhlt_specific_cfg
 	return NULL;
 }
 
+int skl_get_dmic_geo(struct skl *skl)
+{
+	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	struct nhlt_endpoint *epnt;
+	struct nhlt_dmic_array_config *cfg;
+	struct device *dev = &skl->pci->dev;
+	unsigned int dmic_geo = 0;
+	u8 j;
+
+	epnt = (struct nhlt_endpoint *)nhlt->desc;
+
+	for (j = 0; j < nhlt->endpoint_count; j++) {
+		if (epnt->linktype == NHLT_LINK_DMIC) {
+			cfg = (struct nhlt_dmic_array_config  *)
+					(epnt->config.caps);
+			switch (cfg->array_type) {
+			case NHLT_MIC_ARRAY_2CH_SMALL:
+			case NHLT_MIC_ARRAY_2CH_BIG:
+				dmic_geo |= MIC_ARRAY_2CH;
+				break;
+
+			case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
+			case NHLT_MIC_ARRAY_4CH_L_SHAPED:
+			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
+				dmic_geo |= MIC_ARRAY_4CH;
+				break;
+
+			default:
+				dev_warn(dev, "undefined DMIC array_type 0x%0x\n",
+						cfg->array_type);
+
+			}
+		}
+		epnt = (struct nhlt_endpoint *)((u8 *)epnt + epnt->length);
+	}
+
+	return dmic_geo;
+}
+
 static void skl_nhlt_trim_space(struct skl *skl)
 {
 	char *s = skl->tplg_name;
diff --git a/sound/soc/intel/skylake/skl-nhlt.h b/sound/soc/intel/skylake/skl-nhlt.h
index 3769f9f..116534e7 100644
--- a/sound/soc/intel/skylake/skl-nhlt.h
+++ b/sound/soc/intel/skylake/skl-nhlt.h
@@ -103,4 +103,26 @@ struct nhlt_resource_desc  {
 	u64 length;
 } __packed;
 
+#define MIC_ARRAY_2CH 2
+#define MIC_ARRAY_4CH 4
+
+struct nhlt_tdm_config {
+	u8 virtual_slot;
+	u8 config_type;
+} __packed;
+
+struct nhlt_dmic_array_config {
+	struct nhlt_tdm_config tdm_config;
+	u8 array_type;
+} __packed;
+
+enum {
+	NHLT_MIC_ARRAY_2CH_SMALL = 0xa,
+	NHLT_MIC_ARRAY_2CH_BIG = 0xb,
+	NHLT_MIC_ARRAY_4CH_1ST_GEOM = 0xc,
+	NHLT_MIC_ARRAY_4CH_L_SHAPED = 0xd,
+	NHLT_MIC_ARRAY_4CH_2ND_GEOM = 0xe,
+	NHLT_MIC_ARRAY_VENDOR_DEFINED = 0xf,
+};
+
 #endif
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06d8c26..b0f7226 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -35,6 +35,8 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 
+static struct skl_machine_pdata skl_dmic_data;
+
 /*
  * initialize the PCI registers
  */
@@ -397,6 +399,10 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 		platform_device_put(pdev);
 		return -EIO;
 	}
+
+	if (mach->pdata)
+		dev_set_drvdata(&pdev->dev, mach->pdata);
+
 	skl->i2s_dev = pdev;
 
 	return 0;
@@ -666,6 +672,8 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, ebus);
 
+	skl_dmic_data.dmic_num = skl_get_dmic_geo(skl);
+
 	/* check if dsp is there */
 	if (ebus->ppcap) {
 		err = skl_machine_device_register(skl,
@@ -787,9 +795,9 @@ static void skl_remove(struct pci_dev *pci)
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
 	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
-				NULL, NULL, NULL },
+				NULL, NULL, &skl_dmic_data },
 	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
-				NULL, NULL, NULL },
+				NULL, NULL, &skl_dmic_data },
 	{}
 };
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 4b4b387..f66be17 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -90,6 +90,11 @@ struct skl_dma_params {
 	u8 stream_tag;
 };
 
+/* to pass dmic data */
+struct skl_machine_pdata {
+	u32 dmic_num;
+};
+
 struct skl_dsp_ops {
 	int id;
 	struct skl_dsp_loader_ops (*loader_ops)(void);
@@ -108,6 +113,7 @@ void skl_nhlt_free(struct nhlt_acpi_table *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
+int skl_get_dmic_geo(struct skl *skl);
 int skl_nhlt_update_topology_bin(struct skl *skl);
 int skl_init_dsp(struct skl *skl);
 int skl_free_dsp(struct skl *skl);
-- 
1.9.1
