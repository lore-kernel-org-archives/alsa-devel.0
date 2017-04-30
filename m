From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Return negative error
	code" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:11 +0900
Message-ID: <E1d4oQV-00041q-0t@finisterre>
References: <1493275882-27708-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 883F9266BEF
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 14:58:20 +0200 (CEST)
In-Reply-To: <1493275882-27708-3-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Return negative error code

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

>From 081dc8ab46df85382658822e951ea79be87382b0 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Thu, 27 Apr 2017 12:21:22 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Return negative error code

skl_tplg_add_pipe() returned EEXIST instead of negative EEXIST, so fix that
and handle the return value as well.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0e459d3eb17a..29f68713a231 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1711,7 +1711,7 @@ static int skl_tplg_add_pipe(struct device *dev,
 	list_for_each_entry(ppl, &skl->ppl_list, node) {
 		if (ppl->pipe->ppl_id == tkn_elem->value) {
 			mconfig->pipe = ppl->pipe;
-			return EEXIST;
+			return -EEXIST;
 		}
 	}
 
@@ -2003,11 +2003,13 @@ static int skl_tplg_get_token(struct device *dev,
 		ret = skl_tplg_add_pipe(dev,
 				mconfig, skl, tkn_elem);
 
-		if (ret < 0)
+		if (ret < 0) {
+			if (ret == -EEXIST) {
+				is_pipe_exists = 1;
+				break;
+			}
 			return is_pipe_exists;
-
-		if (ret == EEXIST)
-			is_pipe_exists = 1;
+		}
 
 		break;
 
-- 
2.11.0
