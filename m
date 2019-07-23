From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_trigger()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:52 +0100 (BST)
Message-ID: <20190723171852.2F6182742B60@ypsilon.sirena.org.uk>
References: <87sgqyhn40.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72400F80483
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87sgqyhn40.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai: add snd_soc_dai_trigger()

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

>From 95aef35533844f35544851b0cdc1fc154b603307 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:33:51 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_trigger()

Current ALSA SoC is directly using dai->driver->ops->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_trigger() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87sgqyhn40.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  2 ++
 sound/soc/soc-dai.c     | 12 ++++++++++++
 sound/soc/soc-pcm.c     | 17 ++++++-----------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index c7dff6a0b5b9..72b8e76f1cc4 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -156,6 +156,8 @@ void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 			  struct snd_pcm_substream *substream);
 int snd_soc_dai_prepare(struct snd_soc_dai *dai,
 			struct snd_pcm_substream *substream);
+int snd_soc_dai_trigger(struct snd_soc_dai *dai,
+			struct snd_pcm_substream *substream, int cmd);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index cb810888c563..18c447e169f6 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -318,3 +318,15 @@ int snd_soc_dai_prepare(struct snd_soc_dai *dai,
 
 	return ret;
 }
+
+int snd_soc_dai_trigger(struct snd_soc_dai *dai,
+			struct snd_pcm_substream *substream,
+			int cmd)
+{
+	int ret = 0;
+
+	if (dai->driver->ops->trigger)
+		ret = dai->driver->ops->trigger(substream, cmd, dai);
+
+	return ret;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d7611af90dce..a628b08f966e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1084,12 +1084,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	int i, ret;
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (codec_dai->driver->ops->trigger) {
-			ret = codec_dai->driver->ops->trigger(substream,
-							      cmd, codec_dai);
-			if (ret < 0)
-				return ret;
-		}
+		ret = snd_soc_dai_trigger(codec_dai, substream, cmd);
+		if (ret < 0)
+			return ret;
 	}
 
 	for_each_rtdcom(rtd, rtdcom) {
@@ -1104,11 +1101,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	if (cpu_dai->driver->ops->trigger) {
-		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
-		if (ret < 0)
-			return ret;
-	}
+	snd_soc_dai_trigger(cpu_dai, substream, cmd);
+	if (ret < 0)
+		return ret;
 
 	if (rtd->dai_link->ops->trigger) {
 		ret = rtd->dai_link->ops->trigger(substream, cmd);
-- 
2.20.1
