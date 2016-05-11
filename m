From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Select LPPLL during standby
Date: Wed, 11 May 2016 14:14:05 +0300
Message-ID: <1462965245-7111-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE62267CB7
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 13:14:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the codec is in standby we do not need to keep the HPPLL active.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bc3de2e844e6..7a744b581cc1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -824,7 +824,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 {
 	struct twl6040 *twl6040 = codec->control_data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int ret = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -832,12 +832,16 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (priv->codec_powered)
+		if (priv->codec_powered) {
+			/* Select low power PLL in standby */
+			ret = twl6040_set_pll(twl6040, TWL6040_SYSCLK_SEL_LPPLL,
+					      32768, 19200000);
 			break;
+		}
 
 		ret = twl6040_power(twl6040, 1);
 		if (ret)
-			return ret;
+			break;
 
 		priv->codec_powered = 1;
 
@@ -853,7 +857,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int twl6040_startup(struct snd_pcm_substream *substream,
-- 
2.8.2
