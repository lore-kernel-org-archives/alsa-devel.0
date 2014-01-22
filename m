From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: tlv320aic32x4: Use gpio_is_valid()
Date: Wed, 22 Jan 2014 17:24:17 -0200
Message-ID: <1390418657-5373-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f173.google.com (mail-gg0-f173.google.com
 [209.85.161.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 8716B261609
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 20:24:29 +0100 (CET)
Received: by mail-gg0-f173.google.com with SMTP id n5so3229312ggj.32
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 11:24:28 -0800 (PST)
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

From: Fabio Estevam <fabio.estevam@freescale.com>

We could use gpio_is_valid() for doing the sanity check on the GPIO number.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 385dec1..02d2d3c 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -687,7 +687,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
-	if (aic32x4->rstn_gpio >= 0) {
+	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ret = devm_gpio_request_one(&i2c->dev, aic32x4->rstn_gpio,
 				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
 		if (ret != 0)
-- 
1.8.1.2
