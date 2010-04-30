From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/4] ASoC: tlv320dac33: Manage a pointer for
	snd_pcm_substream in private structure
Date: Fri, 30 Apr 2010 10:31:54 +0300
Message-ID: <1272612715-13387-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 501BC1038FF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 09:32:14 +0200 (CEST)
In-Reply-To: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

As a preparation for supporting codec to be turned off,
when we are in BIAS_STANDBY.

The substream must be easily available in other places than
pcm_* callbacks.

Manage a pointer in _startup, and _shutdown for this.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 7d01759..6edad36 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -91,6 +91,7 @@ struct tlv320dac33_priv {
 	struct work_struct work;
 	struct snd_soc_codec codec;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
+	struct snd_pcm_substream *substream;
 	int power_gpio;
 	int chip_power;
 	int irq;
@@ -725,6 +726,31 @@ static void dac33_oscwait(struct snd_soc_codec *codec)
 			"internal oscillator calibration failed\n");
 }
 
+static int dac33_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+
+	/* Stream started, save the substream pointer */
+	dac33->substream = substream;
+
+	return 0;
+}
+
+static void dac33_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+
+	dac33->substream = NULL;
+}
+
 static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -1372,6 +1398,8 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320dac33);
 #define DAC33_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
 static struct snd_soc_dai_ops dac33_dai_ops = {
+	.startup	= dac33_startup,
+	.shutdown	= dac33_shutdown,
 	.hw_params	= dac33_hw_params,
 	.prepare	= dac33_pcm_prepare,
 	.trigger	= dac33_pcm_trigger,
-- 
1.7.0.4
