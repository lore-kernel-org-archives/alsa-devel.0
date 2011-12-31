From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix return value of
 wm8903_gpio_direction_in() and wm8903_gpio_direction_out()
Date: Sat, 31 Dec 2011 11:01:41 +0800
Message-ID: <1325300501.4616.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D9EFA103B4E
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 04:01:54 +0100 (CET)
Received: by yenr11 with SMTP id r11so4533325yen.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 19:01:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

We can't just pass back the return value of snd_soc_update_bits() as it
will be 1 if a bit changed rather than zero.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8903.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d88b727..c91fb2f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1777,13 +1777,18 @@ static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
 	struct snd_soc_codec *codec = wm8903->codec;
 	unsigned int mask, val;
+	int ret;
 
 	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK;
 	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GP1_FN_SHIFT) |
 		WM8903_GP1_DIR;
 
-	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
-				   mask, val);
+	ret = snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
+				  mask, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -1803,13 +1808,18 @@ static int wm8903_gpio_direction_out(struct gpio_chip *chip,
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
 	struct snd_soc_codec *codec = wm8903->codec;
 	unsigned int mask, val;
+	int ret;
 
 	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK | WM8903_GP1_LVL_MASK;
 	val = (WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GP1_FN_SHIFT) |
 		(value << WM8903_GP2_LVL_SHIFT);
 
-	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
-				   mask, val);
+	ret = snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
+				  mask, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-- 
1.7.5.4
