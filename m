From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] ASoC: Intel: Skylake: Fix to fill all
	sink/source pipe params
Date: Thu, 22 Oct 2015 23:22:37 +0530
Message-ID: <1445536362-26670-5-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A7C64260545
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:14 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Currently params only for first copier widget identified in the
source/sink path is queried from NHLT. In the dapm route the
playback/capture widget may be connected to more than one copier
widget. This patch adds return check to return only for any error
case.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0fba39dcb2ab..68e1b00ce7ed 100644
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
1.9.1
