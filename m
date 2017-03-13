From: jeeja.kp@intel.com
Subject: [PATCH V2 02/10] ASoC: Intel: Skylake: Fix not to stop
	src pipe in pre pmd event handler
Date: Mon, 13 Mar 2017 22:11:24 +0530
Message-ID: <1489423292-19997-3-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9DA266CAF
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:29:35 +0100 (CET)
In-Reply-To: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, Guneshwor Singh <guneshwor.o.singh@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

If the widget is a mixin module, just unbind between source and sink
and don't stop the source pipe as there can be multiple sinks
connected.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index f38f8e6..f04a251 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -975,15 +975,6 @@ static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
 			src_mconfig = sink_mconfig->m_in_pin[i].tgt_mcfg;
 			if (!src_mconfig)
 				continue;
-			/*
-			 * If path_found == 1, that means pmd for source
-			 * pipe has not occurred, source is connected to
-			 * some other sink. so its responsibility of sink
-			 * to unbind itself from source.
-			 */
-			ret = skl_stop_pipe(ctx, src_mconfig->pipe);
-			if (ret < 0)
-				return ret;
 
 			ret = skl_unbind_modules(ctx,
 						src_mconfig, sink_mconfig);
-- 
2.5.0
