From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Accept any logical value WM8903 GPIO
	set()
Date: Mon, 31 Jan 2011 13:42:25 +0000
Message-ID: <1296481345-20173-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0191E103899
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 14:42:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, swarren@nvidia.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 54383c3..27cd8f5 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1904,7 +1904,8 @@ static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct snd_soc_codec *codec = wm8903->codec;
 
 	snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
-			    WM8903_GP1_LVL_MASK, value << WM8903_GP1_LVL_SHIFT);
+			    WM8903_GP1_LVL_MASK,
+			    !!value << WM8903_GP1_LVL_SHIFT);
 }
 
 static struct gpio_chip wm8903_template_chip = {
-- 
1.7.2.3
