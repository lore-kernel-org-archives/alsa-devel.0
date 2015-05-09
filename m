From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: sta350: Use devm_gpiod_get_optional
 appropriate place
Date: Sat, 09 May 2015 21:39:56 +0800
Message-ID: <1431178796.23049.2.camel@ingics.com>
References: <1431178721.23049.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 422D7260504
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 15:40:01 +0200 (CEST)
Received: by pabsx10 with SMTP id sx10so72785040pab.3
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 06:40:00 -0700 (PDT)
In-Reply-To: <1431178721.23049.0.camel@ingics.com>
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
Cc: Johannes Stezenbach <js@sig21.net>, Sven Brandau <info@brandau.biz>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

devm_gpiod_get_optional is equivalent to devm_gpiod_get(), except that
when no GPIO was assigned to the requested function it will return NULL.
This is convenient for drivers that need to handle optional GPIOs.

I just checked the code in commit 34d7c3905adb9a9
("ASoC: improve usage of gpiod API") and found that it should use
devm_gpiod_get_optional rather than devm_gpiod_get here.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---

 sound/soc/codecs/sta350.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 50d8bbf..0cea8f9 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1217,8 +1217,8 @@ static int sta350_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(sta350->gpiod_nreset))
 		return PTR_ERR(sta350->gpiod_nreset);
 
-	sta350->gpiod_power_down = devm_gpiod_get(dev, "power-down",
-						  GPIOD_OUT_LOW);
+	sta350->gpiod_power_down = devm_gpiod_get_optional(dev, "power-down",
+							   GPIOD_OUT_LOW);
 	if (IS_ERR(sta350->gpiod_power_down))
 		return PTR_ERR(sta350->gpiod_power_down);
 
-- 
2.1.0
