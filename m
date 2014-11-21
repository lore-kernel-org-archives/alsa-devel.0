From: mengdong.lin@intel.com
Subject: [PATCH v6 2/2] ASoC: Intel: add support for
	Cherrytrail and Braswell in SST driver
Date: Fri, 21 Nov 2014 16:09:17 +0800
Message-ID: <c6ffd3359cec3412e5a43c90f6308cb2d75ed070.1416556905.git.mengdong.lin@intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 60936265AF5
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 09:02:40 +0100 (CET)
In-Reply-To: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com, subhransu.s.prusty@intel.com, liam.r.girdwood@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch add ACPI device ID and platform data for two Cherryview-based
platforms, Cherrytrail and Braswell. Also reuse mfld driver ops in sst driver.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index b2b5604..2be4f3f 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -183,6 +183,7 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
 	case SST_BYT_ACPI_ID:
+	case SST_CHV_ACPI_ID:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
 		sst->ops = &mrfld_ops;
 		return 0;
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 683dc71..7f4bbfc 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -30,6 +30,7 @@
 #define SST_DRV_NAME "intel_sst_driver"
 #define SST_MRFLD_PCI_ID 0x119A
 #define SST_BYT_ACPI_ID	0x80860F28
+#define SST_CHV_ACPI_ID	0x808622A8
 
 #define SST_SUSPEND_DELAY 2000
 #define FW_CONTEXT_MEM (64*1024)
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index b261821..c2e5edf 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -129,6 +129,17 @@ struct sst_platform_info byt_rvp_platform_data = {
 	.platform = "sst-mfld-platform",
 };
 
+/* Cherryview (Cherrytrail and Braswell) uses same mrfld dpcm fw as Baytrail,
+ * so pdata is same as Baytrail.
+ */
+struct sst_platform_info chv_platform_data = {
+	.probe_data = &byt_fwparse_info,
+	.ipc_info = &byt_ipc_info,
+	.lib_info = &byt_lib_dnld_info,
+	.res_info = &byt_rvp_res_info,
+	.platform = "sst-mfld-platform",
+};
+
 static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 {
 	struct resource *rsrc;
@@ -337,8 +348,16 @@ static struct sst_machines sst_acpi_bytcr[] = {
 	{},
 };
 
+/* Cherryview-based platforms: CherryTrail and Braswell */
+static struct sst_machines sst_acpi_chv[] = {
+	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "fw_sst_22a8.bin",
+						&chv_platform_data },
+	{},
+};
+
 static const struct acpi_device_id sst_acpi_ids[] = {
 	{ "80860F28", (unsigned long)&sst_acpi_bytcr},
+	{ "808622A8", (unsigned long) &sst_acpi_chv},
 	{ },
 };
 
-- 
1.9.1
