From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v4 1/9] ASoC: rt5514: Avoid legacy dai naming
Date: Fri, 18 Aug 2017 11:11:39 +0800
Message-ID: <20170818031147.16810-2-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Currently we are using devm_snd_soc_register_component, which would
use legacy dai naming when dai drv id is zero.

Set a non-zero dai drv id to use dai drv name for dai name.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4:
Use non-zero drv id to avoid legacy dai naming instead of switching to
snd_soc_register_codec.

Changes in v3: None
Changes in v2: None

 sound/soc/codecs/rt5514-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 640193d845be..4eb08f636f93 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -62,7 +62,7 @@ static const struct snd_pcm_hardware rt5514_spi_pcm_hardware = {
 
 static struct snd_soc_dai_driver rt5514_spi_dai = {
 	.name = "rt5514-dsp-cpu-dai",
-	.id = 0,
+	.id = 1, /* Set a non-zero drv id to avoid legacy dai naming */
 	.capture = {
 		.stream_name = "DSP Capture",
 		.channels_min = 1,
-- 
2.11.0
