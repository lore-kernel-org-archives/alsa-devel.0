From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: mrfld: Replace pci_id with
	unique device id
Date: Fri, 24 Oct 2014 13:49:46 +0530
Message-ID: <1414138788-4632-2-git-send-email-vinod.koul@intel.com>
References: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEB22604A0
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 10:59:40 +0200 (CEST)
In-Reply-To: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

In order to support both ACPI and PCI devices we need to use a genric device
id in driver, so change all pci_id instances to device_id

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c     |   10 +++++-----
 sound/soc/intel/sst/sst.h     |    5 +++--
 sound/soc/intel/sst/sst_pvt.c |    4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index d88cdd9..fa34217 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -167,7 +167,7 @@ static struct intel_sst_ops mrfld_ops = {
 int sst_driver_ops(struct intel_sst_drv *sst)
 {
 
-	switch (sst->pci_id) {
+	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
 		sst->ops = &mrfld_ops;
@@ -175,7 +175,7 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 
 	default:
 		dev_err(sst->dev,
-			"SST Driver capablities missing for pci_id: %x", sst->pci_id);
+			"SST Driver capablities missing for dev_id: %x", sst->dev_id);
 		return -EINVAL;
 	};
 }
@@ -210,7 +210,7 @@ static int intel_sst_probe(struct pci_dev *pci,
 		return -ENOMEM;
 
 	sst_drv_ctx->dev = &pci->dev;
-	sst_drv_ctx->pci_id = pci->device;
+	sst_drv_ctx->dev_id = pci->device;
 	if (!sst_pdata)
 		return -EINVAL;
 
@@ -278,7 +278,7 @@ static int intel_sst_probe(struct pci_dev *pci,
 
 	/* map registers */
 	/* DDR base */
-	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID) {
+	if (sst_drv_ctx->dev_id == SST_MRFLD_PCI_ID) {
 		sst_drv_ctx->ddr_base = pci_resource_start(pci, 0);
 		/* check that the relocated IMR base matches with FW Binary */
 		ddr_base = relocate_imr_addr_mrfld(sst_drv_ctx->ddr_base);
@@ -357,7 +357,7 @@ static int intel_sst_probe(struct pci_dev *pci,
 	dev_dbg(sst_drv_ctx->dev, "Registered IRQ 0x%x\n", pci->irq);
 
 	/* default intr are unmasked so set this as masked */
-	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID)
+	if (sst_drv_ctx->dev_id == SST_MRFLD_PCI_ID)
 		sst_shim_write64(sst_drv_ctx->shim, SST_IMRX, 0xFFFF0038);
 
 	pci_set_drvdata(pci, sst_drv_ctx);
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index bfcf51a..b65b9c0 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -337,7 +337,8 @@ struct sst_shim_regs64 {
  * struct intel_sst_drv - driver ops
  *
  * @sst_state : current sst device state
- * @pci_id : PCI device id loaded
+ * @dev_id : device identifier, pci_id for pci devices and acpi_id for acpi
+ * 	     devices
  * @shim : SST shim pointer
  * @mailbox : SST mailbox pointer
  * @iram : SST IRAM pointer
@@ -371,7 +372,7 @@ struct sst_shim_regs64 {
 struct intel_sst_drv {
 	int			sst_state;
 	int			irq_num;
-	unsigned int		pci_id;
+	unsigned int		dev_id;
 	void __iomem		*ddr;
 	void __iomem		*shim;
 	void __iomem		*mailbox;
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/sst/sst_pvt.c
index 9e5f69b..1c2e081 100644
--- a/sound/soc/intel/sst/sst_pvt.c
+++ b/sound/soc/intel/sst/sst_pvt.c
@@ -115,7 +115,7 @@ unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
 {
 	unsigned long long val = 0;
 
-	switch (sst->pci_id) {
+	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
 		val = sst_shim_read64(sst->shim, addr);
 		break;
@@ -126,7 +126,7 @@ unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
 void write_shim_data(struct intel_sst_drv *sst, int addr,
 				unsigned long long data)
 {
-	switch (sst->pci_id) {
+	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
 		sst_shim_write64(sst->shim, addr, (u64) data);
 		break;
-- 
1.7.0.4
