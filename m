From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: max98090: Add recovery for PLL lock
	failure
Date: Wed,  3 Sep 2014 15:42:48 +0300
Message-ID: <1409748168-21992-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 444C326564D
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 14:44:18 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

All MAX98090 input clocks MCLK, LRCLK and BCLK must be running and stable
before powering on the codec in slave mode. Otherwise the PLL may not lock
to LRCLK causing silence in playback and capture. How often that happens is
somewhat hardware and clock configuration specific.

Now if wanting to follow strictly this clocks must be active before
powering the codec on requirement we should have a notification from DAI
driver to codec driver when clocks are activated and take codec out of
shutdown only after that. Plus take care of possible active bypass paths.

However, when PLL unlock occurs, MAX98090 asserts the PLL Unlock Flag which
can be configured as an IRQ source. This allows to workaround around the
issue by toggling the codec power shortly in case of PLL lock failure.

In order to prevent needlessly toggling codec power in case of short PLL
unlocks at the beginning of stream this patch implements delayed activation
for PLL unlock interrupt. Then workaround is run only when the PLL doesn't
lock at all.

Power toggling workaround for PLL unlock comes originally from
Liam Girdwood <liam.r.girdwood@linux.intel.com> and delayed activation from
me.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
For normal development cycle. We have observed this on a byt-max98090 based
machine earlier when another MCLK rate was showing silent audio occasionally
but with current 25 MHz MCLK it either doesn't occur or is much more rare.
I'm not sure is this needed but wanted to share it if tegra_max98090 for
instance have noticed it.
---
 sound/soc/codecs/max98090.c | 111 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/max98090.h |   3 ++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 4a063fa88526..f1543653a699 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1972,6 +1972,102 @@ static int max98090_dai_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	return 0;
 }
 
+static int max98090_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!max98090->master && dai->active == 1)
+			queue_delayed_work(system_power_efficient_wq,
+					   &max98090->pll_det_enable_work,
+					   msecs_to_jiffies(10));
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (!max98090->master && dai->active == 1)
+			schedule_work(&max98090->pll_det_disable_work);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void max98090_pll_det_enable_work(struct work_struct *work)
+{
+	struct max98090_priv *max98090 =
+		container_of(work, struct max98090_priv,
+			     pll_det_enable_work.work);
+	struct snd_soc_codec *codec = max98090->codec;
+	unsigned int status, mask;
+
+	/*
+	 * Clear status register in order to clear possibly already occurred
+	 * PLL unlock. If PLL hasn't still locked, the status will be set
+	 * again and PLL unlock interrupt will occur.
+	 * Note this will clear all status bits
+	 */
+	regmap_read(max98090->regmap, M98090_REG_DEVICE_STATUS, &status);
+
+	/*
+	 * Queue jack work in case jack state has just changed but handler
+	 * hasn't run yet
+	 */
+	regmap_read(max98090->regmap, M98090_REG_INTERRUPT_S, &mask);
+	status &= mask;
+	if (status & M98090_JDET_MASK)
+		queue_delayed_work(system_power_efficient_wq,
+				   &max98090->jack_work,
+				   msecs_to_jiffies(100));
+
+	/* Enable PLL unlock interrupt */
+	snd_soc_update_bits(codec, M98090_REG_INTERRUPT_S,
+			    M98090_IULK_MASK,
+			    1 << M98090_IULK_SHIFT);
+}
+
+static void max98090_pll_det_disable_work(struct work_struct *work)
+{
+	struct max98090_priv *max98090 =
+		container_of(work, struct max98090_priv, pll_det_disable_work);
+	struct snd_soc_codec *codec = max98090->codec;
+
+	cancel_delayed_work_sync(&max98090->pll_det_enable_work);
+
+	/* Disable PLL unlock interrupt */
+	snd_soc_update_bits(codec, M98090_REG_INTERRUPT_S,
+			    M98090_IULK_MASK, 0);
+}
+
+static void max98090_pll_work(struct work_struct *work)
+{
+	struct max98090_priv *max98090 =
+		container_of(work, struct max98090_priv, pll_work);
+	struct snd_soc_codec *codec = max98090->codec;
+
+	if (!snd_soc_codec_is_active(codec))
+		return;
+
+	dev_info(codec->dev, "PLL unlocked\n");
+
+	/* Toggle shutdown OFF then ON */
+	snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
+			    M98090_SHDNN_MASK, 0);
+	msleep(10);
+	snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
+			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
+
+	/* Give PLL time to lock */
+	msleep(10);
+}
+
 static void max98090_jack_work(struct work_struct *work)
 {
 	struct max98090_priv *max98090 = container_of(work,
@@ -2103,8 +2199,10 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 	if (active & M98090_SLD_MASK)
 		dev_dbg(codec->dev, "M98090_SLD_MASK\n");
 
-	if (active & M98090_ULK_MASK)
-		dev_err(codec->dev, "M98090_ULK_MASK\n");
+	if (active & M98090_ULK_MASK) {
+		dev_dbg(codec->dev, "M98090_ULK_MASK\n");
+		schedule_work(&max98090->pll_work);
+	}
 
 	if (active & M98090_JDET_MASK) {
 		dev_dbg(codec->dev, "M98090_JDET_MASK\n");
@@ -2177,6 +2275,7 @@ static struct snd_soc_dai_ops max98090_dai_ops = {
 	.set_tdm_slot = max98090_set_tdm_slot,
 	.hw_params = max98090_dai_hw_params,
 	.digital_mute = max98090_dai_digital_mute,
+	.trigger = max98090_dai_trigger,
 };
 
 static struct snd_soc_dai_driver max98090_dai[] = {
@@ -2258,6 +2357,11 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	max98090->jack_state = M98090_JACK_STATE_NO_HEADSET;
 
 	INIT_DELAYED_WORK(&max98090->jack_work, max98090_jack_work);
+	INIT_DELAYED_WORK(&max98090->pll_det_enable_work,
+			  max98090_pll_det_enable_work);
+	INIT_WORK(&max98090->pll_det_disable_work,
+		  max98090_pll_det_disable_work);
+	INIT_WORK(&max98090->pll_work, max98090_pll_work);
 
 	/* Enable jack detection */
 	snd_soc_write(codec, M98090_REG_JACK_DETECT,
@@ -2310,6 +2414,9 @@ static int max98090_remove(struct snd_soc_codec *codec)
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
 
 	cancel_delayed_work_sync(&max98090->jack_work);
+	cancel_delayed_work_sync(&max98090->pll_det_enable_work);
+	cancel_work_sync(&max98090->pll_det_disable_work);
+	cancel_work_sync(&max98090->pll_work);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index cf1b6062ba8c..14427a566f41 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1532,6 +1532,9 @@ struct max98090_priv {
 	int irq;
 	int jack_state;
 	struct delayed_work jack_work;
+	struct delayed_work pll_det_enable_work;
+	struct work_struct pll_det_disable_work;
+	struct work_struct pll_work;
 	struct snd_soc_jack *jack;
 	unsigned int dai_fmt;
 	int tdm_slots;
-- 
2.1.0
