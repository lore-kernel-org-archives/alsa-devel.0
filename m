Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03817C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Feb 2022 13:14:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D21F16AB;
	Mon, 21 Feb 2022 14:13:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D21F16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645449279;
	bh=jv2Gp/N67y1Ab3liSlzKJKiHePsfK1JgwEJOmyNnJBg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEwj0g6QrywuaPGV2N/D2oncKky/a86GKrUUeLRvf8698gsTo3B3Ig9kS+1rnKqIk
	 m7NwvxO5wRi7Fn8YTtbvVImL0pR8cZEledLSOCxK0fwGpTvx7w+BfS/YvOW9bR1aWU
	 rbxIUoDlHqf6oJl/jooNzR5R4ep0ISYPkG+YVIn4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 357FAF80543;
	Mon, 21 Feb 2022 14:11:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D9F0F80511; Mon, 21 Feb 2022 14:11:02 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47ADFF800D1
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 14:10:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47ADFF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="I+dOyBnJ"
Received: by mail-wr1-x433.google.com with SMTP id d27so27016467wrc.6
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2U8Gf3HJdH9syGZl9j1jogHOiAd7YSk+hDONNdww6Ps=;
 b=I+dOyBnJS4SRSq5buGKlAzEiHETqO9p+g2O0IpuK8oBLKaHrXmg2U4VlsqIUFZOSxh
 eHPrGLmQiOBf3HIoYDkTGaPN98bzznwbdXh4kZ5/JCdB6mvnKJgn1ezUlkZb3oV7igRG
 PqQFGVEL5Hhb4lwtAAQxdhR2jV9yjt5aZAekEI14NocbkQ0RIFjHUmbks6YmAjmYEQLy
 Z5pLb8tUjm+cV4AJvnsXVFhAWL8yEzVyaBLUqSizVaT0mLnTgq9kfHcUJwoAUJuIMjle
 ISSAKQptuE+8xA4n0KYfUJF610tWF/rFE/gcGKYZSLplADKsGLMN+lV33IazUFyW8Zdv
 eqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2U8Gf3HJdH9syGZl9j1jogHOiAd7YSk+hDONNdww6Ps=;
 b=NKYyYUpgOgy7VLDh8w3ruLgXcEUX6TNVfEEsZdaZ0vXzD5Gh7tGrS2wWVY2ovm4eo4
 W/21/XeH4hfDA/cyKqzpsAma3BXqxKJiFwEv0nLy/ZcB6yaEBYbQldJp9245/SPJoAO/
 ki/ZrGgvFv/AHaWqtyoaf0hTamOMtpOj3eldcjhRUiuE2MrWmz0ZxyICvGbpg4G1NpB4
 L/mpuUSy+ie5oezIbny3qwaHdGPbhlUQh9VUzfuXSfjstppdbDTlA5SdGGTcfebHsGZE
 Sci0tAqyW558hR5ptDPUe0ItMIU3G77u/9ShxyBQM8FlpR7mcdAQKaWJvTKQIMeSM4z6
 8n4Q==
X-Gm-Message-State: AOAM530V/IWn0Uz9v8tKNBR8LAWNU7afHxpjzFTpgWrjxdfjKc3IM3jE
 KwJW/QZfgW1amr3Ie/ZBxPauug==
X-Google-Smtp-Source: ABdhPJwlbxv93gkUtu9c2GU5/Fcp1Mwcm0jj3wbGovTiBxEEh4DWuGiuIKoTxqB2wGyS9YPkIu9v0w==
X-Received: by 2002:adf:e952:0:b0:1e3:39ed:d990 with SMTP id
 m18-20020adfe952000000b001e339edd990mr15889802wrn.215.1645449052490; 
 Mon, 21 Feb 2022 05:10:52 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 05:10:52 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 10/10] ASoC: codecs: rx-macro: setup soundwire clks correctly
Date: Mon, 21 Feb 2022 13:10:37 +0000
Message-Id: <20220221131037.8809-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 quic_srivasam@quicinc.com
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

For SoundWire Frame sync to be generated correctly we need both MCLK
and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain on,
however after adding pm runtime support its possible that NPl clock could be
turned off even when SoundWire controller is active.

Fix this by enabling mclk and npl clk when SoundWire clks are enabled.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index fb5d4bb8bd8b..9ce83cff3e1b 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3428,6 +3428,7 @@ static int swclk_gate_enable(struct clk_hw *hw)
 {
 	struct rx_macro *rx = to_rx_macro(hw);
 
+	clk_prepare_enable(rx->clks[2].clk);
 	rx_macro_mclk_enable(rx, true);
 	if (rx->reset_swr)
 		regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
@@ -3453,6 +3454,7 @@ static void swclk_gate_disable(struct clk_hw *hw)
 			   CDC_RX_SWR_CLK_EN_MASK, 0);
 
 	rx_macro_mclk_enable(rx, false);
+	clk_disable_unprepare(rx->clks[2].clk);
 }
 
 static int swclk_gate_is_enabled(struct clk_hw *hw)
@@ -3490,7 +3492,7 @@ static struct clk *rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->clks[2].clk);
+	parent_clk_name = __clk_get_name(rx->clks[3].clk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

