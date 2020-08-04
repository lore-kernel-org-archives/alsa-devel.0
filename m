Return-Path: <SRS0=lfZM=BO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C497C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:08:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148B620792
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e6b+nqtN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPyRsBf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148B620792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 721FC1678;
	Tue,  4 Aug 2020 02:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 721FC1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596499700;
	bh=i7RqaK+9Q+KK6nbWpbbk9g589RBn4mqsq5K4Pm80vjc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6b+nqtNCacwlwsD7yfnAfYR9BJMHDYy73vaIZ/rcDOOWRzxrsaDwCaeivOMiJms5
	 jaq0cmkfXVnwsyT78TbV/ll+6HtxJ2p2qIbpQ8/Hgj3oQxrtbH/2CYpmqaO+a5VjcN
	 lYSiV7dgY3wEqvTTtWGAry4Of3uiNVjw3aYnG+28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 905E8F802DB;
	Tue,  4 Aug 2020 02:05:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 724CCF802C3; Tue,  4 Aug 2020 02:05:48 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1431AF80218
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2020 02:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1431AF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="LPyRsBf8"
Received: by mail-pf1-x444.google.com with SMTP id r11so11306609pfl.11
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l3OiBOjafm3plPEFte4M6SO56RI7TS2vgkQEyD6y8A0=;
 b=LPyRsBf8uatoR8gWHlPsC/BOs6J+g3iymamTa9IWYe2OXk+e9O1U+kElZtxQYeyY/C
 Eyb660XqBkPshzkYARXpu1veuTlEWBLctTGaZ2TX8ZFi03Mq+fDjaLt9pW05nKWefJuq
 XvNZhcNKkmbYBMGzbXq3C4j6YB6NKPoCc5c7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l3OiBOjafm3plPEFte4M6SO56RI7TS2vgkQEyD6y8A0=;
 b=Nwp93aWAgJmYvKtn9Z7AAC3Q+YQ5KHZpaFic0mSZkC672mqTZYTfC1UT3EA7oAJwnj
 2RrYVoh5N6CGSU4ij1GtlfZwEOd1hbLKpU/Hn/FXdCYIehr6MuCeTdvyZL0eaR1MUsNW
 zDGrziTXqZ6WFwMHxXRh1inXBZq76lYmOGlUQGSiLXXCSvR1CY9eA2teK5h8etiI4850
 TreLaO7BFMq8YmdpGkW69wlMHop0D/iOrq1igkZXEeEu+WFIlsDYs8iQLEFbnMZYGHah
 JJ9TOU+tffujD0xhk+s6+BQxCM4tU4QPikkR3mDEALrL1mCFk6kiuTncCy2I0RYxwif1
 R0Cg==
X-Gm-Message-State: AOAM5302vqTwZchUI1uWc6Qd+B6kf1vx3SQJXKRuQhcZ29GZXMUIP7WF
 wqPeZuy+jnK1IjbfBYlDwDYwsA==
X-Google-Smtp-Source: ABdhPJyFldD5Jk+BXD0T+4t0RZBnjvyZfqehuzQXAggkI49L/50t4c4PrODhjN5fDmoDfwya8bFnWA==
X-Received: by 2002:a63:8ec8:: with SMTP id
 k191mr17016302pge.154.1596499534145; 
 Mon, 03 Aug 2020 17:05:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
 by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 17:05:33 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5682: Drop usage of __clk_get_name()
Date: Mon,  3 Aug 2020 17:05:30 -0700
Message-Id: <20200804000531.920688-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200804000531.920688-1-swboyd@chromium.org>
References: <20200804000531.920688-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

The __clk_get_name() API is deprecated. Use clk_hw_get_name() or
proper registration techniques to avoid it.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/rt5682.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index ed9475f24aec..d8a1973a4624 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2548,7 +2548,7 @@ static unsigned long rt5682_wclk_recalc_rate(struct clk_hw *hw,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 
 	if (!rt5682_clk_check(rt5682))
 		return 0;
@@ -2572,7 +2572,7 @@ static long rt5682_wclk_round_rate(struct clk_hw *hw, unsigned long rate,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 
 	if (!rt5682_clk_check(rt5682))
 		return -EINVAL;
@@ -2597,7 +2597,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
 	struct clk *parent_clk;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 	int pre_div;
 	unsigned int clk_pll2_out;
 
@@ -2755,33 +2755,31 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
 	struct device *dev = component->dev;
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 	struct rt5682_platform_data *pdata = &rt5682->pdata;
-	struct clk_init_data init;
 	struct clk *dai_clk;
 	struct clk_lookup *dai_clk_lookup;
 	struct clk_hw *dai_clk_hw;
-	const char *parent_name;
 	int i, ret;
 
 	for (i = 0; i < RT5682_DAI_NUM_CLKS; ++i) {
+		struct clk_init_data init = { };
+
 		dai_clk_hw = &rt5682->dai_clks_hw[i];
 
 		switch (i) {
 		case RT5682_DAI_WCLK_IDX:
 			/* Make MCLK the parent of WCLK */
 			if (rt5682->mclk) {
-				parent_name = __clk_get_name(rt5682->mclk);
-				init.parent_names = &parent_name;
+				init.parent_data = &(struct clk_parent_data){
+					.fw_name = "mclk",
+				};
 				init.num_parents = 1;
-			} else {
-				init.parent_names = NULL;
-				init.num_parents = 0;
 			}
 			break;
 		case RT5682_DAI_BCLK_IDX:
 			/* Make WCLK the parent of BCLK */
-			parent_name = __clk_get_name(
-				rt5682->dai_clks[RT5682_DAI_WCLK_IDX]);
-			init.parent_names = &parent_name;
+			init.parent_hws = &(const struct clk_hw *){
+				&rt5682->dai_clks_hw[RT5682_DAI_WCLK_IDX]
+			};
 			init.num_parents = 1;
 			break;
 		default:
-- 
Sent by a computer, using git, on the internet

