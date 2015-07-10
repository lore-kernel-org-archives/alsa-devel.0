From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix error path in codec probe
Date: Fri, 10 Jul 2015 14:37:25 +0100
Message-ID: <1436535445-32176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B1902665C2
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 15:53:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If we fail to add some DSPs or fail to add the controls we should call
wm_adsp2_codec_remove for all the cores we have already added. This
patch fixes this up on the wm5102 and wm5110.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    7 ++++++-
 sound/soc/codecs/wm5110.c |   10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 6ddee99..64637d1 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1879,7 +1879,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	ret = snd_soc_add_codec_controls(codec,
 					 arizona_adsp2_rate_controls, 1);
 	if (ret)
-		return ret;
+		goto err_adsp2_codec_probe;
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
@@ -1889,6 +1889,11 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	priv->core.arizona->dapm = dapm;
 
 	return 0;
+
+err_adsp2_codec_probe:
+	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
+
+	return ret;
 }
 
 static int wm5102_codec_remove(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 429be44..df6a998 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1874,18 +1874,24 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
 		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
 		if (ret)
-			return ret;
+			goto err_adsp2_codec_probe;
 	}
 
 	ret = snd_soc_add_codec_controls(codec,
 					 arizona_adsp2_rate_controls,
 					 WM5110_NUM_ADSP);
 	if (ret)
-		return ret;
+		goto err_adsp2_codec_probe;
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
 	return 0;
+
+err_adsp2_codec_probe:
+	for (--i; i >= 0; --i)
+		wm_adsp2_codec_remove(&priv->core.adsp[i], codec);
+
+	return ret;
 }
 
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
-- 
1.7.2.5
