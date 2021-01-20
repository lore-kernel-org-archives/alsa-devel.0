Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C93C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:11:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E82523131
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E82523131
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75D851817;
	Wed, 20 Jan 2021 09:11:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75D851817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611130314;
	bh=XI1Ia0yfsXWPGfHgArxaM+DKFPn1v1oEC7Um+0RcXIg=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogr3ZtaG4NmrjhC6hRuZg5R92V+4h27vgdWh9736edvqpagdU6SUd9P0cUi2TySuw
	 fLsCZZ/oy8bbNS/P5NMeDKtinyAibsatvDd1IdAHpHLoQVB3MhcFR8V9mus68Esm7p
	 CkHzGwkPdJ4hQHoIzb/1KmudGhelgiJTZGoMCAlA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79909F8019B;
	Wed, 20 Jan 2021 09:09:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40716F804D8; Wed, 20 Jan 2021 09:09:28 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45A3EF8019B
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 09:09:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45A3EF8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="AtlWPW3G"
Received: by mail-yb1-xb49.google.com with SMTP id p80so27325910ybg.10
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 00:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=/155YZh3u5CZmgGBqPs3Z1+3mEPs7kdY4M8ErlsIDVk=;
 b=AtlWPW3GrzhyJULCarM8VZ8F0HOfbax+wBlJ8g98wMRFHTRQR3bs0jBaLuHGOxVIQy
 cX325kDqXK1qGGiFrkEY9ZnYg7A6h0tryl45WOi9LUeSswQa9rBAXl1UhNSJPRCr9iGq
 tQa+dzXs+r7JLdfFCGQ5JQR21rxlfxFvW8W5X2wOlEMiWoQ6lTNL9lu9ohaAI7d5WzFW
 nGk4LxBH9htsd80WSpuyPKLAw3TCZmrwHDoi/QPk/zxrj0P6L9sW4G5oG85jf52gJ6Rh
 I+sYwZkrGq5IA+VFfX+nHBPWaRxhGdkR5fij0zmAse/wN97bKZlQvg7wnsPtLApiej+k
 KHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/155YZh3u5CZmgGBqPs3Z1+3mEPs7kdY4M8ErlsIDVk=;
 b=dKpoCa9aPShaZh9gic+UEXf5N6LuM9glxoCHmCa7DoQAzkPZXNRBoqfwLAl+B0BK8e
 T4wppsJUz3BOorfCXvb53lxqCLDZaauN2RZiBR93lmv0kgwGaVn/3v2kPIVk4lqVbH0D
 iurTK2E5e7h2ldrteIPKaLuWbjd1H/E1YEZUnmgyr1IYncUungr0VBz8de446EeKT4mr
 eZOvECxiFoWTOpXFaJFRLFYgyG78X2cvQHdjgRV1UihbUmnEwjp8ScS6izr9uGR1hPt0
 NJ7PRXo+XurHaaA/3mqEB8YZDS9SZkpvewXdbIhFws3fMMSpZjkvkrmmW7gFzgzsDbsa
 +7eg==
X-Gm-Message-State: AOAM531cauti3O1JfjOzKOxehpBpRkOV9SqL/8yex1dMKU5Qu6QHx+Ag
 QZrrPe94mQj+4Asj6D7Vd5Qy+lHW9JHM
X-Google-Smtp-Source: ABdhPJyQ8DW1noUGr4HZs4A7OSfLntlH3/PooBCS8aEmx3ebRmA55jp19tECYGkklu+64qR7FFpwPyKhI66g
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:1164:8893:969a:b338])
 (user=tzungbi job=sendgmr) by 2002:a25:500b:: with SMTP id
 e11mr11701233ybb.138.1611130146774; Wed, 20 Jan 2021 00:09:06 -0800 (PST)
Date: Wed, 20 Jan 2021 16:08:46 +0800
In-Reply-To: <20210120080850.699354-1-tzungbi@google.com>
Message-Id: <20210120080850.699354-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20210120080850.699354-1-tzungbi@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/5] ASoC: mediatek: mt8192-mt6359: move headset_jack to card
 specific data
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
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

Moves headset_jack to card specific data.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c   | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index a988ce1e58de..72d337fc8534 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -31,7 +31,9 @@
 #define RT5682_CODEC_DAI	"rt5682-aif1"
 #define RT5682_DEV0_NAME	"rt5682.1-001a"
 
-static struct snd_soc_jack headset_jack;
+struct mt8192_mt6359_priv {
+	struct snd_soc_jack headset_jack;
+};
 
 static int mt8192_rt1015_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
@@ -305,7 +307,8 @@ static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct snd_soc_jack *jack = &headset_jack;
+	struct mt8192_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &priv->headset_jack;
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
@@ -1038,6 +1041,7 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 	int ret, i;
 	struct snd_soc_dai_link *dai_link;
 	const struct of_device_id *match;
+	struct mt8192_mt6359_priv *priv;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
 					 "mediatek,platform", 0);
@@ -1083,6 +1087,11 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 			dai_link->platforms->of_node = platform_node;
 	}
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	snd_soc_card_set_drvdata(card, priv);
+
 	ret = mt8192_afe_gpio_init(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "init gpio error %d\n", ret);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

