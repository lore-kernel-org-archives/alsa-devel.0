From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 5/6] ASoC: SSM2602: Model power supply
	for the digital core as a DAPM widget
Date: Sun,  8 May 2011 09:24:45 -0700
Message-ID: <1304871886-18509-5-git-send-email-lars@metafoo.de>
References: <20110508135613.GA15968@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20110508135613.GA15968-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Model the power supply for the digital core as a DAPM_SUPPLY widget. This allows
to cleanup the code a bit.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/codecs/ssm2602.c |   25 ++++++-------------------
 1 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index d828721..763d392 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -126,6 +126,8 @@ SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM2602_PWR, 3, 1),
 SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
 SND_SOC_DAPM_PGA("Line Input", SSM2602_PWR, 0, 1, NULL, 0),
 
+SND_SOC_DAPM_SUPPLY("Digital Core Power", SSM2602_ACTIVE, 0, 0, 0, 0),
+
 SND_SOC_DAPM_OUTPUT("LOUT"),
 SND_SOC_DAPM_OUTPUT("ROUT"),
 SND_SOC_DAPM_INPUT("RLINEIN"),
@@ -152,6 +154,9 @@ SND_SOC_DAPM_MIXER("Output Mixer", SND_SOC_NOPM, 0, 0,
 };
 
 static const struct snd_soc_dapm_route ssm260x_routes[] = {
+	{"DAC", NULL, "Digital Core Power"},
+	{"ADC", NULL, "Digital Core Power"},
+
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
 
@@ -252,7 +257,6 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	if (srate < 0)
 		return srate;
 
-	snd_soc_write(codec, SSM2602_ACTIVE, 0);
 	snd_soc_write(codec, SSM2602_SRATE, srate);
 
 	/* bit size */
@@ -270,7 +274,6 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 	snd_soc_write(codec, SSM2602_IFACE, iface);
-	snd_soc_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
 	return 0;
 }
 
@@ -312,17 +315,6 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	/* set active */
-	snd_soc_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
-
-	return 0;
-}
-
 static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
@@ -330,16 +322,13 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
-	/* deactivate */
-	if (!codec->active)
-		snd_soc_write(codec, SSM2602_ACTIVE, 0);
-
 	if (ssm2602->master_substream == substream)
 		ssm2602->master_substream = ssm2602->slave_substream;
 
 	ssm2602->slave_substream = NULL;
 }
 
+
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -446,7 +435,6 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* everything off, dac mute, inactive */
-		snd_soc_write(codec, SSM2602_ACTIVE, 0);
 		snd_soc_write(codec, SSM2602_PWR, 0xffff);
 		break;
 
@@ -464,7 +452,6 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 
 static struct snd_soc_dai_ops ssm2602_dai_ops = {
 	.startup	= ssm2602_startup,
-	.prepare	= ssm2602_pcm_prepare,
 	.hw_params	= ssm2602_hw_params,
 	.shutdown	= ssm2602_shutdown,
 	.digital_mute	= ssm2602_mute,
-- 
1.7.2.5
