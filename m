From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/14] ASoC: wm9713: Use table based control
	setup
Date: Thu, 30 Oct 2014 21:01:08 +0100
Message-ID: <1414699271-22797-12-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 85EAB265372
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:21 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 38e17d4..ba8c276 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1216,9 +1216,6 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
 	ac97_write(codec, AC97_CD, reg);
 
-	snd_soc_add_codec_controls(codec, wm9713_snd_ac97_controls,
-				ARRAY_SIZE(wm9713_snd_ac97_controls));
-
 	return 0;
 
 reset_err:
@@ -1248,6 +1245,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9713_reg,
+
+	.controls = wm9713_snd_ac97_controls,
+	.num_controls = ARRAY_SIZE(wm9713_snd_ac97_controls),
 	.dapm_widgets = wm9713_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm9713_dapm_widgets),
 	.dapm_routes = wm9713_audio_map,
-- 
1.8.0
