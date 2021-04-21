Return-Path: <SRS0=sv+a=JS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443EC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 12:07:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DB36144C
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 12:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DB36144C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9315E1682;
	Wed, 21 Apr 2021 14:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9315E1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619006850;
	bh=ZY4yGYgTdCze3juMQjrmVSfuqcjhzaQvmNuCo5yEzMo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGeF4Yp9VhopV4pRa3KYvEIq2q6RVuRc2fzSKNeEyztso4P7/RGfwO+pSJLzUptVg
	 0pCJf/rIqjLOQZklkbbIAHTW3pYNi+4NRJuhPjA+8+qSFbfS7elddPXK/Aqt55tqIO
	 1Y9ZNsVy5MqQt3jtGxROqAtCjDYBBbMnG2RjXWcs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A303F8025A;
	Wed, 21 Apr 2021 14:05:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F08AF8032C; Wed, 21 Apr 2021 14:05:55 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7878CF80256
 for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2021 14:05:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7878CF80256
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZQiDoc4I"
Received: by mail-ej1-x62c.google.com with SMTP id v6so61830948ejo.6
 for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WBvDDO3AKgp6HTsSIcTOIT+KCHK50v2vbG7h5wPnh6A=;
 b=ZQiDoc4IpWNOVnVThvEFhumSPBLHtbewiHEKSIHIOSx5I8x7cZt/mJ6PjBZ4zA0WHH
 MKDdn7s1SFlQHMRAkYerAo60U+rde7gj2KqAYDNb9OtSKpFiqZysc4v6MfwAkWJxRuaq
 cjNKPpbR/eoyvxrPd9blBLTfJgoNiTPLh9i/NAo/4qljDRN3GFX/KXdHHnMAPap7KaGJ
 x1Pky1d0iB++nNFBuNsjs9Ny7Nr74NyL+gg3plySGVVtLAAJCjyXgmflkF9WHteXUTKv
 qpLHYdBIUFKN1lmM3/LgeoZGhnILl5TcaxkJybIf2GpZvSbuOlYIF1Td6GNaRgSSmYfK
 aVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WBvDDO3AKgp6HTsSIcTOIT+KCHK50v2vbG7h5wPnh6A=;
 b=LgO8nKN2QmMbKXHALQw9GD5vFY4jWBFvWLyRnssdQrEGFBS8K5ZcuXMA/Vh1yHskdl
 YizlEMoDhP9hoQLdrG5T0gcS5fLHxfGZCNYFebUxA05cGdR48GmQ64W28Yb0mXMCEcBD
 rXgFcDTMzQ9LAgt54biA/4rURGXYK2hMO3BYVQXTfPiFFJSjeao8BkMmRnINzaqp9G+b
 rkRyifPvDRC3aJ+qk8rrgHnYLsVOEo91nlsYJC4e+Twxsod1w5a0MxzvV+cgDrcSd7XA
 fIEbS6/jxVIwYMi+726L8KOz8xUOg4L9cEoEnEhCTGqc42+9+BKW6wLu2fm9AbrBxNW5
 2E5g==
X-Gm-Message-State: AOAM532Rimvcy9eccQmGhGbBA8rjEO6JQ6IW49UXLOUoDnvtWqsX/UPW
 hKoJfEX+YotGeVc9o3UHuaS4aA==
X-Google-Smtp-Source: ABdhPJw7RBl39HDAf6162Lb+vNNYdFWkpn3xny4FcphRHCsNTHcKKiqoBS6LkEYz3O0d7GgbAK6fvw==
X-Received: by 2002:a17:906:2818:: with SMTP id
 r24mr32281084ejc.502.1619006739211; 
 Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net.
 [82.65.169.74])
 by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/5] ASoC: rt5682: clock driver must use the clock provider
 API
Date: Wed, 21 Apr 2021 14:05:10 +0200
Message-Id: <20210421120512.413057-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
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

Clock drivers ops should not call the clk API but the clock provider
(clk_hw) instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/rt5682.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index a5aacfe01a0d..e4c91571abae 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	struct clk *parent_clk;
+	struct clk_hw *parent_hw;
 	const char * const clk_name = clk_hw_get_name(hw);
 	int pre_div;
 	unsigned int clk_pll2_out;
@@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 *
 	 * It will set the codec anyway by assuming mclk is 48MHz.
 	 */
-	parent_clk = clk_get_parent(hw->clk);
-	if (!parent_clk)
+	parent_hw = clk_hw_get_parent(hw);
+	if (!parent_hw)
 		dev_warn(component->dev,
 			"Parent mclk of wclk not acquired in driver. Please ensure mclk was provided as %d Hz.\n",
 			CLK_PLL2_FIN);
-- 
2.31.1

