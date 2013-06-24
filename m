From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 1/4] ASoC: codecs: adau1701: move firmware
	download to adau1701_reset()
Date: Mon, 24 Jun 2013 16:31:29 +0200
Message-ID: <1372084292-4859-2-git-send-email-zonque@gmail.com>
References: <1372084292-4859-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id BABF52650A0
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:31:05 +0200 (CEST)
In-Reply-To: <1372084292-4859-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The chip needs a new download after each reset, so the code to do that
needs to live in adau1701_reset().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/adau1701.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index b6b1a77..997fc3b 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -184,27 +184,20 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
 	return value;
 }
 
-static void adau1701_reset(struct snd_soc_codec *codec)
+static int adau1701_reset(struct snd_soc_codec *codec)
 {
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
-
-	if (!gpio_is_valid(adau1701->gpio_nreset))
-		return;
-
-	gpio_set_value(adau1701->gpio_nreset, 0);
-	/* minimum reset time is 20ns */
-	udelay(1);
-	gpio_set_value(adau1701->gpio_nreset, 1);
-	/* power-up time may be as long as 85ms */
-	mdelay(85);
-}
-
-static int adau1701_init(struct snd_soc_codec *codec)
-{
-	int ret;
 	struct i2c_client *client = to_i2c_client(codec->dev);
+	int ret;
 
-	adau1701_reset(codec);
+	if (gpio_is_valid(adau1701->gpio_nreset)) {
+		gpio_set_value(adau1701->gpio_nreset, 0);
+		/* minimum reset time is 20ns */
+		udelay(1);
+		gpio_set_value(adau1701->gpio_nreset, 1);
+		/* power-up time may be as long as 85ms */
+		mdelay(85);
+	}
 
 	ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
 	if (ret) {
@@ -213,6 +206,7 @@ static int adau1701_init(struct snd_soc_codec *codec)
 	}
 
 	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
+	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
 
 	return 0;
 }
@@ -498,12 +492,10 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = to_i2c_client(codec->dev);
 
-	ret = adau1701_init(codec);
+	ret = adau1701_reset(codec);
 	if (ret)
 		return ret;
 
-	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
-
 	return 0;
 }
 
-- 
1.8.1.4
