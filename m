Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C2C83001
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BEC2073E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q/kAePVt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RUEbkkoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BEC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 223CB168A;
	Thu, 30 Apr 2020 10:26:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 223CB168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588235253;
	bh=hQd95vleHDzw9hFvqAOtdCrLVQ3RCFYHWmtV+Xbf+cQ=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/kAePVtvBuhZhxPyKwkNV3M+2aLKZrIuYDFziriNSlCc2jwzb9ajU6/gu44ZefBo
	 mGANcE7XeXNcCJ7p++N0c3GdjPXnoB71Bw5o8swM7aayDZMJsiJNLBakj28oMstqWj
	 qVu7LvkFrsO9FVFh25EK21T9d2Jf5iMzplr37wKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61791F802D2;
	Thu, 30 Apr 2020 10:23:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F6F4F802D2; Thu, 30 Apr 2020 10:23:04 +0200 (CEST)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 422ADF802BD
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 10:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 422ADF802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="RUEbkkoJ"
Received: by mail-qv1-xf4a.google.com with SMTP id et5so5646007qvb.5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=rV3n/GzyDJJeYWEHRQOjMW82xxTBqbQrIp/TzZObPR4=;
 b=RUEbkkoJbg76NpQxWCQwI/0z0oa56+abUUXNTVQo9I7mXAWqBn1+jd5Y0kRrAKdkaL
 vVz66FTE//h31GBAcd0hzgvPOvvHHOgBEaDlVbD7MlyyUWKEBeVF4o5+ajFve2UtVb7D
 bcWHaGlEnwk3ihiqizbwU3QXqmGWcx5Zyr7Hs5M2LgrLKIvGWMWx064DT+P3R1/9zI63
 nFShvJmwg+HnDZT7ujOWhojHGAdc6gZ33IHEbFm+pmC+qmvAuRys2D7L+3ZLLX3nE/BA
 AJZSatcz9KOY5OHNAzfXWwowU0wwUaZNL4h5tE1OvM5l7NFeozatXYPH2UQ92SIJkBzN
 d30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=rV3n/GzyDJJeYWEHRQOjMW82xxTBqbQrIp/TzZObPR4=;
 b=IdHmqoqcPSFuv4SFdikjPnD3xn0svXoWk3spmqVcLJr2zhb25XwwZxvhOsCwRGkmwq
 4B6UhritmkmZU8rdsc4Rln4YgYKPPQIgyd1fbcpSiGXZ+cCDjn2kdCVZcP2QSboFLAWI
 fNfrBh1dJpsMRSxOZ/IjPyVFNsg8/5oRzFxGNxrqDcStVIRd8t5uRJL8fn7NESgMqd8s
 7/JhTtqlHwC2f4VL14XzkbAfKGOuUzor9k+nMCpJ9vnWEm2zJ8Cle2qaLoh53E+T84lF
 MjL0IXutBNrwiNTk2V1rrOGzJa95DN1p9vuPrYVTP/Ga+6Gdp0K9Yj8OM/ZqzavP+2aL
 nNIA==
X-Gm-Message-State: AGi0PubzwT37Lcs4bbIfg/rXi+oTN0OzWr/d+yK4cAQSPwxValjkzNe7
 xEEQwh0xZ295YoeJzHqdarbs4Hv5GjBD
X-Google-Smtp-Source: APiQypIg/GHORj2Fr/8tMqMl7ByOwJjkMqLR9Ff4We6VzkkQtY8X+XOzkdEImxKYLSHrf66GnRMtMKy+mx2I
X-Received: by 2002:a0c:8061:: with SMTP id 88mr1846383qva.212.1588234977983; 
 Thu, 30 Apr 2020 01:22:57 -0700 (PDT)
Date: Thu, 30 Apr 2020 16:22:30 +0800
In-Reply-To: <20200430082231.151127-1-tzungbi@google.com>
Message-Id: <20200430082231.151127-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20200430082231.151127-1-tzungbi@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 5/6] ASoC: rt5682: remove duplicate rt5682_reset() calls
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

Removes duplicate rt5682_reset() calls.  rt5682_calibrate() calls
rt5682_reset() anyway.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt5682.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index bfe542dcc7ba..19fb9f1d8f49 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3416,8 +3416,6 @@ int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 
 	pm_runtime_get_noresume(&slave->dev);
 
-	rt5682_reset(rt5682);
-
 	if (rt5682->first_hw_init) {
 		regcache_cache_only(rt5682->regmap, false);
 		regcache_cache_bypass(rt5682->regmap, true);
@@ -3569,8 +3567,6 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt5682_reset(rt5682);
-
 	mutex_init(&rt5682->calibrate_mutex);
 	rt5682_calibrate(rt5682);
 
-- 
2.26.2.303.gf8c07b1a785-goog

