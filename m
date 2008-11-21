From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/10] ASoC: ssm2602: Fix priv substreams refs
Date: Fri, 21 Nov 2008 14:48:26 +0000
Message-ID: <1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9921E244DE
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:35 +0100 (CET)
In-Reply-To: <1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Karl Beldan <karl.beldan@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Karl Beldan <karl.beldan@gmail.com>

Clean up our record of the active streams in shutdown(), fixing
subsequent failures of snd_pcm_hw_constraints_complete after closure of
a stream.

NOTE:
- The ssm2602 allows pairs of non-matching PB/REC rates.
- This is a fix for less evil:
  The logic is flawed (e.g. the slave might startup before the
  master's rate and sample_bits are set).

Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ssm2602.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 44ef0da..0e522e7 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -292,9 +292,15 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
+	struct i2c_client *i2c = codec->control_data;
 	u16 iface = ssm2602_read_reg_cache(codec, SSM2602_IFACE) & 0xfff3;
 	int i = get_coeff(ssm2602->sysclk, params_rate(params));
 
+	if (substream == ssm2602->slave_substream) {
+		dev_dbg(&i2c->dev, "Ignoring hw_params for slave substream\n");
+		return 0;
+	}
+
 	/*no match is found*/
 	if (i == ARRAY_SIZE(coeff_div))
 		return -EINVAL;
@@ -330,13 +336,19 @@ static int ssm2602_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
+	struct i2c_client *i2c = codec->control_data;
 	struct snd_pcm_runtime *master_runtime;
 
 	/* The DAI has shared clocks so if we already have a playback or
 	 * capture going then constrain this substream to match it.
+	 * TODO: the ssm2602 allows pairs of non-matching PB/REC rates
 	 */
 	if (ssm2602->master_substream) {
 		master_runtime = ssm2602->master_substream->runtime;
+		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
+			master_runtime->sample_bits,
+			master_runtime->rate);
+
 		snd_pcm_hw_constraint_minmax(substream->runtime,
 					     SNDRV_PCM_HW_PARAM_RATE,
 					     master_runtime->rate,
@@ -370,9 +382,15 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
+	struct ssm2602_priv *ssm2602 = codec->private_data;
 	/* deactivate */
 	if (!codec->active)
 		ssm2602_write(codec, SSM2602_ACTIVE, 0);
+
+	if (ssm2602->master_substream == substream)
+		ssm2602->master_substream = ssm2602->slave_substream;
+
+	ssm2602->slave_substream = NULL;
 }
 
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
-- 
1.5.6.5
