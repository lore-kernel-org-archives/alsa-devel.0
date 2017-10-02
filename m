From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 2/3] ASoC: img-i2s-out: Add suspend / resume
	handling
Date: Mon,  2 Oct 2017 10:59:46 +0100
Message-ID: <1506938387-627-3-git-send-email-ed.blake@sondrel.com>
References: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B3222671C3
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:00:02 +0200 (CEST)
In-Reply-To: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
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
 sound/soc/img/img-i2s-out.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index adc6902..f1c3b48 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -63,6 +63,8 @@ struct img_i2s_out {
 	unsigned int active_channels;
 	struct reset_control *rst;
 	struct snd_soc_dai_driver dai_driver;
+	u32 suspend_ctl;
+	u32 *suspend_ch_ctl;
 };
 
 static int img_i2s_out_runtime_suspend(struct device *dev)
@@ -382,6 +384,53 @@ static int img_i2s_out_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int img_i2s_out_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct img_i2s_out *i2s = snd_soc_dai_get_drvdata(dai);
+	int i, ret;
+	u32 reg;
+
+	if (pm_runtime_status_suspended(i2s->dev)) {
+		ret = img_i2s_out_runtime_resume(i2s->dev);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = img_i2s_out_ch_readl(i2s, i, IMG_I2S_OUT_CH_CTL);
+		i2s->suspend_ch_ctl[i] = reg;
+	}
+
+	i2s->suspend_ctl = img_i2s_out_readl(i2s, IMG_I2S_OUT_CTL);
+
+	img_i2s_out_runtime_suspend(i2s->dev);
+
+	return 0;
+}
+
+static int img_i2s_out_dai_resume(struct snd_soc_dai *dai)
+{
+	struct img_i2s_out *i2s = snd_soc_dai_get_drvdata(dai);
+	int i, ret;
+	u32 reg;
+
+	ret = img_i2s_out_runtime_resume(i2s->dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = i2s->suspend_ch_ctl[i];
+		img_i2s_out_ch_writel(i2s, i, reg, IMG_I2S_OUT_CH_CTL);
+	}
+
+	img_i2s_out_writel(i2s, i2s->suspend_ctl, IMG_I2S_OUT_CTL);
+
+	if (pm_runtime_status_suspended(i2s->dev))
+		img_i2s_out_runtime_suspend(i2s->dev);
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver img_i2s_out_component = {
 	.name = "img-i2s-out"
 };
@@ -471,6 +520,13 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	i2s->suspend_ch_ctl = devm_kzalloc(dev,
+		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
+	if (!i2s->suspend_ch_ctl) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
 	reg = IMG_I2S_OUT_CTL_FRM_SIZE_MASK;
 	img_i2s_out_writel(i2s, reg, IMG_I2S_OUT_CTL);
 
@@ -497,6 +553,8 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 	i2s->dma_data.maxburst = 4;
 
 	i2s->dai_driver.probe = img_i2s_out_dai_probe;
+	i2s->dai_driver.suspend = img_i2s_out_dai_suspend;
+	i2s->dai_driver.resume = img_i2s_out_dai_resume;
 	i2s->dai_driver.playback.channels_min = 2;
 	i2s->dai_driver.playback.channels_max = i2s->max_i2s_chan * 2;
 	i2s->dai_driver.playback.rates = SNDRV_PCM_RATE_8000_192000;
@@ -520,6 +578,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 		img_i2s_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+err_clk_disable:
 	clk_disable_unprepare(i2s->clk_sys);
 
 	return ret;
-- 
1.9.1
