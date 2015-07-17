From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Remove unused rt5645 variable
Date: Fri, 17 Jul 2015 10:58:40 +0800
Message-ID: <1437101920-36908-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"ASoC: rt5645: Simplify rt5645_enable_push_button_irq" removes
the test that accessed rt5645->pdata.jd_mode (that test is now
done in rt5645_jack_detect only), so we do not need that
variable anymore.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Applies on top of topic/rt5645. Sorry for not catching this earlier.

 sound/soc/codecs/rt5645.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2cedf0d..c959ee0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2763,7 +2763,6 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
 		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
-- 
2.4.3.573.g4eafbef
