From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 1/2] ASoC: img-spdif-in: Add suspend / resume
	handling
Date: Mon,  2 Oct 2017 11:01:17 +0100
Message-ID: <1506938478-747-2-git-send-email-ed.blake@sondrel.com>
References: <1506938478-747-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0085.outbound.protection.outlook.com [104.47.2.85])
 by alsa0.perex.cz (Postfix) with ESMTP id ED79D267211
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:01:45 +0200 (CEST)
In-Reply-To: <1506938478-747-1-git-send-email-ed.blake@sondrel.com>
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
 sound/soc/img/img-spdif-in.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index 8adfd65..d74bcc5 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -82,6 +82,8 @@ struct img_spdif_in {
 	unsigned int single_freq;
 	unsigned int multi_freqs[IMG_SPDIF_IN_NUM_ACLKGEN];
 	bool active;
+	u32 suspend_clkgen;
+	u32 suspend_ctl;
 
 	/* Write-only registers */
 	unsigned int aclkgen_regs[IMG_SPDIF_IN_NUM_ACLKGEN];
@@ -676,8 +678,38 @@ static int img_spdif_in_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int img_spdif_in_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(dai);
+
+	spdif->suspend_clkgen = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CLKGEN);
+	spdif->suspend_ctl = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CTL);
+
+	clk_disable_unprepare(spdif->clk_sys);
+
+	return 0;
+}
+
+static int img_spdif_in_dai_resume(struct snd_soc_dai *dai)
+{
+	struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(dai);
+	int i;
+
+	clk_prepare_enable(spdif->clk_sys);
+
+	for (i = 0; i < IMG_SPDIF_IN_NUM_ACLKGEN; i++)
+		img_spdif_in_aclkgen_writel(spdif, i);
+
+	img_spdif_in_writel(spdif, spdif->suspend_clkgen, IMG_SPDIF_IN_CLKGEN);
+	img_spdif_in_writel(spdif, spdif->suspend_ctl, IMG_SPDIF_IN_CTL);
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver img_spdif_in_dai = {
 	.probe = img_spdif_in_dai_probe,
+	.suspend = img_spdif_in_dai_suspend,
+	.resume = img_spdif_in_dai_resume,
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-- 
1.9.1
