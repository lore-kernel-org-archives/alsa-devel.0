From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/17] ASoC: Intel: Skylake: Fix to remove be
	copier widget power check
Date: Tue, 27 Oct 2015 09:22:54 +0900
Message-ID: <1445905380-18167-12-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C298C265185
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:48 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

ASoC core already checks if BE is active. If BE is active,
hw_params callback is ignored.
This patch removes the redundant check in driver for copier
widget power check in update be hw_params.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2f263ddd696d..7311cd317d87 100644
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
2.4.3
