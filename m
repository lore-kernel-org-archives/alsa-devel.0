From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: [RFC PATCH] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Sun, 13 Jan 2019 22:16:21 +0200
Message-ID: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B25D2669BD
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2019 21:16:24 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id b14so17069584edt.6
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2019 12:16:24 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

>From 5e6ad135fd063d4b22cd962de43499a161bbc7db Mon Sep 17 00:00:00 2001
From: Dimitris Papavasiliou <dpapavas@gmail.com>
Date: Fri, 11 Jan 2019 22:13:27 +0200
Subject: [RFC PATCH] ASoC: pcm512x: Implement the set_bclk_ratio interface

Some boards, such as the HiFiBerry DAC+ Pro, use a pair of external
oscillators, to generate 44.1 or 48kHz multiples and are forced to
resort to hacks[1] in order to support 24-bit data without ending up
with fractional dividers.  This patch allows the machine driver to use
32-bit frames for 24-bit data to avoid such issues.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143442.html

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
---

Notes:
    The patch also includes a related change in the calculation of the
    bclk divider.  The current calculation is not very clear to me, as I
    can't find much concrete information on what this sample rate fraction
    is, how it's calculated and how, therefore, its denominator would fit
    into the calculation.  It also yields slightly wrong dividers in
    certain cases, which the machine driver for my HiFiBerry DAC+ Pro
    board seemingly tries to circumvent, by updating the rate fraction so
    as to suit this calculation.
    
    The updated calculation seems to work fine in my tests and, as far as
    I can see, should correctly yield the smallest bit clock rate that
    would fit the frame.  Please comment if anything looks off.

 sound/soc/codecs/pcm512x.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4cc24a5d5c31..8cd728f9a1eb 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -55,6 +55,7 @@ struct pcm512x_priv {
 	unsigned long overclock_dsp;
 	int mute;
 	struct mutex mutex;
+	unsigned int bclk_ratio;
 };
 
 /*
@@ -915,16 +916,21 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 	int fssp;
 	int gpio;
 
-	lrclk_div = snd_soc_params_to_frame_size(params);
-	if (lrclk_div == 0) {
-		dev_err(dev, "No LRCLK?\n");
-		return -EINVAL;
+	if (pcm512x->bclk_ratio > 0) {
+		lrclk_div = pcm512x->bclk_ratio;
+	} else {
+		lrclk_div = snd_soc_params_to_frame_size(params);
+
+		if (lrclk_div == 0) {
+			dev_err(dev, "No LRCLK?\n");
+			return -EINVAL;
+		}
 	}
 
 	if (!pcm512x->pll_out) {
 		sck_rate = clk_get_rate(pcm512x->sclk);
-		bclk_div = params->rate_den * 64 / lrclk_div;
-		bclk_rate = DIV_ROUND_CLOSEST(sck_rate, bclk_div);
+		bclk_rate = params_rate(params) * lrclk_div;
+		bclk_div = DIV_ROUND_CLOSEST(sck_rate, bclk_rate);
 
 		mck_rate = sck_rate;
 	} else {
@@ -1383,6 +1389,16 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int pcm512x_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+
+	pcm512x->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int pcm512x_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1435,6 +1451,7 @@ static const struct snd_soc_dai_ops pcm512x_dai_ops = {
 	.hw_params = pcm512x_hw_params,
 	.set_fmt = pcm512x_set_fmt,
 	.digital_mute = pcm512x_digital_mute,
+	.set_bclk_ratio = pcm512x_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver pcm512x_dai = {
-- 
2.11.0
