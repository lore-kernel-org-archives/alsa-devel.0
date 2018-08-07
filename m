From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: rt5677: Remove bogus device id from rt5677_of_match
Date: Tue,  7 Aug 2018 09:22:34 -0700
Message-ID: <20180807162234.205212-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

The initializer of rt5677_of_match contains a bogus device id
(enum type) for the 'type' field (char []). Remove it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8a0181a2db08..7dab53b35cbf 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
-- 
2.18.0.597.ga71716f1ad-goog
