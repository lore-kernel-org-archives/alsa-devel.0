From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs35l33: Fix testing return value of
 devm_gpiod_get_optional
Date: Thu, 30 Jun 2016 08:13:34 +0800
Message-ID: <1467245614.7105.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 by alsa0.perex.cz (Postfix) with ESMTP id D08A5265FAE
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 02:13:40 +0200 (CEST)
Received: by mail-pa0-f66.google.com with SMTP id ts6so5621553pac.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 17:13:40 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

devm_gpiod_get_optional() returns NULL when the gpio is not assigned.
So the if (PTR_ERR(cs35l33->reset_gpio) == -ENOENT) test is always false.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l33.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 622a111..aa5c0c5 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1176,11 +1176,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	/* We could issue !RST or skip it based on AMP topology */
 	cs35l33->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
 			"reset-gpios", GPIOD_OUT_HIGH);
-
-	if (PTR_ERR(cs35l33->reset_gpio) == -ENOENT) {
-		dev_warn(&i2c_client->dev,
-			"%s WARNING: No reset gpio assigned\n", __func__);
-	} else if (IS_ERR(cs35l33->reset_gpio)) {
+	if (IS_ERR(cs35l33->reset_gpio)) {
 		dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
 			__func__);
 		return PTR_ERR(cs35l33->reset_gpio);
-- 
2.5.0
