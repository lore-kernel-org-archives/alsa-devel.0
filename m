From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove .delay from
	snd_soc_platform_driver" to the asoc tree
Date: Mon, 09 Jan 2017 20:01:30 +0000
Message-ID: <E1cQg8I-0006tH-RJ@debutante>
References: <878trc74nc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0D86266F0A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:38 +0100 (CET)
In-Reply-To: <878trc74nc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: remove .delay from snd_soc_platform_driver

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

>From fcff45f8e092c17d324028fb6f632fde98983f17 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Dec 2016 07:36:58 +0000
Subject: [PATCH] ASoC: remove .delay from snd_soc_platform_driver

No existing platform is using .delay.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 7 -------
 sound/soc/soc-pcm.c | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e580a675ea77..06515e5ca018 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -946,13 +946,6 @@ struct snd_soc_platform_driver {
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
-	/*
-	 * For platform caused delay reporting.
-	 * Optional.
-	 */
-	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
-		struct snd_soc_dai *);
-
 	/* platform stream pcm ops */
 	const struct snd_pcm_ops *ops;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a9ef8ae20e44..a4c93a90b8e9 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1116,13 +1116,6 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	}
 	delay += codec_delay;
 
-	/*
-	 * None of the existing platform drivers implement delay(), so
-	 * for now the codec_dai of first multicodec entry is used
-	 */
-	if (platform->driver->delay)
-		delay += platform->driver->delay(substream, rtd->codec_dais[0]);
-
 	runtime->delay = delay;
 
 	return offset;
-- 
2.11.0
