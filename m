From: Michele Curti <michele.curti@gmail.com>
Subject: different acpi_ipc_irq_index among baytrail boards
	issue
Date: Wed, 26 Aug 2015 19:28:23 +0200
Message-ID: <20150826172823.GA2038@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 707B5260525
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 19:28:26 +0200 (CEST)
Received: by wicne3 with SMTP id ne3so51617225wic.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 10:28:26 -0700 (PDT)
Received: from asus (host89-60-dynamic.0-87-r.retail.telecomitalia.it.
 [87.0.60.89])
 by smtp.gmail.com with ESMTPSA id ir5sm4838205wjb.23.2015.08.26.10.28.25
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2015 10:28:25 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi,
some baytrail machines, although belonging to the same platform, have
the ADSP IRQ number at different ACPI index (.acpi_ipc_irq_index = 0
instead of 5).

Not an issue for now, since there is no support for these machines (like
the Asus X205TA) at the moment, but if the driver will work, a patch like
the following would be acceptable (I ask so I can try to keep a sort of
patchset)?

* declare a new struct type sst_acpi_info where to place acpi infos
  lpe_res_index, ddr_index, ipc_irq_index
* create a new 'const struct sst_acpi_info *acpi_info' field into the
  struct sst_platform_info (to be managed like the others ipc_info,
  res_info, ...)
* move the acpi infos from the byt_rvp_res_info variable to a new
  byt_acpi_res_info one

In this way one could duplicate byt_rvp_acpi_info instead of the whole
byt_rvp_res_info (which seems "not good" to me, or it's ok?) to manage
different acpi indexes.

Hope I was clear enough..  Thanks,
Michele

---
 arch/x86/include/asm/platform_sst_audio.h | 11 ++++++++---
 sound/soc/intel/atom/sst/sst_acpi.c       | 17 +++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 7249e6d..b10f6a7 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -118,9 +118,6 @@ struct sst_res_info {
 	unsigned int dram_size;
 	unsigned int mbox_offset;
 	unsigned int mbox_size;
-	unsigned int acpi_lpe_res_index;
-	unsigned int acpi_ddr_index;
-	unsigned int acpi_ipc_irq_index;
 };
 
 struct sst_ipc_info {
@@ -128,13 +125,21 @@ struct sst_ipc_info {
 	unsigned int mbox_recv_off;
 };
 
+struct sst_acpi_info {
+	unsigned int lpe_res_index;
+	unsigned int ddr_index;
+	unsigned int ipc_irq_index;
+};
+
 struct sst_platform_info {
 	const struct sst_info *probe_data;
 	const struct sst_ipc_info *ipc_info;
+	const struct sst_acpi_info *acpi_info;
 	const struct sst_res_info *res_info;
 	const struct sst_lib_dnld_info *lib_info;
 	const char *platform;
 };
+
 int add_sst_platform_device(void);
 #endif
 
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b58..427e404 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -116,14 +116,18 @@ static const struct sst_res_info byt_rvp_res_info = {
 	.dram_size = 0x28000,
 	.mbox_offset = 0x144000,
 	.mbox_size = 0x1000,
-	.acpi_lpe_res_index = 0,
-	.acpi_ddr_index = 2,
-	.acpi_ipc_irq_index = 5,
+};
+
+static const struct sst_acpi_info byt_rvp_acpi_info = {
+	.lpe_res_index = 0,
+	.ddr_index = 2,
+	.ipc_irq_index = 5,
 };
 
 static struct sst_platform_info byt_rvp_platform_data = {
 	.probe_data = &byt_fwparse_info,
 	.ipc_info = &byt_ipc_info,
+	.acpi_info = &byt_rvp_acpi_info,
 	.lib_info = &byt_lib_dnld_info,
 	.res_info = &byt_rvp_res_info,
 	.platform = "sst-mfld-platform",
@@ -135,6 +139,7 @@ static struct sst_platform_info byt_rvp_platform_data = {
 static struct sst_platform_info chv_platform_data = {
 	.probe_data = &byt_fwparse_info,
 	.ipc_info = &byt_ipc_info,
+	.acpi_info = &byt_rvp_acpi_info,
 	.lib_info = &byt_lib_dnld_info,
 	.res_info = &byt_rvp_res_info,
 	.platform = "sst-mfld-platform",
@@ -148,7 +153,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* All ACPI resource request here */
 	/* Get Shim addr */
 	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
-					ctx->pdata->res_info->acpi_lpe_res_index);
+					ctx->pdata->acpi_info->lpe_res_index);
 	if (!rsrc) {
 		dev_err(ctx->dev, "Invalid SHIM base from IFWI");
 		return -EIO;
@@ -202,7 +207,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->mailbox_add = ctx->info.mailbox_start;
 
 	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
-					ctx->pdata->res_info->acpi_ddr_index);
+					ctx->pdata->acpi_info->ddr_index);
 	if (!rsrc) {
 		dev_err(ctx->dev, "Invalid DDR base from IFWI");
 		return -EIO;
@@ -219,7 +224,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 
 	/* Find the IRQ */
 	ctx->irq_num = platform_get_irq(pdev,
-				ctx->pdata->res_info->acpi_ipc_irq_index);
+				ctx->pdata->acpi_info->ipc_irq_index);
 	return 0;
 }
 
-- 
2.5.0
