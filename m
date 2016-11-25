From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Removed the unused I2S
	blob structure" to the asoc tree
Date: Fri, 25 Nov 2016 13:09:52 +0000
Message-ID: <E1cAGGG-00052v-RJ@debutante>
References: <1479921387-31248-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E33202672AE
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 14:10:04 +0100 (CET)
In-Reply-To: <1479921387-31248-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Removed the unused I2S blob structure

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

>From 48458cc891232ba6cb0270ba03520f54536d590a Mon Sep 17 00:00:00 2001
From: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Date: Wed, 23 Nov 2016 22:46:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Removed the unused I2S blob structure

Now that I2S conflig blob structure is no longer in use, remove it.

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 3b962d84bcb8..08d39280b07b 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -113,23 +113,6 @@ struct skl_cpr_gtw_cfg {
 	u32 config_data[1];
 } __packed;
 
-struct skl_i2s_config_blob {
-	u32 gateway_attrib;
-	u32 tdm_ts_group[8];
-	u32 ssc0;
-	u32 ssc1;
-	u32 sscto;
-	u32 sspsp;
-	u32 sstsa;
-	u32 ssrsa;
-	u32 ssc2;
-	u32 sspsp2;
-	u32 ssc3;
-	u32 ssioc;
-	u32 mdivc;
-	u32 mdivr;
-} __packed;
-
 struct skl_dma_control {
 	u32 node_id;
 	u32 config_length;
-- 
2.10.2
