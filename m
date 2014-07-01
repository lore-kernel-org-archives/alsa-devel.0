From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/3] ASoC: twl4030: Remove unused variable
Date: Tue,  1 Jul 2014 09:59:31 +0530
Message-ID: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id AF96A261B31
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 06:33:05 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id y13so9463497pdi.27
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 21:33:04 -0700 (PDT)
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
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

'status' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/twl4030.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 955df35c5ab6..cf404505e7d1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -344,17 +344,16 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int status = -1;
 
 	if (enable) {
 		twl4030->apll_enabled++;
 		if (twl4030->apll_enabled == 1)
-			status = twl4030_audio_enable_resource(
+			twl4030_audio_enable_resource(
 							TWL4030_AUDIO_RES_APLL);
 	} else {
 		twl4030->apll_enabled--;
 		if (!twl4030->apll_enabled)
-			status = twl4030_audio_disable_resource(
+			twl4030_audio_disable_resource(
 							TWL4030_AUDIO_RES_APLL);
 	}
 }
-- 
1.7.9.5
