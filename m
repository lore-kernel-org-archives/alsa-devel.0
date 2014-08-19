From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/13] ASoC: Consolidate CPU and CODEC DAI
	removal
Date: Tue, 19 Aug 2014 15:51:26 +0200
Message-ID: <1408456290-13945-10-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 17B1426569E
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:49 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

CPU and CODEC DAI works exactly the same way. There is already a helper function
for CODEC DAI removal, use that one as well for CPU DAI removal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 59020735..04cc3d7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1021,28 +1021,27 @@ static void soc_remove_component(struct snd_soc_component *component)
 	module_put(component->dev->driver->owner);
 }
 
-static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
+static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (codec_dai && codec_dai->probed &&
-			codec_dai->driver->remove_order == order) {
-		if (codec_dai->driver->remove) {
-			err = codec_dai->driver->remove(codec_dai);
+	if (dai && dai->probed &&
+			dai->driver->remove_order == order) {
+		if (dai->driver->remove) {
+			err = dai->driver->remove(dai);
 			if (err < 0)
-				dev_err(codec_dai->dev,
+				dev_err(dai->dev,
 					"ASoC: failed to remove %s: %d\n",
-					codec_dai->name, err);
+					dai->name, err);
 		}
-		codec_dai->probed = 0;
+		dai->probed = 0;
 	}
 }
 
 static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int i, err;
+	int i;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1054,20 +1053,9 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 
 	/* remove the CODEC DAI */
 	for (i = 0; i < rtd->num_codecs; i++)
-		soc_remove_codec_dai(rtd->codec_dais[i], order);
+		soc_remove_dai(rtd->codec_dais[i], order);
 
-	/* remove the cpu_dai */
-	if (cpu_dai && cpu_dai->probed &&
-			cpu_dai->driver->remove_order == order) {
-		if (cpu_dai->driver->remove) {
-			err = cpu_dai->driver->remove(cpu_dai);
-			if (err < 0)
-				dev_err(cpu_dai->dev,
-					"ASoC: failed to remove %s: %d\n",
-					cpu_dai->name, err);
-		}
-		cpu_dai->probed = 0;
-	}
+	soc_remove_dai(rtd->cpu_dai, order);
 }
 
 static void soc_remove_link_components(struct snd_soc_card *card, int num,
-- 
1.8.0
