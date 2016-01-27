From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-saif: fix clk_prepare() without
	matching clk_unprepare()" to the asoc tree
Date: Wed, 27 Jan 2016 18:37:25 +0000
Message-ID: <E1aOUy5-000866-HG@debutante>
References: <1453388156-1901-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B0D5265290
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:33 +0100 (CET)
In-Reply-To: <1453388156-1901-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans@mansr.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mxs-saif: fix clk_prepare() without matching clk_unprepare()

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

>From f212c6d8c2b21c1e1d0158d38a7c37f4427f3848 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Thu, 21 Jan 2016 14:55:56 +0000
Subject: [PATCH] ASoC: mxs-saif: fix clk_prepare() without matching
 clk_unprepare()

The clk_prepare() call in hw_params() has no matching clk_unprepare(),
leaving the clk with an ever-increasing prepare count.  Moreover,
hw_params() can be called multiple times which would again leave us
with a runaway prepare count.  Fix this by moving the clk_prepare()
call to the startup() function and adding a shutdown() function with
a matching clk_unprepare() as these operations are already correctly
bracketed by soc-core.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c866ade28ad0..a6c7b8d87cd2 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -381,9 +381,19 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 	__raw_writel(BM_SAIF_CTRL_CLKGATE,
 		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 
+	clk_prepare(saif->clk);
+
 	return 0;
 }
 
+static void mxs_saif_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
+{
+	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+
+	clk_unprepare(saif->clk);
+}
+
 /*
  * Should only be called when port is inactive.
  * although can be called multiple times by upper layers.
@@ -424,8 +434,6 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* prepare clk in hw_param, enable in trigger */
-	clk_prepare(saif->clk);
 	if (saif != master_saif) {
 		/*
 		* Set an initial clock rate for the saif internal logic to work
@@ -611,6 +619,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static const struct snd_soc_dai_ops mxs_saif_dai_ops = {
 	.startup = mxs_saif_startup,
+	.shutdown = mxs_saif_shutdown,
 	.trigger = mxs_saif_trigger,
 	.prepare = mxs_saif_prepare,
 	.hw_params = mxs_saif_hw_params,
-- 
2.7.0.rc3
