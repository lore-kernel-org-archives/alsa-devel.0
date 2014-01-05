From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/5] ASoC: mc13783: Use core error messages if
	registration fails
Date: Sun,  5 Jan 2014 11:38:32 +0400
Message-ID: <1388907515-18975-2-git-send-email-shc_work@mail.ru>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 by alsa0.perex.cz (Postfix) with ESMTP id EBDFC261B1A
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 08:38:48 +0100 (CET)
In-Reply-To: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/mc13783.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 8ab9668..c2def5d 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -781,14 +781,6 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
 			mc13783_dai_async, ARRAY_SIZE(mc13783_dai_async));
 
-	if (ret)
-		goto err_register_codec;
-
-	return 0;
-
-err_register_codec:
-	dev_err(&pdev->dev, "register codec failed with %d\n", ret);
-
 	return ret;
 }
 
-- 
1.8.3.2
