From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/17] ASoC: Intel: Skylake: Fix to correct
	check for non DSP widget
Date: Tue, 27 Oct 2015 09:22:44 +0900
Message-ID: <1445905380-18167-2-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EF9D12651E3
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:13 +0100 (CET)
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

To get the FE copier module, the check to ignore non DSP widgets
was wrong. This path corrects the check to ignore non DSP widget.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a7854c8fc523..98ccd42b8867 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -846,7 +846,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 		w = dai->playback_widget;
 		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->connect && p->sink->power &&
-					is_skl_dsp_widget_type(p->sink))
+					!is_skl_dsp_widget_type(p->sink))
 				continue;
 
 			if (p->sink->priv) {
@@ -859,7 +859,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->connect && p->source->power &&
-					is_skl_dsp_widget_type(p->source))
+					!is_skl_dsp_widget_type(p->source))
 				continue;
 
 			if (p->source->priv) {
-- 
2.4.3
