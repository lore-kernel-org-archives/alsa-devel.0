From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to fill all
	sink/source pipe params" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:46 +0900
Message-ID: <E1ZpgRO-0006Uw-U6@finisterre>
References: <1445536362-26670-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DB592651D5
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:56 +0200 (CEST)
In-Reply-To: <1445536362-26670-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to fill all sink/source pipe params

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

>From 4d8adccb220ca270cfcdd80752618095fdc9990c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 22 Oct 2015 23:22:37 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to fill all sink/source pipe params

Currently params only for first copier widget identified in the
source/sink path is queried from NHLT. In the dapm route the
playback/capture widget may be connected to more than one copier
widget. This patch adds return check to return only for any error
case.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0fba39d..68e1b00 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -944,48 +944,60 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 				struct skl_pipe_params *params)
 {
 	struct snd_soc_dapm_path *p;
+	int ret = -EIO;
 
 	snd_soc_dapm_widget_for_each_source_path(w, p) {
 		if (p->connect && is_skl_dsp_widget_type(p->source) &&
 						p->source->priv) {
 
-			if (!p->source->power)
-				return skl_tplg_be_fill_pipe_params(
+			if (!p->source->power) {
+				ret = skl_tplg_be_fill_pipe_params(
 						dai, p->source->priv,
 						params);
-			else
+				if (ret < 0)
+					return ret;
+			} else {
 				return -EBUSY;
+			}
 		} else {
-			return skl_tplg_be_set_src_pipe_params(
+			ret = skl_tplg_be_set_src_pipe_params(
 						dai, p->source,	params);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-	return -EIO;
+	return ret;
 }
 
 static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 	struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
 {
 	struct snd_soc_dapm_path *p = NULL;
+	int ret = -EIO;
 
 	snd_soc_dapm_widget_for_each_sink_path(w, p) {
 		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
 						p->sink->priv) {
 
-			if (!p->sink->power)
-				return skl_tplg_be_fill_pipe_params(
+			if (!p->sink->power) {
+				ret = skl_tplg_be_fill_pipe_params(
 						dai, p->sink->priv, params);
-			else
+				if (ret < 0)
+					return ret;
+			} else {
 				return -EBUSY;
+			}
 
 		} else {
-			return skl_tplg_be_set_sink_pipe_params(
+			ret = skl_tplg_be_set_sink_pipe_params(
 						dai, p->sink, params);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-	return -EIO;
+	return ret;
 }
 
 /*
-- 
2.6.1
