From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 1/2] ALSA: ASoC: ssm2602,
	wm8903: Fix priv substreams refs
Date: Thu, 20 Nov 2008 15:39:27 +0100
Message-ID: <4925769F.1010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D515243AB
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:39:15 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so294135ugf.24
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 06:39:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

ssm2602.c and wm8903.c read:
"The DAI has shared clocks so if we already have a playback or
capture going then constrain this substream to match it."

Let ssm2602.c handle this the same way as wm8903.c and highlight
possible race pitfall in both files.
This fixes subsequent failures of snd_pcm_hw_constraints_complete
after closure of a stream.

NOTE:
- The ssm2602 allows pairs of non-matching PB/REC rates.
- This is a fix for less evil:
  The logic is flawed (e.g. the slave might startup before the
  master's rate and sample_bits are set).

Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
---
 sound/soc/codecs/ssm2602.c |   20 ++++++++++++++++++++
 sound/soc/codecs/wm8903.c  |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 44ef0da..abc804e 100644
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
@@ -330,13 +336,21 @@ static int ssm2602_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
+	struct i2c_client *i2c = codec->control_data;
 	struct snd_pcm_runtime *master_runtime;
 
 	/* The DAI has shared clocks so if we already have a playback or
 	 * capture going then constrain this substream to match it.
+	 * TODO: the ssm2602 allows pairs of non-matching PB/REC rates
+	 * FIXME: this is racy, e.g. the slave might startup before the
+	 * master's rate and sample_bits are set.
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
@@ -370,9 +384,15 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream)
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
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ce40d78..ebe0c84 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1273,6 +1273,8 @@ static int wm8903_startup(struct snd_pcm_substream *substream)
 
 	/* The DAI has shared clocks so if we already have a playback or
 	 * capture going then constrain this substream to match it.
+	 * FIXME: this is racy, e.g. the slave might startup before the
+	 * master's rate and sample_bits are set.
 	 */
 	if (wm8903->master_substream) {
 		master_runtime = wm8903->master_substream->runtime;
-- 
1.6.0.3.523.g304d0
