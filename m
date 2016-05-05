From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix memory leak in nhlt
	init" to the asoc tree
Date: Thu, 05 May 2016 16:56:03 +0100
Message-ID: <E1ayLdD-0004ds-PZ@debutante>
References: <1462427359-30402-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 349ED266646
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 17:56:15 +0200 (CEST)
In-Reply-To: <1462427359-30402-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix memory leak in nhlt init

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c286b3f9600b2ddc573208792d947e1a251c6b15 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 5 May 2016 11:19:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix memory leak in nhlt init

During skl_nhlt_init(), acpi obj pointer is allocated and never
freed and remap address is not unmapped.

To fix this we should release the ACPI obj and also unmap the
nhlt address during cleanup of driver.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 15 +++++++++------
 sound/soc/intel/skylake/skl.c      |  5 ++++-
 sound/soc/intel/skylake/skl.h      |  6 +++---
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 14d1916ea9f8..7d73648e5f9a 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -25,11 +25,12 @@ static u8 OSC_UUID[16] = {0x6E, 0x88, 0x9F, 0xA6, 0xEB, 0x6C, 0x94, 0x45,
 
 #define DSDT_NHLT_PATH "\\_SB.PCI0.HDAS"
 
-void *skl_nhlt_init(struct device *dev)
+struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
 	union acpi_object *obj;
 	struct nhlt_resource_desc  *nhlt_ptr = NULL;
+	struct nhlt_acpi_table *nhlt_table = NULL;
 
 	if (ACPI_FAILURE(acpi_get_handle(NULL, DSDT_NHLT_PATH, &handle))) {
 		dev_err(dev, "Requested NHLT device not found\n");
@@ -39,18 +40,20 @@ void *skl_nhlt_init(struct device *dev)
 	obj = acpi_evaluate_dsm(handle, OSC_UUID, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-
-		return memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
+		nhlt_table = (struct nhlt_acpi_table *)
+				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
+		ACPI_FREE(obj);
+		return nhlt_table;
 	}
 
 	dev_err(dev, "device specific method to extract NHLT blob failed\n");
 	return NULL;
 }
 
-void skl_nhlt_free(void *addr)
+void skl_nhlt_free(struct nhlt_acpi_table *nhlt)
 {
-	memunmap(addr);
+	memunmap((void *) nhlt);
 }
 
 static struct nhlt_specific_cfg *skl_get_specific_cfg(
@@ -120,7 +123,7 @@ struct nhlt_specific_cfg
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
 	struct device *dev = bus->dev;
 	struct nhlt_specific_cfg *sp_config;
-	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	struct nhlt_acpi_table *nhlt = skl->nhlt;
 	u16 bps = (s_fmt == 16) ? 16 : 32;
 	u8 j;
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3982f5536f2d..83e985c0c0c9 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -643,7 +643,7 @@ static int skl_probe(struct pci_dev *pci,
 		err = skl_machine_device_register(skl,
 				  (void *)pci_id->driver_data);
 		if (err < 0)
-			goto out_free;
+			goto out_nhlt_free;
 
 		err = skl_init_dsp(skl);
 		if (err < 0) {
@@ -693,6 +693,8 @@ out_dsp_free:
 	skl_free_dsp(skl);
 out_mach_free:
 	skl_machine_device_unregister(skl);
+out_nhlt_free:
+	skl_nhlt_free(skl->nhlt);
 out_free:
 	skl->init_failed = 1;
 	skl_free(ebus);
@@ -743,6 +745,7 @@ static void skl_remove(struct pci_dev *pci)
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
 	skl_dmic_device_unregister(skl);
+	skl_nhlt_free(skl->nhlt);
 	skl_free(ebus);
 	dev_set_drvdata(&pci->dev, NULL);
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 39e16fa7a92b..4b4b3876aea9 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -66,7 +66,7 @@ struct skl {
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
 
-	void *nhlt; /* nhlt ptr */
+	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
 
 	struct skl_dsp_resource resource;
@@ -103,8 +103,8 @@ struct skl_dsp_ops {
 int skl_platform_unregister(struct device *dev);
 int skl_platform_register(struct device *dev);
 
-void *skl_nhlt_init(struct device *dev);
-void skl_nhlt_free(void *addr);
+struct nhlt_acpi_table *skl_nhlt_init(struct device *dev);
+void skl_nhlt_free(struct nhlt_acpi_table *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
-- 
2.8.1
