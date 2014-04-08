From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs42l52: Convert to use
	devm_gpio_request_one
Date: Tue, 08 Apr 2014 22:10:33 +0800
Message-ID: <1396966233.14167.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E1B6268105
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 16:10:40 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id uo5so1077785pbc.18
 for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2014 07:10:38 -0700 (PDT)
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

Current code missed a gpio_free() call in cs42l52_i2c_remove().
Convert to use devm_gpio_request_one() to fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 460d355..2213a03 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1229,8 +1229,10 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	if (cs42l52->pdata.reset_gpio) {
-		ret = gpio_request_one(cs42l52->pdata.reset_gpio,
-				       GPIOF_OUT_INIT_HIGH, "CS42L52 /RST");
+		ret = devm_gpio_request_one(&i2c_client->dev,
+					    cs42l52->pdata.reset_gpio,
+					    GPIOF_OUT_INIT_HIGH,
+					    "CS42L52 /RST");
 		if (ret < 0) {
 			dev_err(&i2c_client->dev, "Failed to request /RST %d: %d\n",
 				cs42l52->pdata.reset_gpio, ret);
-- 
1.8.3.2
