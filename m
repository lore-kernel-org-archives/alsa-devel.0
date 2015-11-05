From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add fw name to common dsp
	context" to the asoc tree
Date: Thu, 05 Nov 2015 16:29:37 +0000
Message-ID: <E1ZuNPt-0001JR-LI@finisterre>
References: <1446739455-22332-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F3CF2660EE
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:29:50 +0100 (CET)
In-Reply-To: <1446739455-22332-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: add fw name to common dsp context

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

>From df2031980e10bbcc291ecc67a1d96487d18da85e Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:14 +0530
Subject: [PATCH] ASoC: Intel: add fw name to common dsp context

In order to pass the fw name to IPC driver for loading fw, we
need to add a memeber to store the fw name

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp-priv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 2151652..4452cda 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -308,6 +308,8 @@ struct sst_dsp {
 
 	/* SKL data */
 
+	const char *fw_name;
+
 	/* To allocate CL dma buffers */
 	struct skl_dsp_loader_ops dsp_ops;
 	struct skl_dsp_fw_ops fw_ops;
-- 
2.6.1
