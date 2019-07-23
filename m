From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_probe()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:51 +0100 (BST)
Message-ID: <20190723171851.2A6FA2742B60@ypsilon.sirena.org.uk>
References: <87k1cahn26.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8BCCF8045D
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87k1cahn26.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai: add snd_soc_dai_probe()

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

>From cfd9b5fbfe1e8763018aea2600aa0d6ff015ebfc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:34:56 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_probe()

Current ALSA SoC is directly using dai->driver->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_probe() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87k1cahn26.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  1 +
 sound/soc/soc-core.c    | 15 +++++++--------
 sound/soc/soc-dai.c     |  7 +++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ed78e34a814e..da8d8b889089 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -164,6 +164,7 @@ snd_pcm_sframes_t snd_soc_dai_delay(struct snd_soc_dai *dai,
 				    struct snd_pcm_substream *substream);
 void snd_soc_dai_suspend(struct snd_soc_dai *dai);
 void snd_soc_dai_resume(struct snd_soc_dai *dai);
+int snd_soc_dai_probe(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5c02f90cea69..3e73468225f9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1434,18 +1434,17 @@ static int soc_probe_link_components(struct snd_soc_card *card,
 
 static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 {
+	int ret;
+
 	if (dai->probed ||
 	    dai->driver->probe_order != order)
 		return 0;
 
-	if (dai->driver->probe) {
-		int ret = dai->driver->probe(dai);
-
-		if (ret < 0) {
-			dev_err(dai->dev, "ASoC: failed to probe DAI %s: %d\n",
-				dai->name, ret);
-			return ret;
-		}
+	ret = snd_soc_dai_probe(dai);
+	if (ret < 0) {
+		dev_err(dai->dev, "ASoC: failed to probe DAI %s: %d\n",
+			dai->name, ret);
+		return ret;
 	}
 
 	dai->probed = 1;
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index ddb6f217c0ed..55c1fac99613 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -365,3 +365,10 @@ void snd_soc_dai_resume(struct snd_soc_dai *dai)
 	if (dai->driver->resume)
 		dai->driver->resume(dai);
 }
+
+int snd_soc_dai_probe(struct snd_soc_dai *dai)
+{
+	if (dai->driver->probe)
+		return dai->driver->probe(dai);
+	return 0;
+}
-- 
2.20.1
