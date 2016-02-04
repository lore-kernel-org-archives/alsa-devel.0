From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix bind of source with
	multiple sinks" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:11 +0000
Message-ID: <E1aRIpX-0001CB-Ps@debutante>
References: <1454502594-21700-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0959261583
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:17 +0100 (CET)
In-Reply-To: <1454502594-21700-9-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix bind of source with multiple sinks

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

>From 6bd4cf855698312133b7776c77ee78af865608eb Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 3 Feb 2016 17:59:51 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix bind of source with multiple sinks

skl_tplg_bind_sinks() takes only the first sink widget. This
breaks in case we have multiple sinks for a module.

So pass source widget to skl_tplg_bind_sinks() and bind for all
sinks by calling this recursively

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a356f3b1dd5b..77a688d00fc6 100644
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
2.7.0.rc3
