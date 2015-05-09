From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 2/2] ASoC: sta350: Use
 devm_gpiod_get_optional at appropriate place
Date: Sat, 09 May 2015 23:09:32 +0800
Message-ID: <1431184172.5393.2.camel@ingics.com>
References: <1431184113.5393.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 454E826051D
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 17:09:37 +0200 (CEST)
Received: by pdbqa5 with SMTP id qa5so109211617pdb.1
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 08:09:36 -0700 (PDT)
In-Reply-To: <1431184113.5393.1.camel@ingics.com>
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
v2: Fixup subject line

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
