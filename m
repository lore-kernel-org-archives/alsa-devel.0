From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: uninitialized variable i used in wait_for_dc_servo
Date: Thu, 15 Sep 2011 10:52:34 +0800
Message-ID: <1316055154.3496.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

hi Mark,
I guess we need to initialize i to timeout value. comments?

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e5e4607..5aee9cb 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -713,6 +713,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 	snd_soc_write(codec, WM8996_DC_SERVO_2, mask);
 
 	/* Use the interrupt if possible */
+	i = timeout;
 	do {
 		if (i2c->irq) {
 			timeout = wait_for_completion_timeout(&wm8996->dcs_done,
@@ -722,7 +723,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 
 		} else {
 			msleep(1);
-			if (--i) {
+			if (--i == 0) {
 				timeout = 0;
 				break;
 			}
