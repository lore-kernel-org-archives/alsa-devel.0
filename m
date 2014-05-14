From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Make Baytrail PCM data per
	stream rather than per DAI device
Date: Wed, 14 May 2014 17:20:53 +0300
Message-ID: <1400077254-31465-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id C620F265465
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 16:21:06 +0200 (CEST)
In-Reply-To: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Prepare for single Baytrail DAI playback/capture link by accessing PCM data
using stream ID instead of rtd->dev. Now rtd->dev is unique for playback
and capture since they are exported as separate DAIs but not once converted
to single DAI.

[Jarkko: Separated from another commit with updated commit log]

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 0afb3491f5f0..73bb68119b9e 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -68,7 +68,7 @@ static int sst_byt_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sst_byt_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	u32 rate, bits;
 	u8 channels;
@@ -140,7 +140,7 @@ static int sst_byt_pcm_restore_stream_context(struct snd_pcm_substream *substrea
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sst_byt_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	int ret;
 
@@ -172,7 +172,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sst_byt_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 
 	dev_dbg(rtd->dev, "PCM: trigger %d\n", cmd);
@@ -229,7 +229,9 @@ static snd_pcm_uframes_t sst_byt_pcm_pointer(struct snd_pcm_substream *substream
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_priv_data *pdata =
+		snd_soc_platform_get_drvdata(rtd->platform);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 
 	dev_dbg(rtd->dev, "PCM: DMA pointer %u bytes\n", pcm_data->hw_ptr);
 
@@ -241,15 +243,13 @@ static int sst_byt_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sst_byt_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 
 	dev_dbg(rtd->dev, "PCM: open\n");
 
-	pcm_data = &pdata->pcm[rtd->cpu_dai->id];
 	mutex_lock(&pcm_data->mutex);
 
-	snd_soc_pcm_set_drvdata(rtd, pcm_data);
 	pcm_data->substream = substream;
 
 	snd_soc_set_runtime_hwparams(substream, &sst_byt_pcm_hardware);
@@ -271,7 +271,7 @@ static int sst_byt_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sst_byt_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	int ret;
 
-- 
2.0.0.rc0
