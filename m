From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: wm8962: Do not call configure_bclk()
	inside wm8962_set_dai_sysclk()
Date: Fri, 19 Jul 2013 10:22:21 -0300
Message-ID: <1374240141-27359-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f176.google.com (mail-gg0-f176.google.com
 [209.85.161.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 6951A261A80
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 15:22:36 +0200 (CEST)
Received: by mail-gg0-f176.google.com with SMTP id i2so1259438ggk.21
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 06:22:35 -0700 (PDT)
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

Quoting Mark Brown [1]:

"The issue here is triggered by the machine
switching from the FLL to direct MCLK usage where the MCLK isn't
generating a useful ratio.

I suspect we should just kill the configure_bclk() in set_sysclk(), that
one isn't safe as we can't reconfigure a live SYSCLK and it's probably
the one that generates your warnings."

Confirmed that the "Unsupported sysclk ratio" error message comes from 
wm8962_set_dai_sysclk(), so get rid of wm8962_configure_bclk() inside this
function.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064241.html

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove wm8962_configure_bclk() from wm8962_set_dai_sysclk

 sound/soc/codecs/wm8962.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e2de9ec..8b8905d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2621,8 +2621,6 @@ static int wm8962_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	wm8962->sysclk_rate = freq;
 
-	wm8962_configure_bclk(codec);
-
 	return 0;
 }
 
-- 
1.8.1.2
