From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add WM8958 based headset detection on
	Littlemill
Date: Fri,  2 Dec 2011 15:56:21 +0000
Message-ID: <1322841381-28364-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E427E24549
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 16:56:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The board supports CODECs that won't work with this but the CODEC driver
will check to see if it's running on the right chip for us.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index d2a44ab..5d7680f 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -154,8 +154,11 @@ static struct snd_soc_dapm_route audio_paths[] = {
 	{ "Headphone", NULL, "HPOUT1R" },
 };
 
+static struct snd_soc_jack littlemill_headset;
+
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
+	struct snd_soc_codec *codec = card->rtd[0].codec;
 	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
 	int ret;
 
@@ -164,6 +167,18 @@ static int littlemill_late_probe(struct snd_soc_card *card)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_jack_new(codec, "Headset",
+			       SND_JACK_HEADSET | SND_JACK_MECHANICAL |
+			       SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			       SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+			       SND_JACK_BTN_4 | SND_JACK_BTN_5,
+			       &littlemill_headset);
+	if (ret)
+		return ret;
+
+	/* This will check device compatibility itself */
+	wm8958_mic_detect(codec, &littlemill_headset, NULL, NULL);
+
 	return 0;
 }
 
-- 
1.7.7.3
