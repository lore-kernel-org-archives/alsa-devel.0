Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4698C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:07:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E54207D8
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u52zo861"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E54207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B90BC177C;
	Thu, 18 Jun 2020 14:06:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B90BC177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592482066;
	bh=jqjqre0clId/kbo1Jtdc+Ip14mbfvgPOw4KjqRYDz2E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u52zo861Sa5h2bTQgrP8d+tI1I9GkZmPLAxdwaj5Yt2bBHBcOeY+dOl9TSS+qc8sG
	 oF3tnHeBS4Hj8lH5ziGsXPvtfFBXiC51/pyi+U1PzjKSUYn7U8C3sjZtq9sgDYzcqh
	 8kqcm1yWuANJYkYJa1Qb0kdC+EM4QyiU19ub/lGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39560F8010E;
	Thu, 18 Jun 2020 14:06:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F2A0F80116; Thu, 18 Jun 2020 14:06:55 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7B49F800EF
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 14:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7B49F800EF
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E6402000A7;
 Thu, 18 Jun 2020 14:06:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2623200D40;
 Thu, 18 Jun 2020 14:06:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 412C94024F;
 Thu, 18 Jun 2020 20:06:38 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_spdif: Add pm runtime function
Date: Thu, 18 Jun 2020 19:55:34 +0800
Message-Id: <1592481334-3680-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add pm runtime support and move clock handling there.
Close the clocks at suspend to reduce the power consumption.

fsl_spdif_suspend is replaced by pm_runtime_force_suspend.
fsl_spdif_resume is replaced by pm_runtime_force_resume.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 113 ++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 46 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 5bc0e4729341..46719fd2f1ec 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/asoundef.h>
 #include <sound/dmaengine_pcm.h>
@@ -495,25 +496,10 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct regmap *regmap = spdif_priv->regmap;
 	u32 scr, mask;
-	int i;
 	int ret;
 
 	/* Reset module and interrupts only for first initialization */
 	if (!snd_soc_dai_active(cpu_dai)) {
-		ret = clk_prepare_enable(spdif_priv->coreclk);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to enable core clock\n");
-			return ret;
-		}
-
-		if (!IS_ERR(spdif_priv->spbaclk)) {
-			ret = clk_prepare_enable(spdif_priv->spbaclk);
-			if (ret) {
-				dev_err(&pdev->dev, "failed to enable spba clock\n");
-				goto err_spbaclk;
-			}
-		}
-
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
@@ -531,18 +517,10 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 		mask = SCR_TXFIFO_AUTOSYNC_MASK | SCR_TXFIFO_CTRL_MASK |
 			SCR_TXSEL_MASK | SCR_USRC_SEL_MASK |
 			SCR_TXFIFO_FSEL_MASK;
-		for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
-			ret = clk_prepare_enable(spdif_priv->txclk[i]);
-			if (ret)
-				goto disable_txclk;
-		}
 	} else {
 		scr = SCR_RXFIFO_FSEL_IF8 | SCR_RXFIFO_AUTOSYNC;
 		mask = SCR_RXFIFO_FSEL_MASK | SCR_RXFIFO_AUTOSYNC_MASK|
 			SCR_RXFIFO_CTL_MASK | SCR_RXFIFO_OFF_MASK;
-		ret = clk_prepare_enable(spdif_priv->rxclk);
-		if (ret)
-			goto err;
 	}
 	regmap_update_bits(regmap, REG_SPDIF_SCR, mask, scr);
 
@@ -551,15 +529,7 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 
-disable_txclk:
-	for (i--; i >= 0; i--)
-		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
-	if (!IS_ERR(spdif_priv->spbaclk))
-		clk_disable_unprepare(spdif_priv->spbaclk);
-err_spbaclk:
-	clk_disable_unprepare(spdif_priv->coreclk);
-
 	return ret;
 }
 
@@ -569,20 +539,17 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
 	struct regmap *regmap = spdif_priv->regmap;
-	u32 scr, mask, i;
+	u32 scr, mask;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		scr = 0;
 		mask = SCR_TXFIFO_AUTOSYNC_MASK | SCR_TXFIFO_CTRL_MASK |
 			SCR_TXSEL_MASK | SCR_USRC_SEL_MASK |
 			SCR_TXFIFO_FSEL_MASK;
