From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: update mailbox uplink
	window offset and size" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:25 +0000
Message-ID: <E1a6NfZ-00043X-Si@debutante>
References: <1448703121-5831-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C48B2606A9
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:32 +0100 (CET)
In-Reply-To: <1448703121-5831-12-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Omair M Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: update mailbox uplink window offset and size

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

>From c99b80564c1badfa0cd14f4ebf3193fd77e412e9 Mon Sep 17 00:00:00 2001
From: Omair M Abdullah <omair.m.abdullah@intel.com>
Date: Thu, 3 Dec 2015 23:29:54 +0530
Subject: [PATCH] ASoC: Intel: Skylake: update mailbox uplink window offset and
 size

SKL actual mailbox size is 0x10000 and initial values were 0x800,
so update these accordingly

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 5d0947935e2b..cbb40751c37e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -58,9 +58,9 @@ struct sst_dsp_device;
 
 #define SKL_ADSP_MMIO_LEN		0x10000
 
-#define SKL_ADSP_W0_STAT_SZ		0x800
+#define SKL_ADSP_W0_STAT_SZ		0x1000
 
-#define SKL_ADSP_W0_UP_SZ		0x800
+#define SKL_ADSP_W0_UP_SZ		0x1000
 
 #define SKL_ADSP_W1_SZ			0x1000
 
-- 
2.6.2
