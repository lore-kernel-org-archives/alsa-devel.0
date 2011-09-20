From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ssm2602: Do not dereference
	codec->control_data
Date: Tue, 20 Sep 2011 08:19:58 +0200
Message-ID: <1316499598-31539-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-056.synserver.de (smtp-out-060.synserver.de
	[212.40.185.60]) by alsa0.perex.cz (Postfix) with SMTP id E91F3103818
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 08:20:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The driver assumes that control_data points to the drivers i2c_client struct,
but this is no longer the case since the ASoC core has switched to regmap.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 84f4ad5..cceb002 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -294,7 +294,6 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
 	struct snd_pcm_runtime *master_runtime;
 
 	/* The DAI has shared clocks so if we already have a playback or
@@ -303,7 +302,7 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	 */
 	if (ssm2602->master_substream) {
 		master_runtime = ssm2602->master_substream->runtime;
-		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
+		dev_dbg(codec->dev, "Constraining to %d bits at %dHz\n",
 			master_runtime->sample_bits,
 			master_runtime->rate);
 
-- 
1.7.2.5
