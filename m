From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 6/8] ASoC: wm8804: Constify struct regmap_config and
 snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:26 +0100
Message-ID: <1420449508-10701-6-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
pointer to const).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm8804.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 1315f7642503..b2b0e68f707e 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -648,7 +648,7 @@ static struct snd_soc_dai_driver wm8804_dai = {
 	.symmetric_rates = 1
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.probe = wm8804_probe,
 	.remove = wm8804_remove,
 	.set_bias_level = wm8804_set_bias_level,
@@ -664,7 +664,7 @@ static const struct of_device_id wm8804_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8804_of_match);
 
-static struct regmap_config wm8804_regmap_config = {
+static const struct regmap_config wm8804_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
