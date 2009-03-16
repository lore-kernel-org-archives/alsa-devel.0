From: Joonyoung Shim <dofmind@gmail.com>
Subject: [PATCH 1/1] ASoC: twl4030 - Fix build error
Date: Mon, 16 Mar 2009 12:13:50 +0900
Message-ID: <4e1455be0903152013kf2158fdpc339a682111417c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 46FD11037FB
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 04:13:52 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1494543wfd.23
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 20:13:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  CC      sound/soc/codecs/twl4030.o
sound/soc/codecs/twl4030.c:1400: warning: braces around scalar initializer
sound/soc/codecs/twl4030.c:1400: warning: (near initialization for
'twl4030_dai.ops')
sound/soc/codecs/twl4030.c:1401: error: field name not in record or
union initializer
sound/soc/codecs/twl4030.c:1401: error: (near initialization for
'twl4030_dai.ops')
sound/soc/codecs/twl4030.c:1401: warning: initialization from
incompatible pointer type
sound/soc/codecs/twl4030.c:1402: error: field name not in record or
union initializer
sound/soc/codecs/twl4030.c:1402: error: (near initialization for
'twl4030_dai.ops')
sound/soc/codecs/twl4030.c:1402: warning: excess elements in scalar initializer
sound/soc/codecs/twl4030.c:1402: warning: (near initialization for
'twl4030_dai.ops')
sound/soc/codecs/twl4030.c:1403: error: field name not in record or
union initializer
sound/soc/codecs/twl4030.c:1403: error: (near initialization for
'twl4030_dai.ops')
sound/soc/codecs/twl4030.c:1403: warning: excess elements in scalar initializer
sound/soc/codecs/twl4030.c:1403: warning: (near initialization for
'twl4030_dai.ops')

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ce4b43b..5ed5f1b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1383,6 +1383,12 @@ static int twl4030_set_dai_fmt(struct
snd_soc_dai *codec_dai,
 #define TWL4030_RATES   (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS         (SNDRV_PCM_FMTBIT_S16_LE |
SNDRV_PCM_FORMAT_S24_LE)

+static struct snd_soc_dai_ops twl4030_dai_ops = {
+       .hw_params      = twl4030_hw_params,
+       .set_sysclk     = twl4030_set_dai_sysclk,
+       .set_fmt        = twl4030_set_dai_fmt,
+};
+
 struct snd_soc_dai twl4030_dai = {
        .name = "twl4030",
        .playback = {
@@ -1397,11 +1403,7 @@ struct snd_soc_dai twl4030_dai = {
                .channels_max = 2,
                .rates = TWL4030_RATES,
                .formats = TWL4030_FORMATS,},
-       .ops = {
-               .hw_params = twl4030_hw_params,
-               .set_sysclk = twl4030_set_dai_sysclk,
-               .set_fmt = twl4030_set_dai_fmt,
-       }
+       .ops = &twl4030_dai_ops,
 };
 EXPORT_SYMBOL_GPL(twl4030_dai);

-- 
1.5.6.3


-- 
- Joonyoung Shim
