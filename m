From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Ensure proper sample
 rate on pri/sec PCM
Date: Thu, 14 Feb 2019 17:00:11 +0100
Message-ID: <20190214160011.3940-1-s.nawrocki@samsung.com>
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B766C267A41
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 17:00:42 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

Currently when playing sound with different sample rates actual
sample rate will be determined by audio stream which starts first
on either primary or secondary PCM. The audio root clock will be
configured appropriately only for the first stream. As the hardware
is limited to same sample rate on both interfaces we need to disallow
streams with different sample rates. It is done by this patch by
returning error in FE hw_params if there is already active stream
running with different sample rate.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 18bb3bfe0300..941e8c3f67a4 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -20,6 +20,11 @@ struct odroid_priv {
 	struct snd_soc_card card;
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
+
+	/* Spinlock protecting fields below */
+	spinlock_t lock;
+	unsigned int be_sample_rate;
+	bool be_active;
 };
 
 static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
@@ -31,8 +36,25 @@ static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int odroid_card_fe_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->be_active && priv->be_sample_rate != params_rate(params))
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
 static const struct snd_soc_ops odroid_card_fe_ops = {
 	.startup = odroid_card_fe_startup,
+	.hw_params = odroid_card_fe_hw_params,
 };
 
 static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
@@ -41,6 +63,7 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	unsigned int pll_freq, rclk_freq, rfs;
+	unsigned long flags;
 	int ret;
 
 	switch (params_rate(params)) {
@@ -87,11 +110,43 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->be_sample_rate = params_rate(params);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int odroid_card_be_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->be_active = true;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->be_active = false;
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return 0;
 }
 
 static const struct snd_soc_ops odroid_card_be_ops = {
 	.hw_params = odroid_card_be_hw_params,
+	.trigger = odroid_card_be_trigger,
 };
 
 static struct snd_soc_dai_link odroid_card_dais[] = {
@@ -150,6 +205,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	card->owner = THIS_MODULE;
 	card->fully_routed = true;
 
+	spin_lock_init(&priv->lock);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_of_parse_card_name(card, "model");
-- 
2.17.1
