From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/9] ASoC: codecs: wm8741: Fix register cache incoherency
Date: Tue, 28 Dec 2010 21:37:58 +0100
Message-ID: <1293568684-9626-5-git-send-email-lars@metafoo.de>
References: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The multi-component patch(commit f0fba2ad1) moved the allocation of the
register cache from the driver to the ASoC core. Most drivers where adjusted to
this, but the wm8741 driver still uses its own register cache for its
private functions, while functions from the ASoC core use the generic cache.
Thus we end up with two from each other incoherent caches, which can lead to
undefined behaviour.
This patch fixes the issue by changing the wm8741 driver to use the
generic register cache in its private functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

---
Compile tested only
---
 sound/soc/codecs/wm8741.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 90e31e9..aea60ef 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -41,7 +41,6 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8741_priv {
 	enum snd_soc_control_type control_type;
-	u16 reg_cache[WM8741_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
@@ -422,6 +421,7 @@ static int wm8741_resume(struct snd_soc_codec *codec)
 static int wm8741_probe(struct snd_soc_codec *codec)
 {
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+	u16 *reg_cache = codec->reg_cache;
 	int ret = 0;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8741->control_type);
@@ -437,10 +437,10 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Change some default settings - latch VU */
-	wm8741->reg_cache[WM8741_DACLLSB_ATTENUATION] |= WM8741_UPDATELL;
-	wm8741->reg_cache[WM8741_DACLMSB_ATTENUATION] |= WM8741_UPDATELM;
-	wm8741->reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERL;
-	wm8741->reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERM;
+	reg_cache[WM8741_DACLLSB_ATTENUATION] |= WM8741_UPDATELL;
+	reg_cache[WM8741_DACLMSB_ATTENUATION] |= WM8741_UPDATELM;
+	reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERL;
+	reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERM;
 
 	snd_soc_add_controls(codec, wm8741_snd_controls,
 			     ARRAY_SIZE(wm8741_snd_controls));
-- 
1.7.2.3
