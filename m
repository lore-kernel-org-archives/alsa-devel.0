From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: Fix return value of
	wm8962_gpio_direction_out()
Date: Fri, 30 Dec 2011 23:38:03 +0800
Message-ID: <1325259483.4755.4.camel@phoenix>
References: <1325259294.4755.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8E41103ACB
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:38:12 +0100 (CET)
Received: by ghbz2 with SMTP id z2so3413418ghb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:38:12 -0800 (PST)
In-Reply-To: <1325259294.4755.1.camel@phoenix>
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
 sound/soc/codecs/wm8962.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index be35b64..80e8b9f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3878,13 +3878,17 @@ static int wm8962_gpio_direction_out(struct gpio_chip *chip,
 {
 	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
-	int val;
+	int ret, val;
 
 	/* Force function 1 (logic output) */
 	val = (1 << WM8962_GP2_FN_SHIFT) | (value << WM8962_GP2_LVL_SHIFT);
 
-	return snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
-				   WM8962_GP2_FN_MASK | WM8962_GP2_LVL, val);
+	ret = snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
+				  WM8962_GP2_FN_MASK | WM8962_GP2_LVL, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static struct gpio_chip wm8962_template_chip = {
-- 
1.7.5.4
