From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: When releasing WM5100 put /RESET into
	reset
Date: Tue, 17 Jan 2012 19:19:15 +0000
Message-ID: <1326827955-30443-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10097103A75
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 20:19:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Reset is active low, make sure we leave it asserted when release the
device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 9995d14..0e38a24 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2901,7 +2901,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 err_reset:
 	wm5100_free_gpio(i2c);
 	if (wm5100->pdata.reset) {
-		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
+		gpio_set_value_cansleep(wm5100->pdata.reset, 0);
 		gpio_free(wm5100->pdata.reset);
 	}
 err_ldo:
@@ -2934,7 +2934,7 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 	wm5100_free_gpio(client);
 	if (wm5100->pdata.reset) {
-		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
+		gpio_set_value_cansleep(wm5100->pdata.reset, 0);
 		gpio_free(wm5100->pdata.reset);
 	}
 	if (wm5100->pdata.ldo_ena) {
-- 
1.7.7.3
