Return-Path: <SRS0=BPvr=F4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCDC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:09:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9C2168B
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAD651824;
	Thu, 24 Dec 2020 11:08:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAD651824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608804582;
	bh=VB9K6BHi72Dl994HnAiqiSAlBT2w0EfwCzPsAVOhw48=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npWmPYcwN1UsG0H3/tfC3vWT3dWdAaviLo9bcSttp6aK9qx8RT4D8aNA5gF46FxhQ
	 cwIeBkWD28wCZSdPqeH7qDSYo5ShrgJsbrjuy1KPc3RHI6nEaSs6k1Je8j8Ojeurjn
	 L8Wz3rZRE95Q2HZKiju9DvSGw/cnQ/tPcG8dpZDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E680CF804E0;
	Thu, 24 Dec 2020 11:06:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D88EAF804CA; Thu, 24 Dec 2020 11:06:35 +0100 (CET)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5748EF804C1
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 11:06:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5748EF804C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="scmhNdwB"
Received: by mail-qv1-xf4a.google.com with SMTP id i13so1288956qvx.11
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=7EXZ4XxksOgK1qOr5dIqjUfXKl/wZLCjJI5TkXqsxYE=;
 b=scmhNdwBGILEiIvs17e++6ZheHCGYOYaczn8BwxwCW6jyd82njkfUtBmwJcLMRoFoG
 J1LusIvVja9gAr7m9juqcWFGp8czo3wrHcJweLdVfHjCqfni2eSXgO67BCUczZOLiqlq
 EIQaNjzcMY87m7zWJljE6Y6Ph3kggq1MArh6/dVhfguez9xeetryjWk7atmrx1fT/MjX
 pWdj/k+VChPnFxpUW9UOKr8b/9lZ66Oro/WhXaumETp7uKW89SjecRgDxmJzOFeU5IyR
 MImZQsdeUly8dbF8SBptVL3e5jwdd1Tv4VPIA3bXhBenQJTMkJq8rV4L2ypLLJIwJCwv
 KU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=7EXZ4XxksOgK1qOr5dIqjUfXKl/wZLCjJI5TkXqsxYE=;
 b=KzNk3PDlGAPAKChUoxMottiDMCsSzH5BmOb1mAsBhZUi6IT/4llONdtMegsqCtpTPO
 BXS+XMtuInV/A0NialZlRcSH2Npg9KI6dGxPAiPjvv+aaKfOdMJYAqexFkPew2WHQ9Qo
 KzZKpP6rib1kY0MtUxS/ibXKwXemWufudeuVFC2qGGJCFZJC+V6/DI/F0IQHChPZskxf
 XHWKt/PoXRgj6iwpdlxRUA7pT8laCFjB0WxeHxmhBups9MqVUIOrV+OnW1nHdaNzJYz6
 1b7f5S1ZH/uEwJ58scV3D5nu0BHh5akPjk95ieHjO9y0T4D1RcwVLDfCDkvQIj+kXqLP
 7Pkw==
X-Gm-Message-State: AOAM530xZ3MAWnlPRePiiRwisztBY7sg8MOBt501Rb+9N0m6YrlGeEaP
 WQFfZsAaKAkUIBVKGadhLyx+5I06csfx
X-Google-Smtp-Source: ABdhPJzC9Ct1jM4W5daL22jAHwDM3GsTi1OvvUBJPE3fF9k9rr8/6Bqgn4vUtwnec+x1QFFvzZm9KX82wew+
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:28f:: with SMTP id
 l15mr30570526qvv.38.1608804392238; Thu, 24 Dec 2020 02:06:32 -0800 (PST)
Date: Thu, 24 Dec 2020 18:06:07 +0800
In-Reply-To: <20201224100607.3006171-1-tzungbi@google.com>
Message-Id: <20201224100607.3006171-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20201224100607.3006171-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 5/5] ASoC: rt1015: remove unneeded variables in rt1015_priv
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

- `lrck' is only used in .hw_params callback so that it can be local.
- `bclk' is unused.
- `id' is unused.
- `amp_ver' is unused.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015.c | 9 ++++-----
 sound/soc/codecs/rt1015.h | 4 ----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index a7b9dfcb4b0f..4a9e2eaebe30 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -724,11 +724,11 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct rt1015_priv *rt1015 = snd_soc_component_get_drvdata(component);
-	int pre_div, bclk_ms, frame_size;
+	int pre_div, bclk_ms, frame_size, lrck;
 	unsigned int val_len = 0;
 
-	rt1015->lrck = params_rate(params);
-	pre_div = rl6231_get_clk_info(rt1015->sysclk, rt1015->lrck);
+	lrck = params_rate(params);
+	pre_div = rl6231_get_clk_info(rt1015->sysclk, lrck);
 	if (pre_div < 0) {
 		dev_err(component->dev, "Unsupported clock rate\n");
 		return -EINVAL;
@@ -742,13 +742,12 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	bclk_ms = frame_size > 32;
-	rt1015->bclk = rt1015->lrck * (32 << bclk_ms);
 
 	dev_dbg(component->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
 				bclk_ms, pre_div, dai->id);
 
 	dev_dbg(component->dev, "lrck is %dHz and pre_div is %d for iis %d\n",
-				rt1015->lrck, pre_div, dai->id);
+				lrck, pre_div, dai->id);
 
 	switch (params_width(params)) {
 	case 16:
diff --git a/sound/soc/codecs/rt1015.h b/sound/soc/codecs/rt1015.h
index b6ea753014e1..e9b498a754e0 100644
--- a/sound/soc/codecs/rt1015.h
+++ b/sound/soc/codecs/rt1015.h
@@ -427,16 +427,12 @@ struct rt1015_priv {
 	struct regmap *regmap;
 	int sysclk;
 	int sysclk_src;
-	int lrck;
-	int bclk;
 	int bclk_ratio;
-	int id;
 	int pll_src;
 	int pll_in;
 	int pll_out;
 	int boost_mode;
 	int bypass_boost;
-	int amp_ver;
 	int dac_is_used;
 	int cali_done;
 	int hw_config;
-- 
2.29.2.729.g45daf8777d-goog

