From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: reduce if/else nest on
	soc_probe_link_dais" to the asoc tree
Date: Mon, 21 Jan 2019 19:20:24 +0000 (GMT)
Message-ID: <20190121192024.5A27F1127D00@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 039F3267466
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:25 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: reduce if/else nest on soc_probe_link_dais

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

>From 52293596f5afff10d14e033aa3edfc801a31b3a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 09:32:50 +0900
Subject: [PATCH] ASoC: soc-core: reduce if/else nest on soc_probe_link_dais

Deep nested codec is not readable.
Let's reduce if/else nest.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d59b5ea9fa25..7fc10a41e0e9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1612,27 +1612,24 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 					 dai_link->stream_name);
 			return ret;
 		}
-	} else {
-
-		if (!dai_link->params) {
-			/* create the pcm */
-			ret = soc_new_pcm(rtd, num);
-			if (ret < 0) {
-				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
-					dai_link->stream_name, ret);
-				return ret;
-			}
-			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
-			if (ret < 0)
-				return ret;
-			ret = soc_link_dai_pcm_new(rtd->codec_dais,
-						   rtd->num_codecs, rtd);
-			if (ret < 0)
-				return ret;
-		} else {
-			INIT_DELAYED_WORK(&rtd->delayed_work,
-						codec2codec_close_delayed_work);
+	} else if (!dai_link->params) {
+		/* create the pcm */
+		ret = soc_new_pcm(rtd, num);
+		if (ret < 0) {
+			dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
+				dai_link->stream_name, ret);
+			return ret;
 		}
+		ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+		if (ret < 0)
+			return ret;
+		ret = soc_link_dai_pcm_new(rtd->codec_dais,
+					   rtd->num_codecs, rtd);
+		if (ret < 0)
+			return ret;
+	} else {
+		INIT_DELAYED_WORK(&rtd->delayed_work,
+				  codec2codec_close_delayed_work);
 	}
 
 	return 0;
-- 
2.20.1
