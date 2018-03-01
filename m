From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Refine skl widget type
	check" to the asoc tree
Date: Thu, 01 Mar 2018 19:42:19 +0000
Message-ID: <E1erU5r-0003Rf-P9@debutante>
References: <20180127042025.22042-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A6E03267BD0
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:42:22 +0100 (CET)
In-Reply-To: <20180127042025.22042-2-guneshwor.o.singh@intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Refine skl widget type check

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cb1f904d91c52bc4e03e11eb161288c40c655095 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Sat, 27 Jan 2018 09:50:21 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Refine skl widget type check

The current check is not effective when all the widgets of a card are
involved since other widgets also can be of same type. So, make widget
type check more stringent by checking dev pointer additionally.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 73af6e19ebbd..dbe6a19b84f5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -94,8 +94,12 @@ void skl_tplg_d0i3_put(struct skl *skl, enum d0i3_capability caps)
  * SKL DSP driver modelling uses only few DAPM widgets so for rest we will
  * ignore. This helpers checks if the SKL driver handles this widget type
  */
-static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w)
+static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w,
+				  struct device *dev)
 {
+	if (w->dapm->dev != dev)
+		return false;
+
 	switch (w->id) {
 	case snd_soc_dapm_dai_link:
 	case snd_soc_dapm_dai_in:
@@ -969,7 +973,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 
 		next_sink = p->sink;
 
-		if (!is_skl_dsp_widget_type(p->sink))
+		if (!is_skl_dsp_widget_type(p->sink, ctx->dev))
 			return skl_tplg_bind_sinks(p->sink, skl, src_w, src_mconfig);
 
 		/*
@@ -978,7 +982,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 		 * they are ones used for SKL so check that first
 		 */
 		if ((p->sink->priv != NULL) &&
-					is_skl_dsp_widget_type(p->sink)) {
+				is_skl_dsp_widget_type(p->sink, ctx->dev)) {
 
 			sink = p->sink;
 			sink_mconfig = sink->priv;
@@ -1092,7 +1096,7 @@ static struct snd_soc_dapm_widget *skl_get_src_dsp_widget(
 		 * ones used for SKL so check that first
 		 */
 		if ((p->source->priv != NULL) &&
-					is_skl_dsp_widget_type(p->source)) {
+				is_skl_dsp_widget_type(p->source, ctx->dev)) {
 			return p->source;
 		}
 	}
@@ -1654,7 +1658,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 		w = dai->playback_widget;
 		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->connect && p->sink->power &&
-					!is_skl_dsp_widget_type(p->sink))
+				!is_skl_dsp_widget_type(p->sink, dai->dev))
 				continue;
 
 			if (p->sink->priv) {
@@ -1667,7 +1671,7 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->connect && p->source->power &&
-					!is_skl_dsp_widget_type(p->source))
+				!is_skl_dsp_widget_type(p->source, dai->dev))
 				continue;
 
 			if (p->source->priv) {
@@ -1819,7 +1823,7 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 	int ret = -EIO;
 
 	snd_soc_dapm_widget_for_each_source_path(w, p) {
-		if (p->connect && is_skl_dsp_widget_type(p->source) &&
+		if (p->connect && is_skl_dsp_widget_type(p->source, dai->dev) &&
 						p->source->priv) {
 
 			ret = skl_tplg_be_fill_pipe_params(dai,
@@ -1844,7 +1848,7 @@ static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 	int ret = -EIO;
 
 	snd_soc_dapm_widget_for_each_sink_path(w, p) {
-		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
+		if (p->connect && is_skl_dsp_widget_type(p->sink, dai->dev) &&
 						p->sink->priv) {
 
 			ret = skl_tplg_be_fill_pipe_params(dai,
@@ -2752,7 +2756,7 @@ void skl_cleanup_resources(struct skl *skl)
 	skl->resource.mcps = 0;
 
 	list_for_each_entry(w, &card->widgets, list) {
-		if (is_skl_dsp_widget_type(w) && (w->priv != NULL))
+		if (is_skl_dsp_widget_type(w, ctx->dev) && w->priv != NULL)
 			skl_clear_pin_config(soc_platform, w);
 	}
 
@@ -3408,7 +3412,7 @@ static int skl_tplg_create_pipe_widget_list(struct snd_soc_platform *platform)
 	struct skl_pipe *pipe;
 
 	list_for_each_entry(w, &platform->component.card->widgets, list) {
-		if (is_skl_dsp_widget_type(w) && w->priv != NULL) {
+		if (is_skl_dsp_widget_type(w, platform->dev) && w->priv) {
 			mcfg = w->priv;
 			pipe = mcfg->pipe;
 
-- 
2.16.2
