From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: mediatek: mt8183: remove unused DAPM pins
Date: Wed, 22 May 2019 22:55:05 +0800
Message-ID: <20190522145505.257961-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C95CF80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:55:15 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id v191so2213555ywc.11
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 07:55:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com, jiaxin.yu@mediatek.com
List-Id: alsa-devel@alsa-project.org

Kernel emits the following messages when booting.
ASoC: DAPM unknown pin Headset Mic
ASoC: DAPM unknown pin Headphone

Remove the unused DAPM pins.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../soc/mediatek/mt8183/mt8183-da7219-max98357.c | 15 +--------------
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c      | 16 +---------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 31ea8632c397..231fb49d79b9 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -18,18 +18,6 @@
 
 static struct snd_soc_jack headset_jack;
 
-/* Headset jack detection DAPM pins */
-static struct snd_soc_jack_pin headset_jack_pins[] = {
-	{
-		.pin = "Headphone",
-		.mask = SND_JACK_HEADPHONE,
-	},
-	{
-		.pin = "Headset Mic",
-		.mask = SND_JACK_MICROPHONE,
-	},
-};
-
 static struct snd_soc_dai_link_component
 mt8183_da7219_max98357_external_codecs[] = {
 	{
@@ -375,8 +363,7 @@ mt8183_da7219_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				    &headset_jack,
-				    headset_jack_pins,
-				    ARRAY_SIZE(headset_jack_pins));
+				    NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 4e44e5689d6f..1ba7aa58e4b6 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -17,19 +17,6 @@
 
 static struct snd_soc_jack headset_jack;
 
-/* Headset jack detection DAPM pins */
-static struct snd_soc_jack_pin headset_jack_pins[] = {
-	{
-		.pin = "Headphone",
-		.mask = SND_JACK_HEADPHONE,
-	},
-	{
-		.pin = "Headset Mic",
-		.mask = SND_JACK_MICROPHONE,
-	},
-
-};
-
 static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -328,8 +315,7 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				    &headset_jack,
-				    headset_jack_pins,
-				    ARRAY_SIZE(headset_jack_pins));
+				    NULL, 0);
 	if (ret)
 		return ret;
 
-- 
2.21.0.1020.gf2820cf01a-goog
