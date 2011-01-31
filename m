From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Accept any logical value for WM8962 GPIO
	set()
Date: Mon, 31 Jan 2011 13:55:11 +0000
Message-ID: <1296482111-3022-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A7A21038C6
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 14:55:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5c7b730..3b71dd6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3635,7 +3635,7 @@ static void wm8962_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct snd_soc_codec *codec = wm8962->codec;
 
 	snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
-			    WM8962_GP2_LVL, value << WM8962_GP2_LVL_SHIFT);
+			    WM8962_GP2_LVL, !!value << WM8962_GP2_LVL_SHIFT);
 }
 
 static int wm8962_gpio_direction_out(struct gpio_chip *chip,
-- 
1.7.2.3
