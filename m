From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: only use sst-firmware when
	DW DMAC is available" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:13 +0900
Message-ID: <E1ZpOyv-0008NT-Rx@finisterre>
References: <1445493307-13667-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDDDB266B13
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:26 +0200 (CEST)
In-Reply-To: <1445493307-13667-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: only use sst-firmware when DW DMAC is available

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

>From ef3e199a49c8e605e326ae60c5e156bfb1ca7e3d Mon Sep 17 00:00:00 2001
From: Jie Yang <yang.jie@intel.com>
Date: Thu, 22 Oct 2015 13:55:07 +0800
Subject: [PATCH] ASoC: Intel: sst: only use sst-firmware when DW DMAC is
 available

Currentlly, we use Synopsys DesignWare DMA Controller for
baytrail/haswell/broadwell ADSP firmware loading, but for
skylake, we don't use it, compiling sst-firmware.c may
introduce error when CONFIG_DW_DMAC_CORE is not enabled:

    sound/built-in.o: In function `sst_dma_new':
    (.text+0xd7b38): undefined reference to `dw_dma_probe'
    sound/built-in.o: In function `sst_dma_free':
    (.text+0xd7c0a): undefined reference to `dw_dma_remove'

Here we only compile sst-firmware when CONFIG_DW_DMAC_CORE
is selected, to fix the linking error issue.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/Makefile  | 6 +++++-
 sound/soc/intel/common/sst-dsp.c | 2 ++
 sound/soc/intel/common/sst-dsp.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index f24154c..d910558 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,7 +1,11 @@
-snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
+snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 
+ifneq ($(CONFIG_DW_DMAC_CORE),)
+snd-soc-sst-dsp-objs += sst-firmware.o
+endif
+
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 
diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index a627236..c9452e0 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -420,6 +420,7 @@ void sst_dsp_inbox_read(struct sst_dsp *sst, void *message, size_t bytes)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_inbox_read);
 
+#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata)
 {
@@ -484,6 +485,7 @@ void sst_dsp_free(struct sst_dsp *sst)
 	sst_dma_free(sst->dma);
 }
 EXPORT_SYMBOL_GPL(sst_dsp_free);
+#endif
 
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 1f45f18..859f0de 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -216,10 +216,12 @@ struct sst_pdata {
 	void *dsp;
 };
 
+#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 /* Initialization */
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata);
 void sst_dsp_free(struct sst_dsp *sst);
+#endif
 
 /* SHIM Read / Write */
 void sst_dsp_shim_write(struct sst_dsp *sst, u32 offset, u32 value);
-- 
2.6.1
