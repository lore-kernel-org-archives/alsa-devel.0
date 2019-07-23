From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_delay()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:51 +0100 (BST)
Message-ID: <20190723171851.BD6DA2742BAB@ypsilon.sirena.org.uk>
References: <87o91mhn3i.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9C86F80482
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87o91mhn3i.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai: add snd_soc_dai_delay()

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

>From 1dea80d4b2bd3b53c58f008ca2bcd73182583711 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:34:09 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_delay()

Current ALSA SoC is directly using dai->driver->ops->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_delay() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87o91mhn3i.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  2 ++
 sound/soc/soc-dai.c     | 11 +++++++++++
 sound/soc/soc-pcm.c     |  9 +++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 6a5566d459ad..7cfed3034511 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -160,6 +160,8 @@ int snd_soc_dai_trigger(struct snd_soc_dai *dai,
 			struct snd_pcm_substream *substream, int cmd);
 int snd_soc_dai_bespoke_trigger(struct snd_soc_dai *dai,
 			struct snd_pcm_substream *substream, int cmd);
+snd_pcm_sframes_t snd_soc_dai_delay(struct snd_soc_dai *dai,
+				    struct snd_pcm_substream *substream);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 6f466cfcbeef..5b5b979cd1f3 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -342,3 +342,14 @@ int snd_soc_dai_bespoke_trigger(struct snd_soc_dai *dai,
 
 	return ret;
 }
+
+snd_pcm_sframes_t snd_soc_dai_delay(struct snd_soc_dai *dai,
+				    struct snd_pcm_substream *substream)
+{
+	int delay = 0;
+
+	if (dai->driver->ops->delay)
+		delay = dai->driver->ops->delay(substream, dai);
+
+	return delay;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a10627f1ceff..f3137723301c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1169,14 +1169,11 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	/* base delay if assigned in pointer callback */
 	delay = runtime->delay;
 
-	if (cpu_dai->driver->ops->delay)
-		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
+	delay += snd_soc_dai_delay(cpu_dai, substream);
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (codec_dai->driver->ops->delay)
-			codec_delay = max(codec_delay,
-					codec_dai->driver->ops->delay(substream,
-								    codec_dai));
+		codec_delay = max(codec_delay,
+				  snd_soc_dai_delay(codec_dai, substream));
 	}
 	delay += codec_delay;
 
-- 
2.20.1
