From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_prepare()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:52 +0100 (BST)
Message-ID: <20190723171852.626CC2742BAC@ypsilon.sirena.org.uk>
References: <87tvbehn46.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BAE8F8048D
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:53 +0200 (CEST)
In-Reply-To: <87tvbehn46.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dai: add snd_soc_dai_prepare()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 4beb8e109d30d339d44308a767dd6f5614492f3e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:33:45 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_prepare()

Current ALSA SoC is directly using dai->driver->ops->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_prepare() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87tvbehn46.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  2 ++
 sound/soc/soc-dai.c     | 11 +++++++++++
 sound/soc/soc-pcm.c     | 27 +++++++++++----------------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 32545d457b3d..c7dff6a0b5b9 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -154,6 +154,8 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
 			struct snd_pcm_substream *substream);
 void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 			  struct snd_pcm_substream *substream);
+int snd_soc_dai_prepare(struct snd_soc_dai *dai,
+			struct snd_pcm_substream *substream);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 67ff6cc1fe02..cb810888c563 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -307,3 +307,14 @@ void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 	if (dai->driver->ops->shutdown)
 		dai->driver->ops->shutdown(substream, dai);
 }
+
+int snd_soc_dai_prepare(struct snd_soc_dai *dai,
+			struct snd_pcm_substream *substream)
+{
+	int ret = 0;
+
+	if (dai->driver->ops->prepare)
+		ret = dai->driver->ops->prepare(substream, dai);
+
+	return ret;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ed5ae23c7104..d7611af90dce 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -814,27 +814,22 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (codec_dai->driver->ops->prepare) {
-			ret = codec_dai->driver->ops->prepare(substream,
-							      codec_dai);
-			if (ret < 0) {
-				dev_err(codec_dai->dev,
-					"ASoC: codec DAI prepare error: %d\n",
-					ret);
-				goto out;
-			}
-		}
-	}
-
-	if (cpu_dai->driver->ops->prepare) {
-		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
+		ret = snd_soc_dai_prepare(codec_dai, substream);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev,
-				"ASoC: cpu DAI prepare error: %d\n", ret);
+			dev_err(codec_dai->dev,
+				"ASoC: codec DAI prepare error: %d\n",
+				ret);
 			goto out;
 		}
 	}
 
+	ret = snd_soc_dai_prepare(cpu_dai, substream);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev,
+			"ASoC: cpu DAI prepare error: %d\n", ret);
+		goto out;
+	}
+
 	/* cancel any delayed stream shutdown that is pending */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    rtd->pop_wait) {
-- 
2.20.1
