Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE801C4707B
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jan 2024 10:57:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFF2BF52;
	Thu, 11 Jan 2024 11:57:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFF2BF52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704970641;
	bh=3cQvnwcXHoi10LGhXXkqD+S50rLO3Wezsg1rzILzUxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MSPp/ORagvjt12H9Iz712f/c8vmdlz4IWiAXa9Anr4IzfF8pDvBuz8dxg25HuLdyB
	 9fLLSK6isrJhrfc48gKwhXWkWZOqiMtXYIjOmQIYJZeHFMBnDGr69+4dWrigU1Va/2
	 5k7CexGgmKE0Yl+v4w/CCYZ8r6jVq64ftaWwE+Dw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6CF12F806B7; Thu, 11 Jan 2024 11:55:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A77F806A5;
	Thu, 11 Jan 2024 11:55:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9319F80254; Thu, 11 Jan 2024 11:53:08 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ACCA0F80246
	for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2024 11:52:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACCA0F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=CLVk0hS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970378;
	bh=3cQvnwcXHoi10LGhXXkqD+S50rLO3Wezsg1rzILzUxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLVk0hS9qP1S0SfjosuThhHcG23RNZwo7E3I5N+W/tIuoxBDnsIj+HaMXf69ntc4i
	 WNK7/lNLCd/XFvkNMyM/+Y7z/UEIFzf45S7zaWASQFMA88ATcBJCB+O3RSIVm23plI
	 K/KPoRpBKcat+wzk0kK3DpfkHl4EtN3Ie+DRu0dz6W7M7TGBFOa7DlKL+PQDS9yx+7
	 QJSODtPQv5ASzB1zbVYuzxXnF/J1BrT78DYGqTVPr/E8mC6uEcY38yz+qCMbZyjiGw
	 G6c78RnowRrlD36tFeMHibVHe5cJJWpeYGDXJBVTKgAxM2s+Mpa/6a8v4hMkuqMsG9
	 1cdHYvyEgmPcw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com
 [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FB5F3781F8E;
	Thu, 11 Jan 2024 10:52:57 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ribalda@chromium.org,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	kuninori.morimoto.gx@renesas.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	trevor.wu@mediatek.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6/7] ASoC: mediatek: mt8192-afe-pcm: Simplify with
 dev_err_probe()
Date: Thu, 11 Jan 2024 11:52:46 +0100
Message-ID: <20240111105247.117766-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RPYVTDT4CZIHHGR4WLVHJ5JFUQXHAD5Z
X-Message-ID-Hash: RPYVTDT4CZIHHGR4WLVHJ5JFUQXHAD5Z
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RPYVTDT4CZIHHGR4WLVHJ5JFUQXHAD5Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Simplify the probe function by switching error prints to return
dev_err_probe(), lowering the lines count; while at it, also
beautify some messages and change some others' level from warn
to error.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 65 ++++++++--------------
 1 file changed, 22 insertions(+), 43 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 794419d16b01..7242e6a4625c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2205,17 +2205,12 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* reset controller to reset audio regs before regmap cache */
 	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		dev_err(dev, "could not get audiosys reset:%d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
 
 	ret = reset_control_reset(rstc);
-	if (ret) {
-		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
@@ -2223,25 +2218,21 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* regmap init */
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(afe->regmap)) {
-		dev_err(dev, "could not get regmap from parent\n");
-		return PTR_ERR(afe->regmap);
-	}
+	if (IS_ERR(afe->regmap))
+		return dev_err_probe(dev, PTR_ERR(afe->regmap),
+				     "could not get regmap from parent");
+
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
-	if (ret) {
-		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_attach_dev fail\n");
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
 	pm_runtime_get_sync(&pdev->dev);
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
-	if (ret) {
-		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
 
 	pm_runtime_put_sync(&pdev->dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
@@ -2281,30 +2272,22 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
-	if (ret) {
-		dev_err(dev, "could not request_irq for Afe_ISR_Handle\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
 
 	/* init sub_dais */
 	INIT_LIST_HEAD(&afe->sub_dais);
 
 	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
 		ret = dai_register_cbs[i](afe);
-		if (ret) {
-			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
-				 i, ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(afe->dev, ret, "dai %d register fail");
 	}
 
 	/* init dai_driver and component_driver */
 	ret = mtk_afe_combine_sub_dai(afe);
-	if (ret) {
-		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
-			 ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(afe->dev, ret, "mtk_afe_combine_sub_dai fail\n");
 
 	/* others */
 	afe->mtk_afe_hardware = &mt8192_afe_hardware;
@@ -2320,19 +2303,15 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	/* register platform */
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &mt8192_afe_component, NULL, 0);
-	if (ret) {
-		dev_warn(dev, "err_platform\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &mt8192_afe_pcm_component,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-	if (ret) {
-		dev_warn(dev, "err_dai_component\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE-PCM component\n");
 
 	return 0;
 }
-- 
2.43.0

