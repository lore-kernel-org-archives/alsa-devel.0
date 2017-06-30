From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add sram address to
	sst_addr structure" to the asoc tree
Date: Fri, 30 Jun 2017 13:29:58 +0100
Message-ID: <E1dQv3e-00011Z-9u@finisterre>
References: <20170629065604.30105-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A222674F0
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 14:30:15 +0200 (CEST)
In-Reply-To: <20170629065604.30105-4-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add sram address to sst_addr structure

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

>From 09e914d6b647cf23d81a226e1f1c4464bafdeb2d Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Fri, 30 Jun 2017 09:06:07 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add sram address to sst_addr structure

SRAM address and memory window size differ for different platforms.
So add members to sst_addr structure and initialize them in the
respective dsp_init().

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp-priv.h | 4 ++++
 sound/soc/intel/skylake/bxt-sst.c     | 4 ++++
 sound/soc/intel/skylake/skl-sst.c     | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index d13c84364c3c..8734040d64d3 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -77,6 +77,10 @@ struct sst_addr {
 	u32 dram_offset;
 	u32 dsp_iram_offset;
 	u32 dsp_dram_offset;
+	u32 sram0_base;
+	u32 sram1_base;
+	u32 w0_stat_sz;
+	u32 w0_up_sz;
 	void __iomem *lpe;
 	void __iomem *shim;
 	void __iomem *pci_cfg;
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index f5e7dbb1ba39..cf11b84888b9 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -573,6 +573,10 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst->fw_ops = bxt_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
+	sst->addr.sram0_base = BXT_ADSP_SRAM0_BASE;
+	sst->addr.sram1_base = BXT_ADSP_SRAM1_BASE;
+	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
+	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
 
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 155e456b7a3a..aba9ea11ac74 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -553,6 +553,11 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst = skl->dsp;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
+	sst->addr.sram0_base = SKL_ADSP_SRAM0_BASE;
+	sst->addr.sram1_base = SKL_ADSP_SRAM1_BASE;
+	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
+	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
+
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-- 
2.13.2
