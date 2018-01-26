From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: compress: Fixup error messages
Date: Fri, 26 Jan 2018 13:08:45 +0000
Message-ID: <20180126130845.7122-3-ckeepax@opensource.cirrus.com>
References: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 987B7266C0E
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 14:08:56 +0100 (CET)
In-Reply-To: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

The error message prints are a little inconsisent, tidy them up to be a
little more consistent with current style recommendations.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-compress.c | 68 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b1cf758e3be20..82402688bd8ed 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -40,7 +40,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
 		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "Compress ASoC: can't open interface %s: %d\n",
+			dev_err(cpu_dai->dev,
+				"Compress ASoC: can't open interface %s: %d\n",
 				cpu_dai->name, ret);
 			goto out;
 		}
@@ -49,8 +50,9 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-				platform->component.name);
+			dev_err(platform->dev,
+				"Compress ASoC: can't open platform %s: %d\n",
+				platform->component.name, ret);
 			goto plat_err;
 		}
 	}
@@ -68,8 +70,9 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 
 		__ret = component->driver->compr_ops->open(cstream);
 		if (__ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-			       component->name);
+			dev_err(component->dev,
+				"Compress ASoC: can't open platform %s: %d\n",
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
@@ -79,7 +82,9 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
 		ret = rtd->dai_link->compr_ops->startup(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: %s startup failed\n", rtd->dai_link->name);
+			dev_err(rtd->dev,
+				"Compress ASoC: %s startup failed: %d\n",
+				rtd->dai_link->name, ret);
 			goto machine_err;
 		}
 	}
@@ -139,7 +144,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
 		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "Compress ASoC: can't open interface %s: %d\n",
+			dev_err(cpu_dai->dev,
+				"Compress ASoC: can't open interface %s: %d\n",
 				cpu_dai->name, ret);
 			goto out;
 		}
@@ -148,8 +154,9 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-				platform->component.name);
+			dev_err(platform->dev,
+				"Compress ASoC: can't open platform %s: %d\n",
+				platform->component.name, ret);
 			goto plat_err;
 		}
 	}
@@ -167,8 +174,9 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 		__ret = component->driver->compr_ops->open(cstream);
 		if (__ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-			       component->name);
+			dev_err(component->dev,
+				"Compress ASoC: can't open platform %s: %d\n",
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
@@ -178,7 +186,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: %s startup failed\n", fe->dai_link->name);
+			pr_err("Compress ASoC: %s startup failed: %d\n",
+			       fe->dai_link->name, ret);
 			goto machine_err;
 		}
 	}
@@ -189,7 +198,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (ret < 0)
 		goto fe_err;
 	else if (ret == 0)
-		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
+		dev_dbg(fe->dev, "Compress ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
 
 	/* calculate valid and active FE <-> BE dpcms */
@@ -264,10 +273,11 @@ static void close_delayed_work(struct work_struct *work)
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
-		 codec_dai->driver->playback.stream_name,
-		 codec_dai->playback_active ? "active" : "inactive",
-		 rtd->pop_wait ? "yes" : "no");
+	dev_dbg(rtd->dev,
+		"Compress ASoC: pop wq checking: %s status: %s waiting: %s\n",
+		codec_dai->driver->playback.stream_name,
+		codec_dai->playback_active ? "active" : "inactive",
+		rtd->pop_wait ? "yes" : "no");
 
 	/* are we waiting on this codec DAI stream */
 	if (rtd->pop_wait == 1) {
@@ -374,7 +384,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 
 	ret = dpcm_be_dai_hw_free(fe, stream);
 	if (ret < 0)
-		dev_err(fe->dev, "compressed hw_free failed %d\n", ret);
+		dev_err(fe->dev, "Compressed ASoC: hw_free failed: %d\n", ret);
 
 	ret = dpcm_be_dai_shutdown(fe, stream);
 
@@ -1105,7 +1115,8 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	int playback = 0, capture = 0;
 
 	if (rtd->num_codecs > 1) {
-		dev_err(rtd->card->dev, "Multicodec not supported for compressed stream\n");
+		dev_err(rtd->card->dev,
+			"Compress ASoC: Multicodec not supported\n");
 		return -EINVAL;
 	}
 
@@ -1123,8 +1134,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	 * should be set, check for that (xor)
 	 */
 	if (playback + capture != 1) {
-		dev_err(rtd->card->dev, "Invalid direction for compress P %d, C %d\n",
-				playback, capture);
+		dev_err(rtd->card->dev,
+			"Compress ASoC: Invalid direction for P %d, C %d\n",
+			playback, capture);
 		return -EINVAL;
 	}
 
@@ -1152,8 +1164,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 				rtd->dai_link->dpcm_playback,
 				rtd->dai_link->dpcm_capture, &be_pcm);
 		if (ret < 0) {
-			dev_err(rtd->card->dev, "ASoC: can't create compressed for %s\n",
-				rtd->dai_link->name);
+			dev_err(rtd->card->dev,
+				"Compress ASoC: can't create compressed for %s: %d\n",
+				rtd->dai_link->name, ret);
 			goto compr_err;
 		}
 
@@ -1196,8 +1209,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 				new_name, compr);
 	if (ret < 0) {
 		component = rtd->codec_dai->component;
-		pr_err("compress asoc: can't create compress for codec %s\n",
-			component->name);
+		dev_err(component->dev,
+			"Compress ASoC: can't create compress for codec %s: %d\n",
+			component->name, ret);
 		goto compr_err;
 	}
 
@@ -1207,8 +1221,8 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	rtd->compr = compr;
 	compr->private_data = rtd;
 
-	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	dev_info(rtd->card->dev, "Compress ASoC: %s <-> %s mapping ok\n",
+		 codec_dai->name, cpu_dai->name);
 	return ret;
 
 compr_err:
-- 
2.11.0
