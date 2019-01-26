From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: [PATCH 1/2] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Sat, 26 Jan 2019 15:17:01 +0200
Message-ID: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 52981267418
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 14:17:05 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id y20so9469179edw.9
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 05:17:05 -0800 (PST)
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Some boards, such as the HiFiBerry DAC+ Pro, use a pair of external
oscillators, to generate 44.1 or 48kHz multiples and are forced to
resort to hacks [1] in order to support 24-bit data without ending up
with fractional dividers.  This patch allows the machine driver to use
32-bit frames for 24-bit data to avoid such issues.

Although the datasheet (p. 15) seems to suggest that only a handful
of ratios are supported, it's not very explicit about it, so we allow
the full range of values supported by the underlying register in the
callback, to avoid needlessly rejecting potentially usable
configurations.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143442.html

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
---

Notes:
    This is essentially the same patch submitted previously as an RFC[1].
    It has been split in two, in order to separate the set_bclk_ratio
    implementation from the clocking calculation fix and some conservative
    checking has been added to the argument of the callback.
    
    [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144213.html

 sound/soc/codecs/pcm512x.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 6cb1653be804..b63d9392bae3 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -55,6 +55,7 @@ struct pcm512x_priv {
 	unsigned long overclock_dsp;
 	int mute;
 	struct mutex mutex;
+	unsigned int bclk_ratio;
 };
 
 /*
@@ -915,10 +916,15 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
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
@@ -1383,6 +1389,19 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int pcm512x_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+
+	if (ratio > 256)
+		return -EINVAL;
+
+	pcm512x->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int pcm512x_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1438,6 +1457,7 @@ static const struct snd_soc_dai_ops pcm512x_dai_ops = {
 	.hw_params = pcm512x_hw_params,
 	.set_fmt = pcm512x_set_fmt,
 	.digital_mute = pcm512x_digital_mute,
+	.set_bclk_ratio = pcm512x_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver pcm512x_dai = {
-- 
2.11.0
