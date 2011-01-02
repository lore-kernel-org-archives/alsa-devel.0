From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] ALSA: ASoC: Fix SmartQ compilation
Date: Sun, 02 Jan 2011 20:48:23 +0100
Message-ID: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A2A5246B3
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 20:48:28 +0100 (CET)
Received: by eyg24 with SMTP id 24so5447036eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Jan 2011 11:48:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

This makes the SmartQ sound driver compile again with recent ASoC changes.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 sound/soc/s3c24xx/smartq_wm8987.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index dd20ca7..aef94c7 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -39,8 +39,8 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct s3c_i2sv2_rate_calc div;
 	unsigned int clk = 0;
 	int ret;
@@ -156,8 +156,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"LINPUT2", NULL, "Mic Bias"},
 };
 
-static int smartq_wm8987_init(struct snd_soc_codec *codec)
+static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int err = 0;
 
 	/* Add SmartQ specific widgets */
@@ -190,8 +191,8 @@ static int smartq_wm8987_init(struct snd_soc_codec *codec)
 		return err;
 
 	/* Headphone jack detection */
-	err = snd_soc_jack_new(&snd_soc_smartq, "Headphone Jack",
-			       SND_JACK_HEADPHONE, &smartq_jack);
+	err = snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
+			       &smartq_jack);
 	if (err)
 		return err;
 
-- 
1.7.1
