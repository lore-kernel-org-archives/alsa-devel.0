Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F9C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 12:28:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F4A61420
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 12:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F4A61420
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 266A416D0;
	Wed, 28 Apr 2021 14:27:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 266A416D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619612913;
	bh=VIFt4DnASmIc0rYsMJQQLFYWnBR2MWGXA0eM6Q1LNkE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLsIRZe7D8zdrs9c+3fkzpdm9BjIytJdj/ELd2c/jkgdTaFKV7SqjBeo87UyotTjp
	 iJuf171wnAcrABqO9qcn84hIUgeChdG4GFC0rSugPEVYD8WzVbvcC8v0sRsS40AswG
	 xp7ef1adJdZOPzpO4rjVRMH590OfYj3KK2ojZMQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96D68F8025E;
	Wed, 28 Apr 2021 14:26:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9158FF80171; Wed, 28 Apr 2021 14:26:49 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59608F80130
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 14:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59608F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="GbiOuP+Z"
Received: by mail-wr1-x42d.google.com with SMTP id l2so10508041wrm.9
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mq5mQkRS1/Si/vDDQIIoPNxNsDItueuxM0NFUO8KGvU=;
 b=GbiOuP+Zfq0WtKT1Gz3U2J6/6JGvZlhycSoIe1ZtjST8VNRC7IwMCQL19wOWNL00xw
 3fmmNd5BdiXaV8rbd5o5AhO+ROk48RkMVvEIu519KsTE8CZMUhwNLuWdxCqyBIDp5bsZ
 qScvt8dEhNhwQ5vECkvzV56z5J81kp40NSrrqSuk9/0C6YlgTvhutDYLirayNbTSwhgm
 xZckvnh0rfOhVGpL2ah1lZnETsI194xRMxTxW3YXhCkUN2ur8F3dQQDtcQlcZ7hoHdJK
 IFVxFte0FRzTlKTEAYrmWud/Xr0Dh8BvHfm9yhRDlGEAyiBGBYAo5sNSugG3Ed4kF8wG
 +krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mq5mQkRS1/Si/vDDQIIoPNxNsDItueuxM0NFUO8KGvU=;
 b=DOpwy5fU9Z17oo0xb4u4OTLUNycr77d8iSx9Wv4aJgoVj2VJLmXKafoyEZaw+ZAISi
 /g/nY/t48hDuYVXLiGj/xz5C/4i730npS+2U6OotAnFmByRl3CB82HIGBpJMVpYMejD4
 /FHKxHV7aYNa+hfVT9KmF5N9Yqz4crQSOhdKfcVNtvqJUtAY5iPWZKdHwBeE/b6XOogm
 szMtoXeVIurodoix1E+s9SO9L5CSWEXOU/iojBNM9E4b1cfooQY+PqCxVrOXo2+vfVHs
 JqzS5X4PtsuQ+n7RCZILj52KJL2N/6sToLc0a8EYrZPfR9v7kIAxmN6ASz4++PhzvXe/
 vzNA==
X-Gm-Message-State: AOAM530s59uqL4Cu91rfKQiLA0FpsliBGQlvVwvIVU+DC1hPPTGyPRp9
 TIHokdZqIFpFgSUXL+2gkEL1uaFyoIzccvkz
X-Google-Smtp-Source: ABdhPJyA65vTcGjZeG06k0Wrhp8jdCphSvGpg9OIl6uZPja/c30vy8MbqaTSisAtX2IBFwB8ZE09Sw==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr35729479wrj.90.1619612801917; 
 Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net.
 [82.65.169.74])
 by smtp.googlemail.com with ESMTPSA id 6sm7872021wmg.9.2021.04.28.05.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: stm32: do not request a new clock consummer
 reference
Date: Wed, 28 Apr 2021 14:26:31 +0200
Message-Id: <20210428122632.46244-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428122632.46244-1-jbrunet@baylibre.com>
References: <20210428122632.46244-1-jbrunet@baylibre.com>
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

This reverts commit 65d1cce726d4912793d0a84c55ecdb0ef5832130.

There is problem with clk_hw_get_hw(). Using it pins the clock provider to
itself, making it impossible to remove the module.

Revert commit 65d1cce726d4 ("ASoC: stm32: properly get clk from the
provider") until this gets sorted out.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index c1561237ee24..3aa1cf262402 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -484,10 +484,7 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 		dev_err(dev, "mclk register returned %d\n", ret);
 		return ret;
 	}
-
-	sai->sai_mclk = devm_clk_hw_get_clk(dev, hw, NULL);
-	if (IS_ERR(sai->sai_mclk))
-		return PTR_ERR(sai->sai_mclk);
+	sai->sai_mclk = hw->clk;
 
 	/* register mclk provider */
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
-- 
2.31.1

