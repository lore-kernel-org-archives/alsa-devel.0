From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove .bespoke_trigger from
	snd_soc_platform_driver" to the asoc tree
Date: Mon, 09 Jan 2017 20:01:27 +0000
Message-ID: <E1cQg8F-0006sT-S1@debutante>
References: <877f6w74mu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCB1266EE9
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:35 +0100 (CET)
In-Reply-To: <877f6w74mu.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove .bespoke_trigger from snd_soc_platform_driver

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

>From 10611e1b0b7ab2a82dd7838e5e928fa1501d353c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Dec 2016 07:37:18 +0000
Subject: [PATCH] ASoC: remove .bespoke_trigger from snd_soc_platform_driver

No existing platform is using .bespoke_trigger.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 --
 sound/soc/soc-pcm.c | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 06515e5ca018..1a4311da6126 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -951,8 +951,6 @@ struct snd_soc_platform_driver {
 
 	/* platform stream compress ops */
 	const struct snd_compr_ops *compr_ops;
-
-	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
 struct snd_soc_dai_link_component {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a4c93a90b8e9..1739573dcd6a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1055,7 +1055,6 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 				   int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret;
@@ -1071,12 +1070,6 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (platform->driver->bespoke_trigger) {
-		ret = platform->driver->bespoke_trigger(substream, cmd);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->bespoke_trigger) {
 		ret = cpu_dai->driver->ops->bespoke_trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
-- 
2.11.0
