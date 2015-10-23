From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to use correct
	macros for the path iteration" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:48 +0900
Message-ID: <E1ZpgRQ-0006VR-13@finisterre>
References: <1445536362-26670-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BC032651B7
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:57 +0200 (CEST)
In-Reply-To: <1445536362-26670-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to use correct macros for the path iteration

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

>From f0900eb213e0f6f37e1567531f9604b9bed6771d Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 22 Oct 2015 23:22:36 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to use correct macros for the path
 iteration

In case of playback, for the BE dai source path should be iterated to find
the pipe params. With sink path iterated, this resulted in a loop and kernel
panic with page request failure.
Similar are the cases for Capture and FE dais. Using correct macros to fix
the panic

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7c92085..0fba39d 100644
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
2.6.1
