From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove cache_bypass from snd_soc_codec"
	to the asoc tree
Date: Wed, 26 Jul 2017 15:17:15 +0100
Message-ID: <E1daN7j-0003aW-AL@debutante>
References: <87vamfn5pe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DAB82674B2
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:23 +0200 (CEST)
In-Reply-To: <87vamfn5pe.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove cache_bypass from snd_soc_codec

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

>From a7e1149b64091ac87dfb18b177abb63ba4cbbd3d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Jul 2017 05:17:08 +0000
Subject: [PATCH] ASoC: remove cache_bypass from snd_soc_codec

snd_soc_codec .cache_bypass related operation code has been removed.
Let's remove remaining code.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h         | 1 -
 sound/soc/codecs/max98927.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9c94b97c17f8..10b71beb9f13 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -894,7 +894,6 @@ struct snd_soc_codec {
 	struct list_head list;
 
 	/* runtime */
-	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int cache_init:1; /* codec cache has been initialized */
 
 	/* codec IO */
diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index b5ee29499e16..b0380b560bf5 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -577,7 +577,6 @@ static int max98927_probe(struct snd_soc_codec *codec)
 
 	max98927->codec = codec;
 	codec->control_data = max98927->regmap;
-	codec->cache_bypass = 1;
 
 	/* Software Reset */
 	regmap_write(max98927->regmap,
-- 
2.13.2
