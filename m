From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: bxtn: Assign sram address to
	sst structure
Date: Thu, 29 Jun 2017 08:34:07 +0530
Message-ID: <20170629030408.4383-5-guneshwor.o.singh@intel.com>
References: <20170629030408.4383-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E9CB26720E
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 05:04:57 +0200 (CEST)
In-Reply-To: <20170629030408.4383-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

To read dsp registers via debugfs, assign sram address
in dsp_init().

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.13.0
