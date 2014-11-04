From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Consolidate CPU and CODEC DAI probe
Date: Tue,  4 Nov 2014 11:30:59 +0100
Message-ID: <1415097059-14551-2-git-send-email-lars@metafoo.de>
References: <1415097059-14551-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-048.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B8C22614F4
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:31:05 +0100 (CET)
In-Reply-To: <1415097059-14551-1-git-send-email-lars@metafoo.de>
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

CPU and CODEC DAI probe are performed in exactly the same way. Which means
we can reuse the snd_soc_codec_dai_probe() for probing CPU DAIs as well.

While we are at it also drop the unused card parameter form the function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d9b7b70..333f112 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1241,25 +1241,22 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	return 0;
 }
 
-static int soc_probe_codec_dai(struct snd_soc_card *card,
-			       struct snd_soc_dai *codec_dai,
-			       int order)
+static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 {
 	int ret;
 
-	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
-		if (codec_dai->driver->probe) {
-			ret = codec_dai->driver->probe(codec_dai);
+	if (!dai->probed && dai->driver->probe_order == order) {
+		if (dai->driver->probe) {
+			ret = dai->driver->probe(dai);
 			if (ret < 0) {
-				dev_err(codec_dai->dev,
-					"ASoC: failed to probe CODEC DAI %s: %d\n",
-					codec_dai->name, ret);
+				dev_err(dai->dev,
+					"ASoC: failed to probe DAI %s: %d\n",
+					dai->name, ret);
 				return ret;
 			}
 		}
 
-		/* mark codec_dai as probed and add to card dai list */
-		codec_dai->probed = 1;
+		dai->probed = 1;
 	}
 
 	return 0;
@@ -1318,24 +1315,13 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
 
-	/* probe the cpu_dai */
-	if (!cpu_dai->probed &&
-			cpu_dai->driver->probe_order == order) {
-		if (cpu_dai->driver->probe) {
-			ret = cpu_dai->driver->probe(cpu_dai);
-			if (ret < 0) {
-				dev_err(cpu_dai->dev,
-					"ASoC: failed to probe CPU DAI %s: %d\n",
-					cpu_dai->name, ret);
-				return ret;
-			}
-		}
-		cpu_dai->probed = 1;
-	}
+	ret = soc_probe_dai(cpu_dai, order);
+	if (ret)
+		return ret;
 
 	/* probe the CODEC DAI */
 	for (i = 0; i < rtd->num_codecs; i++) {
-		ret = soc_probe_codec_dai(card, rtd->codec_dais[i], order);
+		ret = soc_probe_dai(rtd->codec_dais[i], order);
 		if (ret)
 			return ret;
 	}
-- 
1.8.0
