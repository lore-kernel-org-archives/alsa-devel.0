From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm512x: Implement the set_bclk_ratio
	interface" to the asoc tree
Date: Mon, 28 Jan 2019 12:35:22 +0000 (GMT)
Message-ID: <20190128123522.9A20B1127D29@debutante.sirena.org.uk>
References: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D862674B8
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:23 +0100 (CET)
In-Reply-To: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm512x: Implement the set_bclk_ratio interface

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ccc8d6c7b6d2f521a4b10c7f6d027f46c7a686bf Mon Sep 17 00:00:00 2001
From: Dimitris Papavasiliou <dpapavas@gmail.com>
Date: Sat, 26 Jan 2019 15:17:01 +0200
Subject: [PATCH] ASoC: pcm512x: Implement the set_bclk_ratio interface

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4cc24a5d5c31..ce8c5dbd2164 100644
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
@@ -1435,6 +1454,7 @@ static const struct snd_soc_dai_ops pcm512x_dai_ops = {
 	.hw_params = pcm512x_hw_params,
 	.set_fmt = pcm512x_set_fmt,
 	.digital_mute = pcm512x_digital_mute,
+	.set_bclk_ratio = pcm512x_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver pcm512x_dai = {
-- 
2.20.1
