From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs42l73: Convert to use
	devm_gpio_request_one
Date: Tue, 08 Apr 2014 22:11:40 +0800
Message-ID: <1396966300.14167.2.camel@phoenix>
References: <1396966233.14167.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 65ED1268112
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 16:11:46 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id z10so1062626pdj.32
 for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2014 07:11:45 -0700 (PDT)
In-Reply-To: <1396966233.14167.1.camel@phoenix>
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

Current code missed a gpio_free() call in cs42l73_i2c_remove().
Convert to use devm_gpio_request_one() to fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l73.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 0ee60a1..ae37179 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1443,8 +1443,10 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	i2c_set_clientdata(i2c_client, cs42l73);
 
 	if (cs42l73->pdata.reset_gpio) {
-		ret = gpio_request_one(cs42l73->pdata.reset_gpio,
-				       GPIOF_OUT_INIT_HIGH, "CS42L73 /RST");
+		ret = devm_gpio_request_one(&i2c_client->dev,
+					    cs42l73->pdata.reset_gpio,
+					    GPIOF_OUT_INIT_HIGH,
+					    "CS42L73 /RST");
 		if (ret < 0) {
 			dev_err(&i2c_client->dev, "Failed to request /RST %d: %d\n",
 				cs42l73->pdata.reset_gpio, ret);
-- 
1.8.3.2
