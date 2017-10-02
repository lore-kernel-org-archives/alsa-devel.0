From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 2/3] ASoC: img-spdif-out: Add suspend / resume
	handling
Date: Mon,  2 Oct 2017 11:01:56 +0100
Message-ID: <1506938517-810-3-git-send-email-ed.blake@sondrel.com>
References: <1506938517-810-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0075.outbound.protection.outlook.com [104.47.0.75])
 by alsa0.perex.cz (Postfix) with ESMTP id AC443266D6C
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:02:19 +0200 (CEST)
In-Reply-To: <1506938517-810-1-git-send-email-ed.blake@sondrel.com>
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
 sound/soc/img/img-spdif-out.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 416aa57..8123e2a 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -47,6 +47,9 @@ struct img_spdif_out {
 	struct snd_dmaengine_dai_dma_data dma_data;
 	struct device *dev;
 	struct reset_control *rst;
+	u32 suspend_ctl;
+	u32 suspend_csl;
+	u32 suspend_csh;
 };
 
 static int img_spdif_out_runtime_suspend(struct device *dev)
@@ -296,8 +299,49 @@ static int img_spdif_out_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int img_spdif_out_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct img_spdif_out *spdif = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	if (pm_runtime_status_suspended(spdif->dev)) {
+		ret = img_spdif_out_runtime_resume(spdif->dev);
+		if (ret)
+			return ret;
+	}
+
+	spdif->suspend_ctl = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CTL);
+	spdif->suspend_csl = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CSL);
+	spdif->suspend_csh = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CSH_UV);
+
+	img_spdif_out_runtime_suspend(spdif->dev);
+
+	return 0;
+}
+
+static int img_spdif_out_dai_resume(struct snd_soc_dai *dai)
+{
+	struct img_spdif_out *spdif = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = img_spdif_out_runtime_resume(spdif->dev);
+	if (ret)
+		return ret;
+
+	img_spdif_out_writel(spdif, spdif->suspend_ctl, IMG_SPDIF_OUT_CTL);
+	img_spdif_out_writel(spdif, spdif->suspend_csl, IMG_SPDIF_OUT_CSL);
+	img_spdif_out_writel(spdif, spdif->suspend_csh, IMG_SPDIF_OUT_CSH_UV);
+
+	if (pm_runtime_status_suspended(spdif->dev))
+		img_spdif_out_runtime_suspend(spdif->dev);
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver img_spdif_out_dai = {
 	.probe = img_spdif_out_dai_probe,
+	.suspend = img_spdif_out_dai_suspend,
+	.resume = img_spdif_out_dai_resume,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-- 
1.9.1
