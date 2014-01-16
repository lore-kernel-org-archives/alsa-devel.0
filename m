From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/4] ASoC: tlv320aic32x4: Use gpio_is_valid
Date: Thu, 16 Jan 2014 16:30:25 +0100
Message-ID: <1389886227-876-3-git-send-email-mpa@pengutronix.de>
References: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D3F26261AA9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:31:06 +0100 (CET)
In-Reply-To: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Use function gpio_is_valid to check for gpio ports.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 86bcae9..1c9f1d8 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -594,7 +594,7 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 
-	if (aic32x4->rstn_gpio >= 0) {
+	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
 	}
@@ -699,7 +699,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
-	if (aic32x4->rstn_gpio >= 0) {
+	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ret = devm_gpio_request_one(&i2c->dev, aic32x4->rstn_gpio,
 				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
 		if (ret != 0)
-- 
1.8.5.2
