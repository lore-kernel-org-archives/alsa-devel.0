From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/17] ASoC: Intel: Skylake: Fix to remove
	be copier widget power check
Date: Fri, 30 Oct 2015 11:08:34 +0900
Message-ID: <E1Zrz7K-0001BZ-3k@finisterre>
References: <1445905380-18167-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6B3D265D6F
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:36 +0100 (CET)
In-Reply-To: <1445905380-18167-12-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix to remove be copier widget power check

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

>From 43df6232cab7e110f51aade63b0ed1994c40f4bd Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:54 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix to remove be copier widget power
 check

ASoC core already checks if BE is active. If BE is active,
hw_params callback is ignored.
This patch removes the redundant check in driver for copier
widget power check in update be hw_params.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2f263dd..7311cd3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -950,18 +950,13 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 		if (p->connect && is_skl_dsp_widget_type(p->source) &&
 						p->source->priv) {
 
-			if (!p->source->power) {
-				ret = skl_tplg_be_fill_pipe_params(
-						dai, p->source->priv,
-						params);
-				if (ret < 0)
-					return ret;
-			} else {
-				return -EBUSY;
-			}
+			ret = skl_tplg_be_fill_pipe_params(dai,
+						p->source->priv, params);
+			if (ret < 0)
+				return ret;
 		} else {
-			ret = skl_tplg_be_set_src_pipe_params(
-						dai, p->source,	params);
+			ret = skl_tplg_be_set_src_pipe_params(dai,
+						p->source, params);
 			if (ret < 0)
 				return ret;
 		}
@@ -980,15 +975,10 @@ static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
 						p->sink->priv) {
 
-			if (!p->sink->power) {
-				ret = skl_tplg_be_fill_pipe_params(
-						dai, p->sink->priv, params);
-				if (ret < 0)
-					return ret;
-			} else {
-				return -EBUSY;
-			}
-
+			ret = skl_tplg_be_fill_pipe_params(dai,
+						p->sink->priv, params);
+			if (ret < 0)
+				return ret;
 		} else {
 			ret = skl_tplg_be_set_sink_pipe_params(
 						dai, p->sink, params);
-- 
2.6.1
