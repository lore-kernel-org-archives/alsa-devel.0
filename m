From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH] ASoC: wm8731: Add 32 bit functionality
Date: Tue, 31 May 2016 16:18:28 +1000
Message-ID: <574D2CB4.9070500@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas02p.mx.bigpond.com (nskntmtas02p.mx.bigpond.com
 [61.9.168.140]) by alsa0.perex.cz (Postfix) with ESMTP id 9C0A92651AD
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 08:18:33 +0200 (CEST)
Received: from nskntcmgw07p ([61.9.169.167]) by nskntmtas02p.mx.bigpond.com
 with ESMTP
 id <20160531061831.BMBV2042.nskntmtas02p.mx.bigpond.com@nskntcmgw07p>
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 06:18:31 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1b7d3m-000430-DH
 for alsa-devel@alsa-project.org; Tue, 31 May 2016 16:21:51 +1000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds 32 bit functionality to the wm8731 codec driver.
Enabling this functionality for the Audio Injector sound card.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
  sound/soc/codecs/wm8731.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4bcf5f8..a9fc3bc 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -5,6 +5,7 @@
   * Copyright 2006-12 Wolfson Microelectronics, plc
   *
   * Author: Richard Purdie <richard@openedhand.com>
+ * Author: Matt Flax <flatmax@flatmax.com> added 32bit functionality.
   *
   * Based on wm8753.c by Liam Girdwood
   *
@@ -358,6 +359,9 @@ static int wm8731_hw_params(struct snd_pcm_substream 
*substream,
  	case 24:
  		iface |= 0x0008;
  		break;
+	case 32:
+		iface |= 0x000c;
+		break;
  	}
   	wm8731_set_deemph(codec);
@@ -541,7 +545,7 @@ static int wm8731_startup(struct snd_pcm_substream 
*substream,
  #define WM8731_RATES SNDRV_PCM_RATE_8000_96000
   #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | 
SNDRV_PCM_FMTBIT_S20_3LE |\
-	SNDRV_PCM_FMTBIT_S24_LE)
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
   static const struct snd_soc_dai_ops wm8731_dai_ops = {
  	.startup	= wm8731_startup,
-- 
2.5.0
