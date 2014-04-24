From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl5000: Use devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 14:13:08 -0300
Message-ID: <1398359588-4200-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0302652E2
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 19:13:46 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
do not need to call regulator_bulk_free() in the error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index b56caef..9626ee0 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1322,7 +1322,7 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
+	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
 				 sgtl5000->supplies);
 	if (ret)
 		goto err_ldo_remove;
@@ -1330,16 +1330,13 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 	if (ret)
-		goto err_regulator_free;
+		goto err_ldo_remove;
 
 	/* wait for all power rails bring up */
 	udelay(10);
 
 	return 0;
 
-err_regulator_free:
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
 err_ldo_remove:
 	if (!external_vddd)
 		ldo_regulator_remove(codec);
@@ -1409,8 +1406,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 err:
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
 	ldo_regulator_remove(codec);
 
 	return ret;
@@ -1424,8 +1419,6 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
 	ldo_regulator_remove(codec);
 
 	return 0;
-- 
1.8.3.2
