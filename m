From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/9] ASoC: Intel: Skylake: Fix to use correct
	macros for the path iteration
Date: Thu, 22 Oct 2015 23:22:36 +0530
Message-ID: <1445536362-26670-4-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E363B260542
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:07 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

In case of playback, for the BE dai source path should be iterated to find
the pipe params. With sink path iterated, this resulted in a loop and kernel
panic with page request failure.
Similar are the cases for Capture and FE dais. Using correct macros to fix
the panic

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7c920857007e..0fba39dcb2ab 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -844,7 +844,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		w = dai->playback_widget;
-		snd_soc_dapm_widget_for_each_source_path(w, p) {
+		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->connect && p->sink->power &&
 					is_skl_dsp_widget_type(p->sink))
 				continue;
@@ -857,7 +857,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 		}
 	} else {
 		w = dai->capture_widget;
-		snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->connect && p->source->power &&
 					is_skl_dsp_widget_type(p->source))
 				continue;
@@ -945,7 +945,7 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 {
 	struct snd_soc_dapm_path *p;
 
-	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
 		if (p->connect && is_skl_dsp_widget_type(p->source) &&
 						p->source->priv) {
 
@@ -969,7 +969,7 @@ static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 {
 	struct snd_soc_dapm_path *p = NULL;
 
-	snd_soc_dapm_widget_for_each_source_path(w, p) {
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
 		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
 						p->sink->priv) {
 
-- 
1.9.1
