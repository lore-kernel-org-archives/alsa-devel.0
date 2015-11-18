From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix null ptr
	dereferenced in skl_tplg_bind_sinks" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:09 +0000
Message-ID: <E1Zz7l7-0001M4-HZ@debutante>
References: <1447267609-27816-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 679BC265AEC
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:19 +0100 (CET)
In-Reply-To: <1447267609-27816-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix null ptr dereferenced in skl_tplg_bind_sinks

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

>From 0ed95d769c8d6c1030dd9f94cf6fb2a6ed98a4ce Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:11 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix null ptr dereferenced in
 skl_tplg_bind_sinks

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.2
