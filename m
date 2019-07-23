From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add
	snd_soc_dai_compress_new()" to the asoc tree
Date: Tue, 23 Jul 2019 18:18:50 +0100 (BST)
Message-ID: <20190723171850.B859C2742BAB@ypsilon.sirena.org.uk>
References: <87h87ehn1a.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0444AF80481
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87h87ehn1a.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai: add snd_soc_dai_compress_new()

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

>From b423c4202135f7794e0a9c55a884f5933d8e7156 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:35:29 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_compress_new()

Current ALSA SoC is directly using dai->driver->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_compress_new() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87h87ehn1a.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  2 ++
 sound/soc/soc-core.c    | 15 ++++++++-------
 sound/soc/soc-dai.c     |  8 ++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2a11f177ce01..0f8b09520020 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -166,6 +166,8 @@ void snd_soc_dai_suspend(struct snd_soc_dai *dai);
 void snd_soc_dai_resume(struct snd_soc_dai *dai);
 int snd_soc_dai_probe(struct snd_soc_dai *dai);
 int snd_soc_dai_remove(struct snd_soc_dai *dai);
+int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
+			     struct snd_soc_pcm_runtime *rtd, int num);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 727fd342b3fb..458b090f026a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1545,15 +1545,16 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 			num = rtd->dai_link->id;
 	}
 
-	if (cpu_dai->driver->compress_new) {
-		/* create compress_device" */
-		ret = cpu_dai->driver->compress_new(rtd, num);
-		if (ret < 0) {
+	/* create compress_device if possible */
+	ret = snd_soc_dai_compress_new(cpu_dai, rtd, num);
+	if (ret != -ENOTSUPP) {
+		if (ret < 0)
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
-			return ret;
-		}
-	} else if (!dai_link->params) {
+		return ret;
+	}
+
+	if (!dai_link->params) {
 		/* create the pcm */
 		ret = soc_new_pcm(rtd, num);
 		if (ret < 0) {
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 384765c747da..e6f161b9f975 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -379,3 +379,11 @@ int snd_soc_dai_remove(struct snd_soc_dai *dai)
 		return dai->driver->remove(dai);
 	return 0;
 }
+
+int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
+			     struct snd_soc_pcm_runtime *rtd, int num)
+{
+	if (dai->driver->compress_new)
+		return dai->driver->compress_new(rtd, num);
+	return -ENOTSUPP;
+}
-- 
2.20.1
