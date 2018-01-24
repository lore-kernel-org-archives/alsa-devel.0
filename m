From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: rename .pmdown_time to
	.use_pmdown_time for Component" to the asoc tree
Date: Wed, 24 Jan 2018 16:52:33 +0000
Message-ID: <E1eeOHp-00005L-Tp@debutante>
References: <87shb2e86z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF6AA266A74
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 17:52:39 +0100 (CET)
In-Reply-To: <87shb2e86z.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: rename .pmdown_time to .use_pmdown_time for Component

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

>From 72c3818411e5418834472e3edadcf04cfacb1274 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Jan 2018 05:21:19 +0000
Subject: [PATCH] ASoC: soc-pcm: rename .pmdown_time to .use_pmdown_time for
 Component

commit fbb16563c6c2 ("ASoC: snd_soc_component_driver has pmdown_time")
added new .pmdown_time which is for inverted version of current
.ignore_pmdown_time
But it is confusable name. Let's rename it to .use_pmdown_time

Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 sound/soc/soc-pcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1a7323238c49..812ae4faf559 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -836,7 +836,7 @@ struct snd_soc_component_driver {
 	/* bits */
 	unsigned int idle_bias_on:1;
 	unsigned int suspend_bias_off:1;
-	unsigned int pmdown_time:1; /* care pmdown_time at stop */
+	unsigned int use_pmdown_time:1; /* care pmdown_time at stop */
 	unsigned int endianness:1;
 	unsigned int non_legacy_dai_naming:1;
 };
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8075856668c2..bce0741dab04 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -144,7 +144,7 @@ bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
-		ignore &= !component->driver->pmdown_time;
+		ignore &= !component->driver->use_pmdown_time;
 	}
 
 	/* this will be removed */
-- 
2.15.1
