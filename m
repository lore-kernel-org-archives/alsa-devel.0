From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Use clock API integration to
	configure MCLK divisor
Date: Fri, 14 Dec 2012 15:19:01 +0900
Message-ID: <1355465942-15122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8C02261602
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 12:50:20 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
 by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 5140C110686
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 11:50:20 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we are now using the clock API integration to manage MCLK we can now
use clk_get_rate() to determine if we need to divide MCLK without relying
on platform data.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm2000.h    |    3 ---
 sound/soc/codecs/wm2000.c |    6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/sound/wm2000.h b/include/sound/wm2000.h
index aa388ca..4de81f4 100644
--- a/include/sound/wm2000.h
+++ b/include/sound/wm2000.h
@@ -15,9 +15,6 @@ struct wm2000_platform_data {
 	/** Filename for system-specific image to download to device. */
 	const char *download_file;
 
-	/** Divide MCLK by 2 for system clock? */
-	unsigned int mclkdiv2:1;
-
 	/** Disable speech clarity enhancement, for use when an
 	 * external algorithm is used. */
 	unsigned int speech_enh_disable:1;
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 0aba8ce..85550dc 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -73,7 +73,6 @@ struct wm2000_priv {
 	unsigned int anc_eng_ena:1;
 	unsigned int spk_ena:1;
 
-	unsigned int mclk_div:1;
 	unsigned int speech_clarity:1;
 
 	int anc_download_size;
@@ -133,6 +132,7 @@ static int wm2000_poll_bit(struct i2c_client *i2c,
 static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
+	unsigned long rate;
 	int ret;
 
 	BUG_ON(wm2000->anc_mode != ANC_OFF);
@@ -145,7 +145,8 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 		return ret;
 	}
 
-	if (!wm2000->mclk_div) {
+	rate = clk_get_rate(wm2000->mclk);
+	if (rate <= 13500000) {
 		dev_dbg(&i2c->dev, "Disabling MCLK divider\n");
 		wm2000_write(i2c, WM2000_REG_SYS_CTL2,
 			     WM2000_MCLK_DIV2_ENA_CLR);
@@ -847,7 +848,6 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 	filename = "wm2000_anc.bin";
 	pdata = dev_get_platdata(&i2c->dev);
 	if (pdata) {
-		wm2000->mclk_div = pdata->mclkdiv2;
 		wm2000->speech_clarity = !pdata->speech_enh_disable;
 
 		if (pdata->download_file)
-- 
1.7.10.4
