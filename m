From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 1/2] ASoC: img-i2s-in: Add suspend / resume
	handling
Date: Mon,  2 Oct 2017 10:58:52 +0100
Message-ID: <1506938333-550-2-git-send-email-ed.blake@sondrel.com>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0075.outbound.protection.outlook.com [104.47.1.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C7FC2670B0
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 11:59:14 +0200 (CEST)
In-Reply-To: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Implement ASoC suspend and resume callbacks to save and restore
register state, to support platforms where the power is disabled
during suspend.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-i2s-in.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 567f976..ebed04d 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -60,6 +60,8 @@ struct img_i2s_in {
 	void __iomem *channel_base;
 	unsigned int active_channels;
 	struct snd_soc_dai_driver dai_driver;
+	u32 suspend_ctl;
+	u32 *suspend_ch_ctl;
 };
 
 static inline void img_i2s_in_writel(struct img_i2s_in *i2s, u32 val, u32 reg)
@@ -360,6 +362,42 @@ static int img_i2s_in_dai_probe(struct snd_soc_dai *dai)
 	.name = "img-i2s-in"
 };
 
+static int img_i2s_in_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct img_i2s_in *i2s = snd_soc_dai_get_drvdata(dai);
+	int i;
+	u32 reg;
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = img_i2s_in_ch_readl(i2s, i, IMG_I2S_IN_CH_CTL);
+		i2s->suspend_ch_ctl[i] = reg;
+	}
+
+	i2s->suspend_ctl = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
+
+	clk_disable_unprepare(i2s->clk_sys);
+
+	return 0;
+}
+
+static int img_i2s_in_dai_resume(struct snd_soc_dai *dai)
+{
+	struct img_i2s_in *i2s = snd_soc_dai_get_drvdata(dai);
+	int i;
+	u32 reg;
+
+	clk_prepare_enable(i2s->clk_sys);
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = i2s->suspend_ch_ctl[i];
+		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
+	}
+
+	img_i2s_in_writel(i2s, i2s->suspend_ctl, IMG_I2S_IN_CTL);
+
+	return 0;
+}
+
 static int img_i2s_in_dma_prepare_slave_config(struct snd_pcm_substream *st,
 	struct snd_pcm_hw_params *params, struct dma_slave_config *sc)
 {
@@ -436,6 +474,8 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	i2s->dma_data.addr_width = 4;
 
 	i2s->dai_driver.probe = img_i2s_in_dai_probe;
+	i2s->dai_driver.suspend = img_i2s_in_dai_suspend;
+	i2s->dai_driver.resume = img_i2s_in_dai_resume;
 	i2s->dai_driver.capture.channels_min = 2;
 	i2s->dai_driver.capture.channels_max = i2s->max_i2s_chan * 2;
 	i2s->dai_driver.capture.rates = SNDRV_PCM_RATE_8000_192000;
@@ -469,6 +509,13 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 			IMG_I2S_IN_CH_CTL_JUST_MASK |
 			IMG_I2S_IN_CH_CTL_FW_MASK, IMG_I2S_IN_CH_CTL);
 
+	i2s->suspend_ch_ctl = devm_kzalloc(dev,
+		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
+	if (!i2s->suspend_ch_ctl) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
 	ret = devm_snd_soc_register_component(dev, &img_i2s_in_component,
 						&i2s->dai_driver, 1);
 	if (ret)
-- 
1.9.1
