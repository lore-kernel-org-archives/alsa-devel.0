From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: Correct the judgement of data
	length
Date: Thu, 27 Mar 2014 19:34:51 +0800
Message-ID: <1395920091-3278-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A967B2652E3
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 12:35:29 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch corrects the judgement of data length.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0883c8a..bcd6513 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1622,16 +1622,16 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
 				bclk_ms, pre_div, dai->id);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val_len |= RT5640_I2S_DL_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		val_len |= RT5640_I2S_DL_24;
 		break;
-	case SNDRV_PCM_FORMAT_S8:
+	case 8:
 		val_len |= RT5640_I2S_DL_8;
 		break;
 	default:
-- 
1.8.1.1.439.g50a6b54
