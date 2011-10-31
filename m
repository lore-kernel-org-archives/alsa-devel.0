From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix return value of
	wm5100_gpio_direction_out()
Date: Mon, 31 Oct 2011 19:03:29 +0000
Message-ID: <1320087809-22966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F90A247C7
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 20:03:33 +0100 (CET)
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

We can't just pass back the return value of snd_soc_update_bits() as it
will be 1 if a bit changed rather than zero.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 3ab725a..cf66209 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2366,13 +2366,17 @@ static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
 	struct snd_soc_codec *codec = wm5100->codec;
-	int val;
+	int val, ret;
 
 	val = (1 << WM5100_GP1_FN_SHIFT) | (!!value << WM5100_GP1_LVL_SHIFT);
 
-	return snd_soc_update_bits(codec, WM5100_GPIO_CTRL_1 + offset,
-				   WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
-				   WM5100_GP1_LVL, val);
+	ret = snd_soc_update_bits(codec, WM5100_GPIO_CTRL_1 + offset,
+				  WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
+				  WM5100_GP1_LVL, val);
+	if (ret < 0)
+		return ret;
+	else
+		return 0;
 }
 
 static int wm5100_gpio_get(struct gpio_chip *chip, unsigned offset)
-- 
1.7.7.1
