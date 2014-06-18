From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: core: refine of node id parse of
	cpu/codec dai
Date: Wed, 18 Jun 2014 19:01:59 +0800
Message-ID: <1403089319-2555-2-git-send-email-zhouqiao@marvell.com>
References: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 065D0261735
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 13:02:06 +0200 (CEST)
In-Reply-To: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, zhangfei.gao@gmail.com, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

refine cpu_dai/codec_dai of_node checking by checking either name
or dai_id matches.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   32 +++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7..782f7a0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -888,12 +888,14 @@ struct snd_soc_dai_link {
 	 * only, which only works well when that device exposes a single DAI.
 	 */
 	const char *cpu_dai_name;
+	unsigned int cpu_dai_id;
 	/*
 	 * You MUST specify the link's codec, either by device name, or by
 	 * DT/OF node, but not both.
 	 */
 	const char *codec_name;
 	const struct device_node *codec_of_node;
+	unsigned int codec_dai_id;
 	/* You MUST specify the DAI name within the codec */
 	const char *codec_dai_name;
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b87d7d8..777237d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -868,14 +868,16 @@ static struct snd_soc_codec *soc_find_codec(const struct device_node *codec_of_n
 }
 
 static struct snd_soc_dai *soc_find_codec_dai(struct snd_soc_codec *codec,
-					      const char *codec_dai_name)
+					      struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai *codec_dai;
 
 	list_for_each_entry(codec_dai, &codec->component.dai_list, list) {
-		if (!strcmp(codec_dai->name, codec_dai_name)) {
+		if (dai_link->codec_dai_name
+		    && !strcmp(codec_dai->name, dai_link->codec_dai_name))
+			return codec_dai;
+		else if (codec_dai->id == dai_link->codec_dai_id)
 			return codec_dai;
-		}
 	}
 
 	return NULL;
@@ -904,6 +906,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 			if (dai_link->cpu_dai_name &&
 				strcmp(cpu_dai->name, dai_link->cpu_dai_name))
 				continue;
+			if (!dai_link->cpu_dai_name &&
+				cpu_dai->id != dai_link->cpu_dai_id)
+				continue;
 
 			rtd->cpu_dai = cpu_dai;
 		}
@@ -919,17 +924,26 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	rtd->codec = soc_find_codec(dai_link->codec_of_node,
 				    dai_link->codec_name);
 	if (!rtd->codec) {
-		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
-			dai_link->codec_name);
+		if (dai_link->codec_name)
+			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
+				dai_link->codec_name);
+		else if (dai_link->codec_of_node)
+			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
+				dai_link->codec_of_node->name);
 		return -EPROBE_DEFER;
 	}
 
 	/* Find CODEC DAI from registered list */
-	rtd->codec_dai = soc_find_codec_dai(rtd->codec,
-					    dai_link->codec_dai_name);
+	rtd->codec_dai = soc_find_codec_dai(rtd->codec, dai_link);
 	if (!rtd->codec_dai) {
-		dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-			dai_link->codec_dai_name);
+		if (dai_link->codec_dai_name)
+			dev_err(card->dev,
+				"ASoC: CODEC DAI %s not registered\n",
+				dai_link->codec_dai_name);
+		else
+			dev_err(card->dev,
+				"ASoC: CODEC DAI %d not registered\n",
+				dai_link->codec_dai_id);
 		return -EPROBE_DEFER;
 	}
 
-- 
1.7.9.5
