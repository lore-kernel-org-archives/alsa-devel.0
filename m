From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8962: No need to call
	wm8962_configure_bclk() multiple times
Date: Fri, 19 Jul 2013 02:58:28 -0300
Message-ID: <1374213508-25617-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f174.google.com (mail-ye0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DEBC26512F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 07:58:41 +0200 (CEST)
Received: by mail-ye0-f174.google.com with SMTP id m9so1189163yen.5
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 22:58:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently after playing any audio file, we get the following error message:

$ aplay clarinet.wav 
Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
$ wm8962 0-001a: Unsupported sysclk ratio 544

This error message appears about 5 seconds after the audio playback has 
finished.

There is no need to re-calculate the bit clock after the playback has finished,
so call wm8962_configure_bclk only once inside wm8962_hw_params(). 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8962.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 6a5066c..1bf79dc 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2497,8 +2497,6 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 		/* VMID 2*50k */
 		snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
 				    WM8962_VMID_SEL_MASK, 0x80);
-
-		wm8962_configure_bclk(codec);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -2621,8 +2619,6 @@ static int wm8962_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	wm8962->sysclk_rate = freq;
 
-	wm8962_configure_bclk(codec);
-
 	return 0;
 }
 
-- 
1.8.1.2
