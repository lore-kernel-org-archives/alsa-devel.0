From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Change codec_muted to
	apll_enabled
Date: Wed, 28 Oct 2009 10:57:05 +0200
Message-ID: <1256720225-6853-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256720225-6853-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 40532103836
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 09:57:25 +0100 (CET)
In-Reply-To: <1256720225-6853-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

codec_muted is missleading, change it to apll_enabled,
which is what it is doing: enabing and disabling the APLL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2400226..9163713 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -123,7 +123,7 @@ struct twl4030_priv {
 	struct snd_soc_codec codec;
 
 	unsigned int codec_powered;
-	unsigned int codec_muted;
+	unsigned int apll_enabled;
 
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
@@ -218,25 +218,25 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
-static void twl4030_codec_mute(struct snd_soc_codec *codec, int mute)
+static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = codec->private_data;
 	int status;
 
-	if (mute == twl4030->codec_muted)
+	if (enable == twl4030->apll_enabled)
 		return;
 
-	if (mute)
-		/* Disable PLL */
-		status = twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
-	else
+	if (enable)
 		/* Enable PLL */
 		status = twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
+	else
+		/* Disable PLL */
+		status = twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
 
 	if (status >= 0)
 		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
 
-	twl4030->codec_muted = mute;
+	twl4030->apll_enabled = enable;
 }
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
@@ -1464,14 +1464,14 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		twl4030_codec_mute(codec, 0);
+		twl4030_apll_enable(codec, 1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF)
 			twl4030_power_up(codec);
-		twl4030_codec_mute(codec, 1);
+		twl4030_apll_enable(codec, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_power_down(codec);
-- 
1.6.5.1
