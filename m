From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v3 02/10] ASoC: wm8711: Convert to
	snd_soc_cache_sync
Date: Fri, 07 Oct 2011 21:37:54 +0800
Message-ID: <1317994674.9906.5.camel@phoenix>
References: <1317994508.9906.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1065D246B5
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:38:01 +0200 (CEST)
Received: by gyg4 with SMTP id 4so4200052gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 06:38:01 -0700 (PDT)
In-Reply-To: <1317994508.9906.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mike Arthur <Mike.Arthur@wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Dimitris@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert to snd_soc_cache_sync for sync reg_cache with the hardware.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8711.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 7475428..8d0347c 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -287,7 +287,6 @@ static int wm8711_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-
 static int wm8711_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
@@ -300,6 +299,9 @@ static int wm8711_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+			snd_soc_cache_sync(codec);
+
 		snd_soc_write(codec, WM8711_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -346,18 +348,7 @@ static int wm8711_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8711_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8711_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
-- 
1.7.4.1
