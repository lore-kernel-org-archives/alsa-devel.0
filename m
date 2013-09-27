From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: adau1373: Issue soft reset on probe
Date: Fri, 27 Sep 2013 13:47:10 +0200
Message-ID: <1380282430-28159-3-git-send-email-lars@metafoo.de>
References: <1380282430-28159-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-078.synserver.de (smtp-out-078.synserver.de
 [212.40.185.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E1126508C
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:45:57 +0200 (CEST)
In-Reply-To: <1380282430-28159-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Reset the device on probe to make sure that the register settings match the
register cache defaults.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 2f84054..59654b1 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1540,6 +1540,8 @@ static int adau1373_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(adau1373->regmap))
 		return PTR_ERR(adau1373->regmap);
 
+	regmap_write(adau1373->regmap, ADAU1373_SOFT_RESET, 0x00);
+
 	dev_set_drvdata(&client->dev, adau1373);
 
 	ret = snd_soc_register_codec(&client->dev, &adau1373_codec_driver,
-- 
1.8.0
