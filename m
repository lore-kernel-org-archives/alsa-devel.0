From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/11] ASoC: Intel: Skylake: Fix bind of source
	with multiple sinks
Date: Wed,  3 Feb 2016 17:59:51 +0530
Message-ID: <1454502594-21700-9-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C0717265A9A
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:44 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

skl_tplg_bind_sinks() takes only the first sink widget. This
breaks in case we have multiple sinks for a module.

So pass source widget to skl_tplg_bind_sinks() and bind for all
sinks by calling this recursively

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 244d87c0d106..722a05a7f098 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -547,6 +547,7 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 
 static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 				struct skl *skl,
+				struct snd_soc_dapm_widget *src_w,
 				struct skl_module_cfg *src_mconfig)
 {
 	struct snd_soc_dapm_path *p;
@@ -563,6 +564,10 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 		dev_dbg(ctx->dev, "%s: sink widget=%s\n", __func__, p->sink->name);
 
 		next_sink = p->sink;
+
+		if (!is_skl_dsp_widget_type(p->sink))
+			return skl_tplg_bind_sinks(p->sink, skl, src_w, src_mconfig);
+
 		/*
 		 * here we will check widgets in sink pipelines, so that
 		 * can be any widgets type and we are only interested if
@@ -592,7 +597,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 	}
 
 	if (!sink)
-		return skl_tplg_bind_sinks(next_sink, skl, src_mconfig);
+		return skl_tplg_bind_sinks(next_sink, skl, src_w, src_mconfig);
 
 	return 0;
 }
@@ -621,7 +626,7 @@ static int skl_tplg_pga_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	 * if sink is not started, start sink pipe first, then start
 	 * this pipe
 	 */
-	ret = skl_tplg_bind_sinks(w, skl, src_mconfig);
+	ret = skl_tplg_bind_sinks(w, skl, w, src_mconfig);
 	if (ret)
 		return ret;
 
-- 
1.9.1
