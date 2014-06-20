From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 07/16] ASoC: twl4030: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:03 +0530
Message-ID: <1403258352-8210-7-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2E6261A95
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:43 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id v10so2826211pde.40
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:42 -0700 (PDT)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
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
Cc: broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Let memory subsystem handle the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/twl4030.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 69e12a311ba2..955df35c5ab6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2162,10 +2162,8 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 
 	twl4030 = devm_kzalloc(codec->dev, sizeof(struct twl4030_priv),
 			       GFP_KERNEL);
-	if (twl4030 == NULL) {
-		dev_err(codec->dev, "Can not allocate memory\n");
+	if (!twl4030)
 		return -ENOMEM;
-	}
 	snd_soc_codec_set_drvdata(codec, twl4030);
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_audio_get_mclk() / 1000;
-- 
1.7.9.5
