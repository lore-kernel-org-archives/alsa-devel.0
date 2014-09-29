From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: wm8{350, 753,
	971}: Use snd_soc_dapm_to_codec() instead of dapm->codec
Date: Mon, 29 Sep 2014 11:40:40 +0200
Message-ID: <1411983642-12793-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-039.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F48B2605C1
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 11:40:32 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The CODEC struct in the snd_soc_dapm_context struct is deprecated and
scheduled for removal. Use the snd_soc_dapm_to_codec() function instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8350.c | 2 +-
 sound/soc/codecs/wm8753.c | 2 +-
 sound/soc/codecs/wm8971.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3dfdcc4..628ec77 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -212,7 +212,7 @@ static void wm8350_pga_work(struct work_struct *work)
 {
 	struct snd_soc_dapm_context *dapm =
 	    container_of(work, struct snd_soc_dapm_context, delayed_work.work);
-	struct snd_soc_codec *codec = dapm->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_data->out1,
 	    *out2 = &wm8350_data->out2;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index e54e097..21ca3a9 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1433,7 +1433,7 @@ static void wm8753_work(struct work_struct *work)
 	struct snd_soc_dapm_context *dapm =
 		container_of(work, struct snd_soc_dapm_context,
 			     delayed_work.work);
-	struct snd_soc_codec *codec = dapm->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	wm8753_set_bias_level(codec, dapm->bias_level);
 }
 
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 0499cd4..39ddb9b 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -615,7 +615,7 @@ static void wm8971_work(struct work_struct *work)
 	struct snd_soc_dapm_context *dapm =
 		container_of(work, struct snd_soc_dapm_context,
 			     delayed_work.work);
-	struct snd_soc_codec *codec = dapm->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	wm8971_set_bias_level(codec, codec->dapm.bias_level);
 }
 
-- 
1.8.0
