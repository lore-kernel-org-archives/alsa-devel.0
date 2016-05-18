From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH] ASoC: add api to retrieve dmic array info from
	coreboot nhlt
Date: Wed, 18 May 2016 08:33:08 -0700
Message-ID: <1463585588-8789-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 742C9260647
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:30:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, marc.herbert@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

skylake can be configured with either both 2 and 4 channel DMIC
array, or 2 channel DMIC array only, this patch provides an API to
retrieve the DMIC info from nhlt.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 37 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.h | 22 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c      | 10 +++++++++-
 sound/soc/intel/skylake/skl.h      |  6 ++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 7d73648..5448a48 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -149,6 +149,43 @@ struct nhlt_specific_cfg
 	return NULL;
 }
 
+int skl_get_ep_dmic(struct skl *skl)
+{
+	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	struct nhlt_endpoint *epnt;
+	struct nhlt_dmic_array_config *cfg;
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct device *dev = bus->dev;
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
+			case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
+			case NHLT_MIC_ARRAY_4CH_L_SHAPED:
+			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
+				dmic_geo |= MIC_ARRAY_4CH;
+				break;
+			default:
+				dev_warn(dev, "undefined DMIC array_type 0x%0x\n",
+						cfg->array_type);
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
index 3769f9f..8da502b 100644
--- a/sound/soc/intel/skylake/skl-nhlt.h
+++ b/sound/soc/intel/skylake/skl-nhlt.h
@@ -103,4 +103,26 @@ struct nhlt_resource_desc  {
 	u64 length;
 } __packed;
 
+#define MIC_ARRAY_2CH 2
+#define MIC_ARRAY_4CH 4
+
+struct nhlt_tdm_config {
+	uint8_t virtual_slot;
+	uint8_t config_type;
+} __packed;
+
+struct nhlt_dmic_array_config {
+	struct nhlt_tdm_config tdm_config;
+	uint8_t array_type;
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
index 06d8c26..a75b05f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -35,6 +35,8 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 
+static struct skl_dmic_info skl_dmic_data;
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
 
+	skl_dmic_data.dmic_num = skl_get_ep_dmic(skl);
+
 	/* check if dsp is there */
 	if (ebus->ppcap) {
 		err = skl_machine_device_register(skl,
@@ -789,7 +797,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
 				NULL, NULL, NULL },
 	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
-				NULL, NULL, NULL },
+				NULL, NULL, &skl_dmic_data},
 	{}
 };
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 4b4b387..889ec30 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -90,6 +90,11 @@ struct skl_dma_params {
 	u8 stream_tag;
 };
 
+/* to pass dmic data */
+struct skl_dmic_info {
+	u32 dmic_num;
+};
+
 struct skl_dsp_ops {
 	int id;
 	struct skl_dsp_loader_ops (*loader_ops)(void);
@@ -108,6 +113,7 @@ void skl_nhlt_free(struct nhlt_acpi_table *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
+int skl_get_ep_dmic(struct skl *skl);
 int skl_nhlt_update_topology_bin(struct skl *skl);
 int skl_init_dsp(struct skl *skl);
 int skl_free_dsp(struct skl *skl);
-- 
1.9.1
