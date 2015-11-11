From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/9] ASoC: Intel: Skylake: Fix null ptr
	dereferenced in skl_tplg_bind_sinks
Date: Thu, 12 Nov 2015 00:16:47 +0530
Message-ID: <1447267609-27816-8-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1273C265982
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:47 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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

This patch fixes the below warning form smatch and makes the
skl_tplg_bind_sinks take the next sink as argument which is true
when the current sink is valid

sound/soc/intel/skylake/skl-topology.c:453 skl_tplg_bind_sinks()
	error: we previously assumed 'sink' could be null (see line 452)

sound/soc/intel/skylake/skl-topology.c
   451
   452		if (!sink)
                     ^^^^
New check.  Reversed?

   453			return skl_tplg_bind_sinks(sink, skl, src_mconfig);
                                                   ^^^^ This is
dereferenced inside the function.

   454
   455		return 0;

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2b6ee22b5ea2..0937ea2129c1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -408,7 +408,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 				struct skl_module_cfg *src_mconfig)
 {
 	struct snd_soc_dapm_path *p;
-	struct snd_soc_dapm_widget *sink = NULL;
+	struct snd_soc_dapm_widget *sink = NULL, *next_sink = NULL;
 	struct skl_module_cfg *sink_mconfig;
 	struct skl_sst *ctx = skl->skl_sst;
 	int ret;
@@ -420,7 +420,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 		dev_dbg(ctx->dev, "%s: src widget=%s\n", __func__, w->name);
 		dev_dbg(ctx->dev, "%s: sink widget=%s\n", __func__, p->sink->name);
 
-		sink = p->sink;
+		next_sink = p->sink;
 		/*
 		 * here we will check widgets in sink pipelines, so that
 		 * can be any widgets type and we are only interested if
@@ -450,7 +450,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 	}
 
 	if (!sink)
-		return skl_tplg_bind_sinks(sink, skl, src_mconfig);
+		return skl_tplg_bind_sinks(next_sink, skl, src_mconfig);
 
 	return 0;
 }
-- 
1.9.1
