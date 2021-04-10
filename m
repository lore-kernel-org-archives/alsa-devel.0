Return-Path: <SRS0=Dw+a=JH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC0C433B4
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 11:15:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EA161165
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 11:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EA161165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1852C82A;
	Sat, 10 Apr 2021 13:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1852C82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618053352;
	bh=bdFl+OyVpqt0kC2WzQn04g4Hi2H6iOoOf17mJP7gLRU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MZgtwa+gJbdXQbGEeJyfOLNzLa7N3cy+z1IWBX6x98uzJX0NDOgeKKoCttSL9Z9Fb
	 8WoqvS9NhYOusond2SrJPDaAwqxBOpuecwlSVhA0BvUydA+wQvBnSp/b67kl9qZBC/
	 auoFaJw68zsegQs9APQcnEq/FR3hN5pomO3Rc9sA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFA27F80258;
	Sat, 10 Apr 2021 13:14:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BA5AF8032D; Sat, 10 Apr 2021 13:14:14 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64056F80169
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 13:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64056F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="v9U97RoS"
Received: by mail-wm1-x329.google.com with SMTP id k128so4172252wmk.4
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QNN+T8BLDOEY3hY3Q8J1z1U466PRLMSEBuyc1PHvJfo=;
 b=v9U97RoSwZSup94uN9Uxxm1PqJKrOJHw3i4+6XE11F7YO0YlBQFFBKNGBgsFykzzO+
 SyJybwBPDP3LoWKZbqGTtLsZCmDWDjxCu9p50M6UcKPO5dJIR+z2jXzZwWW+lUZdPibF
 RPfdXU+rrfv5v6P5U9WSyt/bc8mwJ4eL13BvakKp6hNqd7OJ1yvJYeIxWmp2dZ11zMO9
 cvJcLF90mrSx4cVlx5xiEPQUKiEe7l7Orc2kJNhK41wGd1QFHW2wNuwkRy+AqwYUJcTB
 9dI5scsAd47NO5N+I48qS/uNxv2InLZFW+7wXZsW3RKCCXFyIHlzdiry+/tuSAjsC9mp
 +yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QNN+T8BLDOEY3hY3Q8J1z1U466PRLMSEBuyc1PHvJfo=;
 b=alRj+WZZSivUS8rFS6FrpOP8Xuh7V0gvUBCL5DAfk3hyYVv9Sp8xsi7JFr/o91VDF5
 GK/iYNAA7DLkXfbFXxXsGIKj3bV5Sk9SquwXJaSZU9oUExMwJu37JkvkJ6Vrlxd5OWgj
 wQNJiTLUODCU6xMganB3F36yoIzGgDOoEY4iTEcrcOz0i3rB1ho2Tw8YGKwK3G728/Dw
 zSKyhOhuy8R9rEbwUwE/Kq3HqHHl6JybgHcAv9RBi7xqEcuCyVdOpnajMcDWizlV2J6P
 Wu3Ow0eaFwsnJVpstgnwLJ7wKUv5IpCWXn8ZTJwKz14zVf3RQ/IcgrQkaNCfjjvCORU3
 xI0A==
X-Gm-Message-State: AOAM530C2PixXM7IFm3sT/oeMSUewN97M3Q+KA1KCQI0a4wDKNoZdCRi
 QuaLDFytEhUrFhAXczCKlnedEw==
X-Google-Smtp-Source: ABdhPJzPWFJbT8j9mVKSkGi4AalpAZcoxl73akrvuCpEf0o1LSZf+CIY4lYmIhXbZ6f56s90pj0Djg==
X-Received: by 2002:a05:600c:ad3:: with SMTP id
 c19mr17827365wmr.125.1618053244161; 
 Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
 by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock provider API
Date: Sat, 10 Apr 2021 13:13:54 +0200
Message-Id: <20210410111356.467340-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111356.467340-1-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
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

Clock drivers ops should not the clk API but the clock provider (clk_hw)
instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/rt5682.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 0e2a10ed11da..2eee02ac8d49 100644
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
2.30.2

