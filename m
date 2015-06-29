From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: 88pm860x: Don't change pm860x->dir
 setting if pm860x_set_dai_sysclk fails
Date: Mon, 29 Jun 2015 11:15:23 +0800
Message-ID: <1435547723.6397.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5D9265191
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 05:15:29 +0200 (CEST)
Received: by pdcu2 with SMTP id u2so108330983pdc.3
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 20:15:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

88pm860x does not support slave mode, so it returns -EINVAL for
PM860X_CLK_DIR_IN. Current code changes pm860x->dir setting before
return error, so it has impact on the logic of pm860x_pcm_set_dai_fmt.

This patch adds comment for the reason to return -EINVAL for
PM860X_CLK_DIR_IN, and avoid changing pm860x->dir setting if
pm860x_set_dai_sysclk fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/88pm860x-codec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 38b3dad..4d91a6a 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1028,10 +1028,8 @@ static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	if (dir == PM860X_CLK_DIR_OUT)
 		pm860x->dir = PM860X_CLK_DIR_OUT;
-	else {
-		pm860x->dir = PM860X_CLK_DIR_IN;
+	else	/* Slave mode is not supported */
 		return -EINVAL;
-	}
 
 	return 0;
 }
-- 
2.1.0
