From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Convert WM9081 SYSCLK configuration
	to be device wide
Date: Mon,  7 Mar 2011 21:07:19 +0000
Message-ID: <1299532039-10637-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299532039-10637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EC9F10381C
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 22:07:01 +0100 (CET)
In-Reply-To: <1299532039-10637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Also respace the CODEC ops a bit for legibility.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 8b1b2c9..effaf75 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1140,10 +1140,9 @@ static int wm9081_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	return 0;
 }
 
-static int wm9081_set_sysclk(struct snd_soc_dai *codec_dai,
+static int wm9081_set_sysclk(struct snd_soc_codec *codec,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
 
 	switch (clk_id) {
@@ -1208,7 +1207,6 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 
 static struct snd_soc_dai_ops wm9081_dai_ops = {
 	.hw_params = wm9081_hw_params,
-	.set_sysclk = wm9081_set_sysclk,
 	.set_fmt = wm9081_set_dai_fmt,
 	.digital_mute = wm9081_digital_mute,
 	.set_tdm_slot = wm9081_set_tdm_slot,
@@ -1324,11 +1322,15 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.remove = 	wm9081_remove,
 	.suspend =	wm9081_suspend,
 	.resume =	wm9081_resume,
+
+	.set_sysclk = wm9081_set_sysclk,
 	.set_bias_level = wm9081_set_bias_level,
+
 	.reg_cache_size = ARRAY_SIZE(wm9081_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm9081_reg_defaults,
 	.volatile_register = wm9081_volatile_register,
+
 	.dapm_widgets	  = wm9081_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm9081_dapm_widgets),
 	.dapm_routes     = wm9081_audio_paths,
-- 
1.7.2.3
