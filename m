From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to correct check
	for non DSP widget" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:40 +0900
Message-ID: <E1ZqwCa-0004y2-Bu@finisterre>
References: <1445905380-18167-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 296412658F9
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:50 +0100 (CET)
In-Reply-To: <1445905380-18167-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to correct check for non DSP widget

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

>From 7b83ff3806f9f23cfd0dbe6162ac72e920460cf5 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:44 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix to correct check for non DSP widget

To get the FE copier module, the check to ignore non DSP widgets
was wrong. This path corrects the check to ignore non DSP widget.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a7854c8..98ccd42 100644
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
2.6.1
