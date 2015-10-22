From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: switch from ioremap_cache to
	memremap" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:12 +0900
Message-ID: <E1ZpOyu-0008N0-Dc@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B37D266AF9
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:21 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: switch from ioremap_cache to memremap

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

>From ba40a854ea4f9d81368dc023bd25ac4073058039 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Oct 2015 18:16:36 -0400
Subject: [PATCH] ASoC: Intel: switch from ioremap_cache to memremap

In preparation for deprecating ioremap_cache() convert its usage in
skl-nhlt to memremap.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 10 +++++-----
 sound/soc/intel/skylake/skl.h      |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 13036b1..b0c7bd1 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -25,7 +25,7 @@ static u8 OSC_UUID[16] = {0x6E, 0x88, 0x9F, 0xA6, 0xEB, 0x6C, 0x94, 0x45,
 
 #define DSDT_NHLT_PATH "\\_SB.PCI0.HDAS"
 
-void __iomem *skl_nhlt_init(struct device *dev)
+void *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
 	union acpi_object *obj;
@@ -40,17 +40,17 @@ void __iomem *skl_nhlt_init(struct device *dev)
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
 
-		return ioremap_cache(nhlt_ptr->min_addr, nhlt_ptr->length);
+		return memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
+				MEMREMAP_WB);
 	}
 
 	dev_err(dev, "device specific method to extract NHLT blob failed\n");
 	return NULL;
 }
 
-void skl_nhlt_free(void __iomem *addr)
+void skl_nhlt_free(void *addr)
 {
-	iounmap(addr);
-	addr = NULL;
+	memunmap(addr);
 }
 
 static struct nhlt_specific_cfg *skl_get_specific_cfg(
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index e980d78..dd2e79a 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -62,7 +62,7 @@ struct skl {
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
 
-	void __iomem *nhlt; /* nhlt ptr */
+	void *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
 
 	struct skl_dsp_resource resource;
@@ -83,8 +83,8 @@ struct skl_dma_params {
 int skl_platform_unregister(struct device *dev);
 int skl_platform_register(struct device *dev);
 
-void __iomem *skl_nhlt_init(struct device *dev);
-void skl_nhlt_free(void __iomem *addr);
+void *skl_nhlt_init(struct device *dev);
+void skl_nhlt_free(void *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
-- 
2.6.1
