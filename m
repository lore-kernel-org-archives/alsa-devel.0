From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to update bit depth
	for module params" to the asoc tree
Date: Wed, 25 Nov 2015 17:57:42 +0000
Message-ID: <E1a1eK6-0006Yq-C5@debutante>
References: <1448297789-6524-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE13265051
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:48 +0100 (CET)
In-Reply-To: <1448297789-6524-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to update bit depth for module params

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

>From 98256f83d2895fda3e596824797762937ab79f6b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 23 Nov 2015 22:26:25 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to update bit depth for module
 params

Module hw param fixup will change the valid bit depth based
on the fixup flag. If valid bit depth changes, need to set
the bit depth according to valid bit depth. This patch
fixes this issue of updating bit depth correctly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0937ea2129c1..698c4aa03933 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -147,8 +147,24 @@ static void skl_tplg_update_params(struct skl_module_fmt *fmt,
 		fmt->s_freq = params->s_freq;
 	if (fixup & SKL_CH_FIXUP_MASK)
 		fmt->channels = params->ch;
-	if (fixup & SKL_FMT_FIXUP_MASK)
-		fmt->valid_bit_depth = params->s_fmt;
+	if (fixup & SKL_FMT_FIXUP_MASK) {
+		fmt->valid_bit_depth = skl_get_bit_depth(params->s_fmt);
+
+		/*
+		 * 16 bit is 16 bit container whereas 24 bit is in 32 bit
+		 * container so update bit depth accordingly
+		 */
+		switch (fmt->valid_bit_depth) {
+		case SKL_DEPTH_16BIT:
+			fmt->bit_depth = fmt->valid_bit_depth;
+			break;
+
+		default:
+			fmt->bit_depth = SKL_DEPTH_32BIT;
+			break;
+		}
+	}
+
 }
 
 /*
-- 
2.6.2
