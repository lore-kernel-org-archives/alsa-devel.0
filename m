From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] ASoC: soc-pcm: Add some spaces for better
 code readability
Date: Sun, 19 Nov 2017 21:22:52 +0100
Message-ID: <7d8de535-d0fa-57cd-911b-25f3b97d8fc2@users.sourceforge.net>
References: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id F32C0266F35
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 21:22:59 +0100 (CET)
In-Reply-To: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 21:00:13 +0100

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-pcm.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dc1b984bd68e..fa2f7ccceacf 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -982,7 +982,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 						   codec_dai->rx_mask);
 
 		ret = soc_dai_hw_params(substream, &codec_params, codec_dai);
-		if(ret < 0)
+		if (ret < 0)
 			goto codec_err;
 
 		codec_dai->rate = params_rate(&codec_params);
@@ -1903,7 +1903,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 
 	ret = dpcm_be_dai_startup(fe, fe_substream->stream);
 	if (ret < 0) {
-		dev_err(fe->dev,"ASoC: failed to start some BEs %d\n", ret);
+		dev_err(fe->dev, "ASoC: failed to start some BEs %d\n", ret);
 		goto be_err;
 	}
 
@@ -1912,7 +1912,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	/* start the DAI frontend */
 	ret = soc_pcm_open(fe_substream);
 	if (ret < 0) {
-		dev_err(fe->dev,"ASoC: failed to start FE %d\n", ret);
+		dev_err(fe->dev, "ASoC: failed to start FE %d\n", ret);
 		goto unwind;
 	}
 
@@ -2055,7 +2055,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	/* call hw_free on the frontend */
 	err = soc_pcm_hw_free(substream);
 	if (err < 0)
-		dev_err(fe->dev,"ASoC: hw_free FE %s failed\n",
+		dev_err(fe->dev, "ASoC: hw_free FE %s failed\n",
 			fe->dai_link->name);
 
 	/* only hw_params backends that are either sinks or sources
@@ -2162,7 +2162,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 			sizeof(struct snd_pcm_hw_params));
 	ret = dpcm_be_dai_hw_params(fe, substream->stream);
 	if (ret < 0) {
-		dev_err(fe->dev,"ASoC: hw_params BE failed %d\n", ret);
+		dev_err(fe->dev, "ASoC: hw_params BE failed %d\n", ret);
 		goto out;
 	}
 
@@ -2173,7 +2173,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 	/* call hw_params on the frontend */
 	ret = soc_pcm_hw_params(substream, params);
 	if (ret < 0) {
-		dev_err(fe->dev,"ASoC: hw_params FE failed %d\n", ret);
+		dev_err(fe->dev, "ASoC: hw_params FE failed %d\n", ret);
 		dpcm_be_dai_hw_free(fe, stream);
 	 } else
 		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_PARAMS;
@@ -2194,7 +2194,7 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 
 	ret = soc_pcm_trigger(substream, cmd);
 	if (ret < 0)
-		dev_err(dpcm->be->dev,"ASoC: trigger BE failed %d\n", ret);
+		dev_err(dpcm->be->dev, "ASoC: trigger BE failed %d\n", ret);
 
 	return ret;
 }
@@ -2310,7 +2310,7 @@ static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		ret = soc_pcm_trigger(substream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 
@@ -2321,7 +2321,7 @@ static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		ret = dpcm_be_dai_trigger(fe, substream->stream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 
@@ -2338,7 +2338,7 @@ static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		ret = soc_pcm_bespoke_trigger(substream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 		break;
@@ -2447,7 +2447,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	/* call prepare on the frontend */
 	ret = soc_pcm_prepare(substream);
 	if (ret < 0) {
-		dev_err(fe->dev,"ASoC: prepare FE %s failed\n",
+		dev_err(fe->dev, "ASoC: prepare FE %s failed\n",
 			fe->dai_link->name);
 		goto out;
 	}
@@ -2509,23 +2509,23 @@ static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 
 		err = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		if (err < 0)
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", err);
 	} else {
 		dev_dbg(fe->dev, "ASoC: trigger FE %s cmd stop\n",
 			fe->dai_link->name);
 
 		err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
 		if (err < 0)
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", err);
 	}
 
 	err = dpcm_be_dai_hw_free(fe, stream);
 	if (err < 0)
-		dev_err(fe->dev,"ASoC: hw_free FE failed %d\n", err);
+		dev_err(fe->dev, "ASoC: hw_free FE failed %d\n", err);
 
 	err = dpcm_be_dai_shutdown(fe, stream);
 	if (err < 0)
-		dev_err(fe->dev,"ASoC: shutdown FE failed %d\n", err);
+		dev_err(fe->dev, "ASoC: shutdown FE failed %d\n", err);
 
 	/* run the stream event for each BE */
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_NOP);
@@ -2586,7 +2586,8 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 
 		ret = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: bespoke trigger FE failed %d\n", ret);
+			dev_err(fe->dev,
+				"ASoC: bespoke trigger FE failed %d\n", ret);
 			goto hw_free;
 		}
 	} else {
@@ -2596,7 +2597,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		ret = dpcm_be_dai_trigger(fe, stream,
 					SNDRV_PCM_TRIGGER_START);
 		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
+			dev_err(fe->dev, "ASoC: trigger FE failed %d\n", ret);
 			goto hw_free;
 		}
 	}
@@ -3048,7 +3049,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->dai_link->name);
 		return ret;
 	}
-	dev_dbg(rtd->card->dev, "ASoC: registered pcm #%d %s\n",num, new_name);
+	dev_dbg(rtd->card->dev, "ASoC: registered pcm #%d %s\n", num, new_name);
 
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
-- 
2.15.0
