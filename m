From: Fabio Estevam <festevam@gmail.com>
Subject: [RFC] ASoC: wm892: Set an initial non-mute volume for
	the headphones
Date: Thu, 18 Jul 2013 21:47:18 -0300
Message-ID: <1374194838-30735-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f46.google.com (mail-yh0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CF0AC2655FE
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 02:47:33 +0200 (CEST)
Received: by mail-yh0-f46.google.com with SMTP id i57so1350821yha.19
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 17:47:32 -0700 (PDT)
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

By default the headphone left/right registers have a volume of zero.

Instead of having to change the volume via alsamixer in order to be able to hear
something, let's set an initial value of -20dB, so that audio playback can be 
heard by default.

Tested on a mx6qsabresd board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Mark,

I posted it as RFC as I don't know if this is a valid approach.
Suggestions are welcome.

Thanks

 sound/soc/codecs/wm8962.c | 6 ++++++
 sound/soc/codecs/wm8962.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e2de9ec..6a5066c 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3448,6 +3448,12 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 				    WM8962_MICBIAS_LVL,
 				    pdata->mic_cfg);
 
+	/* set an initial volume for playback of -20 dB */
+	snd_soc_update_bits(codec, WM8962_HPOUTL_VOLUME,
+			    WM8962_HPOUTL_VOL_MASK, WM8962_HPOUTx_MINUS_20_DB);
+	snd_soc_update_bits(codec, WM8962_HPOUTR_VOLUME,
+			    WM8962_HPOUTR_VOL_MASK, WM8962_HPOUTx_MINUS_20_DB);
+
 	/* Latch volume update bits */
 	snd_soc_update_bits(codec, WM8962_LEFT_INPUT_VOLUME,
 			    WM8962_IN_VU, WM8962_IN_VU);
diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index a1a5d52..5dbe972 100644
--- a/sound/soc/codecs/wm8962.h
+++ b/sound/soc/codecs/wm8962.h
@@ -27,6 +27,8 @@
 #define WM8962_FLL_OSC  3
 #define WM8962_FLL_INT  4
 
+#define WM8962_HPOUTx_MINUS_20_DB		0x65
+
 /*
  * Register values.
  */
-- 
1.8.1.2
