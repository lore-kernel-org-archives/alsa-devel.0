From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add dmabuffer to common sst_dsp"
	to the asoc tree
Date: Sun, 13 Mar 2016 15:15:01 +0700
Message-ID: <E1af1Az-0004Hc-HF@finisterre>
References: <1457671376-18667-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF622605B2
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:12 +0100 (CET)
In-Reply-To: <1457671376-18667-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: GuruprasadX Pawse <guruprasadx.pawse@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: add dmabuffer to common sst_dsp

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

>From b822ee63586c7150c10b445ae6b4bb29486f01e4 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 11 Mar 2016 10:12:52 +0530
Subject: [PATCH] ASoC: Intel: add dmabuffer to common sst_dsp

Broxton uses HDA DMA so needs to keep dmab in the driver context
so add it

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp-priv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 81aa1ed64201..97dc1ae05e69 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -317,6 +317,7 @@ struct sst_dsp {
 	struct skl_cl_dev cl_dev;
 	u32 intr_status;
 	const struct firmware *fw;
+	struct snd_dma_buffer dmab;
 };
 
 /* Size optimised DRAM/IRAM memcpy */
-- 
2.7.0