-		for (i = 0; i < SPDIF_TXRATE_MAX; i++)
-			clk_disable_unprepare(spdif_priv->txclk[i]);
 	} else {
 		scr = SCR_RXFIFO_OFF | SCR_RXFIFO_CTL_ZERO;
 		mask = SCR_RXFIFO_FSEL_MASK | SCR_RXFIFO_AUTOSYNC_MASK|
 			SCR_RXFIFO_CTL_MASK | SCR_RXFIFO_OFF_MASK;
-		clk_disable_unprepare(spdif_priv->rxclk);
 	}
 	regmap_update_bits(regmap, REG_SPDIF_SCR, mask, scr);
 
@@ -591,9 +558,6 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
-		if (!IS_ERR(spdif_priv->spbaclk))
-			clk_disable_unprepare(spdif_priv->spbaclk);
-		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
 
@@ -1350,6 +1314,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	/* Register with ASoC */
 	dev_set_drvdata(&pdev->dev, spdif_priv);
+	pm_runtime_enable(&pdev->dev);
+	regcache_cache_only(spdif_priv->regmap, true);
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
 					      &spdif_priv->cpu_dai_drv, 1);
@@ -1365,36 +1331,91 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int fsl_spdif_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int fsl_spdif_runtime_suspend(struct device *dev)
 {
 	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
+	int i;
 
 	regmap_read(spdif_priv->regmap, REG_SPDIF_SRPC,
 			&spdif_priv->regcache_srpc);
-
 	regcache_cache_only(spdif_priv->regmap, true);
-	regcache_mark_dirty(spdif_priv->regmap);
+
+	clk_disable_unprepare(spdif_priv->rxclk);
+
+	for (i = 0; i < SPDIF_TXRATE_MAX; i++)
+		clk_disable_unprepare(spdif_priv->txclk[i]);
+
+	if (!IS_ERR(spdif_priv->spbaclk))
+		clk_disable_unprepare(spdif_priv->spbaclk);
+	clk_disable_unprepare(spdif_priv->coreclk);
 
 	return 0;
 }
 
-static int fsl_spdif_resume(struct device *dev)
+static int fsl_spdif_runtime_resume(struct device *dev)
 {
 	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
+	int ret;
+	int i;
+
+	ret = clk_prepare_enable(spdif_priv->coreclk);
+	if (ret) {
+		dev_err(dev, "failed to enable core clock\n");
+		return ret;
+	}
+
+	if (!IS_ERR(spdif_priv->spbaclk)) {
+		ret = clk_prepare_enable(spdif_priv->spbaclk);
+		if (ret) {
+			dev_err(dev, "failed to enable spba clock\n");
+			goto disable_core_clk;
+		}
+	}
+
+	for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
+		ret = clk_prepare_enable(spdif_priv->txclk[i]);
+		if (ret)
+			goto disable_spba_clk;
+	}
+
+	ret = clk_prepare_enable(spdif_priv->rxclk);
+	if (ret)
+		goto disable_tx_clk;
 
 	regcache_cache_only(spdif_priv->regmap, false);
+	regcache_mark_dirty(spdif_priv->regmap);
 
 	regmap_update_bits(spdif_priv->regmap, REG_SPDIF_SRPC,
 			SRPC_CLKSRC_SEL_MASK | SRPC_GAINSEL_MASK,
 			spdif_priv->regcache_srpc);
 
-	return regcache_sync(spdif_priv->regmap);
+	ret = regcache_sync(spdif_priv->regmap);
+	if (ret)
+		goto disable_rx_clk;
+
+	return 0;
+
+disable_rx_clk:
+	clk_disable_unprepare(spdif_priv->rxclk);
+disable_tx_clk:
+disable_spba_clk:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(spdif_priv->txclk[i]);
+	if (!IS_ERR(spdif_priv->spbaclk))
+		clk_disable_unprepare(spdif_priv->spbaclk);
+disable_core_clk:
+	clk_disable_unprepare(spdif_priv->coreclk);
+
+	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
+#endif
 
 static const struct dev_pm_ops fsl_spdif_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_spdif_suspend, fsl_spdif_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(fsl_spdif_runtime_suspend, fsl_spdif_runtime_resume,
+			   NULL)
 };
 
 static const struct of_device_id fsl_spdif_dt_ids[] = {
-- 
2.21.0

