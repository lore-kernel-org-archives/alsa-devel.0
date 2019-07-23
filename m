From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_shutdown()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:52 +0100 (BST)
Message-ID: <20190723171852.936E92742BAB@ypsilon.sirena.org.uk>
References: <87v9vuhn4b.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D2F6F8048F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:53 +0200 (CEST)
In-Reply-To: <87v9vuhn4b.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai: add snd_soc_dai_shutdown()

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

>From 330fcb5135e0588b1ea3b0bbab587d1317c1cf7b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:33:39 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_shutdown()

Current ALSA SoC is directly using dai->driver->ops->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_shutdown() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87v9vuhn4b.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  2 ++
 sound/soc/soc-dai.c     |  7 +++++++
 sound/soc/soc-dapm.c    |  7 ++-----
 sound/soc/soc-pcm.c     | 18 ++++++------------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 0d16c5bb20bb..32545d457b3d 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -152,6 +152,8 @@ void snd_soc_dai_hw_free(struct snd_soc_dai *dai,
 			 struct snd_pcm_substream *substream);
 int snd_soc_dai_startup(struct snd_soc_dai *dai,
 			struct snd_pcm_substream *substream);
+void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
+			  struct snd_pcm_substream *substream);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 6e196636e42f..67ff6cc1fe02 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -300,3 +300,10 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
 
 	return ret;
 }
+
+void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
+			 struct snd_pcm_substream *substream)
+{
+	if (dai->driver->ops->shutdown)
+		dai->driver->ops->shutdown(substream, dai);
+}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 71bfd049480a..1d04612601ad 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3893,9 +3893,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			snd_soc_dai_hw_free(source, &substream);
 
 			source->active--;
-			if (source->driver->ops->shutdown)
-				source->driver->ops->shutdown(&substream,
-							      source);
+			snd_soc_dai_shutdown(source, &substream);
 		}
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -3905,8 +3903,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			snd_soc_dai_hw_free(sink, &substream);
 
 			sink->active--;
-			if (sink->driver->ops->shutdown)
-				sink->driver->ops->shutdown(&substream, sink);
+			snd_soc_dai_shutdown(sink, &substream);
 		}
 		break;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9c8713a3eef1..ed5ae23c7104 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -641,16 +641,13 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	i = rtd->num_codecs;
 
 codec_dai_err:
-	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
-		if (codec_dai->driver->ops->shutdown)
-			codec_dai->driver->ops->shutdown(substream, codec_dai);
-	}
+	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai)
+		snd_soc_dai_shutdown(codec_dai, substream);
 
 component_err:
 	soc_pcm_components_close(substream, component);
 
-	if (cpu_dai->driver->ops->shutdown)
-		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
+	snd_soc_dai_shutdown(cpu_dai, substream);
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 
@@ -728,13 +725,10 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
 
-	if (cpu_dai->driver->ops->shutdown)
-		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
+	snd_soc_dai_shutdown(cpu_dai, substream);
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (codec_dai->driver->ops->shutdown)
-			codec_dai->driver->ops->shutdown(substream, codec_dai);
-	}
+	for_each_rtd_codec_dai(rtd, i, codec_dai)
+		snd_soc_dai_shutdown(codec_dai, substream);
 
 	if (rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
-- 
2.20.1
