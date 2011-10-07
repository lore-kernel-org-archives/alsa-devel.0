From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v3 05/10] ASoC: wm8776: Convert to
	snd_soc_cache_sync
Date: Fri, 07 Oct 2011 21:41:41 +0800
Message-ID: <1317994901.9906.10.camel@phoenix>
References: <1317994508.9906.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B34B103B77
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:41:49 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so3212393ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 06:41:48 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert to snd_soc_cache_sync for sync reg_cache with the hardware.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8776.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 00d8846..bfdc523 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -308,6 +308,8 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			snd_soc_cache_sync(codec);
+
 			/* Disable the global powerdown; DAPM does the rest */
 			snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 0);
 		}
@@ -379,21 +381,7 @@ static int wm8776_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8776_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8776_reg); i++) {
-		if (cache[i] == wm8776_reg[i])
-			continue;
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
-
 	wm8776_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 #else
-- 
1.7.4.1
