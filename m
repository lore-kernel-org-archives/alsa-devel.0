From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: remove unused DAPM
	pins" to the asoc tree
Date: Thu, 23 May 2019 14:48:53 +0100 (BST)
Message-ID: <20190523134853.D99DB1126D25@debutante.sirena.org.uk>
References: <20190522145505.257961-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AA6BF89717
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 15:49:00 +0200 (CEST)
In-Reply-To: <20190522145505.257961-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: remove unused DAPM pins

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 108d0d40b932f80fc7f1dbd1de548d666e649a4b Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 22 May 2019 22:55:05 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: remove unused DAPM pins

Kernel emits the following messages when booting.
ASoC: DAPM unknown pin Headset Mic
ASoC: DAPM unknown pin Headphone

Remove the unused DAPM pins.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
