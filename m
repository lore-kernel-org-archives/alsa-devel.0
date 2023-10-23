Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905F3CDB474
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 09:59:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F3BBE0E;
	Mon, 23 Oct 2023 11:59:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F3BBE0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698055190;
	bh=yOJ5gvFYVYRXM+ThkW5ORB9a0uN/J5HWAaqSuML8fzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MxGIwNZiuJF0HHVaTlgl1TYmMK8YYllz1wv1o61ImD/dOmx5ewpAIGQxD5w0v8P7J
	 7xrZ3dmUQhrYOEqvGddmlpuw1RGzxJR+lqkEdJT1M0W5zU0n6ncA/VmyKbUeVJLn6Y
	 BrhW+go34nlbAKTHKjR82Gs6JLt5eSACBPG5bLD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9799F80601; Mon, 23 Oct 2023 11:55:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9F26F80601;
	Mon, 23 Oct 2023 11:55:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CDC4F805E2; Mon, 23 Oct 2023 11:55:10 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC7C8F805C8
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 11:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC7C8F805C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=h98/0SxX
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso2147827f8f.2
        for <alsa-devel@alsa-project.org>;
 Mon, 23 Oct 2023 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054905; x=1698659705;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu/sTtccUwF0ah9E+SK4dukpMAzlv54jZyNo0CSiF0c=;
        b=h98/0SxXddXzhvDVNoUSqlmSblllkU6UjlRTjhGfOTAqY85foB9bdIZzj5aCVSfzbJ
         e5JUWGHKskSMLlf1dJxpS2CezBRAwb8QJ6rPuaBIXb+YOXrb2YlliKDhT+TvmsDA+yOj
         JguUdigzsRtTuqcX6p1fbJ9XYOmIXtrxX/tHyn/llRuTgaFM353GMfeoTB//uSEW9nH0
         Q4GDvL0Hi84koCKX6xDBSnG+P0E6PzTcQjIERiEVkmmuLPK9g63f1gRSbDH0mO9ZQZPX
         WWsQ2ylGhzTUiq0UkFqLz5gYRyzt+7NjIWjd8RbPteRKkXk/9036NMh/0ntLEVI0j/eo
         oO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054905; x=1698659705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu/sTtccUwF0ah9E+SK4dukpMAzlv54jZyNo0CSiF0c=;
        b=ugYge5HTBndtYK3dcW2UuuyncIBPP7lIHyaGwXkaoNO9g1IDQjjyeky3qX0itUngPE
         3RM8rOb1NnerclR1AgVCwxt0x9jcKFVpDmp8k967NaIJdQ8PuqcZvXAAATUfT7nC7c8v
         cCmxfqxmU3mwiH5qlJPxRPLkKy/kS3cYF4ja8dndi9EX036wu0dG7YmP1ChL/Nc/rRUr
         Uzk5NB4PXKmYmI+pr+8ccUX9SUejpc1Hu8K4JFlk8fYFLMs4IYXVSUhc9lKI+qgHCa4S
         ZnQANOiaS0gADfYSjOoS3qasLDxU9NLutTMkzbL/AB6mfEySGD0bUqsuhhijIhPq1RMb
         Q5mg==
X-Gm-Message-State: AOJu0Yw0iV07zmmiqXg2UlbYudGJhE2sZUG7ANDcCQmzMQi5OtCRRg83
	8r97owRZY4eQHlETYJmitWmrWA==
X-Google-Smtp-Source: 
 AGHT+IFC/yAsny5qrYVg+EkJz4fUi483BdHJQWDTMZauGOFIlXds5DqFSdeJFZSj0XyhBOmMbTRyIg==
X-Received: by 2002:a5d:5267:0:b0:31f:f65f:74ac with SMTP id
 l7-20020a5d5267000000b0031ff65f74acmr7213785wrc.70.1698054905019;
        Mon, 23 Oct 2023 02:55:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:55:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 14/17] ASoC: mediatek: mt8188: Handle component name
 prefix
Date: Mon, 23 Oct 2023 11:54:25 +0200
Message-Id: <20231023095428.166563-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IGTLRSD76ZHN5SHAF3VG7BA6WWBMY4FI
X-Message-ID-Hash: IGTLRSD76ZHN5SHAF3VG7BA6WWBMY4FI
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IGTLRSD76ZHN5SHAF3VG7BA6WWBMY4FI/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
index 16440dd0a89c..2a48f5fd6826 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
@@ -576,13 +576,13 @@ static int mtk_apll_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (strcmp(w->name, APLL1_W_NAME) == 0)
+		if (snd_soc_dapm_widget_name_cmp(w, APLL1_W_NAME) == 0)
 			mt8188_apll1_enable(afe);
 		else
 			mt8188_apll2_enable(afe);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		if (strcmp(w->name, APLL1_W_NAME) == 0)
+		if (snd_soc_dapm_widget_name_cmp(w, APLL1_W_NAME) == 0)
 			mt8188_apll1_disable(afe);
 		else
 			mt8188_apll2_disable(afe);
-- 
2.34.1

