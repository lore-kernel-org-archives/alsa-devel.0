Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F33EC76196
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Apr 2023 08:58:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3823A4F;
	Thu,  6 Apr 2023 10:57:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3823A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680771479;
	bh=FfpbONZypWjgRzS0PHtdPlYBnwJtGsTF2GYi1GhIrmk=;
	h=Date:From:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eAyShYjesH+vn69xmdpkh/DeQwXku11u/y9zpmWdS+nohK1OXzoHkgn6koQXSMY9V
	 RIwGgo5B1vyyx5qv9NYGaIsnycJResXaNRkDv7D5qxpbkiAg7if26HuLR7S0qE+IDb
	 QIWesnnf7zzck10D+LpnJUc5sIxlrL0T4Lpo1fBY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CA31F80533;
	Thu,  6 Apr 2023 10:56:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E461F80533; Thu,  6 Apr 2023 10:56:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3BB1F8051F
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2023 10:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3BB1F8051F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=UbQmeUNa
Received: by mail-wm1-x331.google.com with SMTP id
 v6-20020a05600c470600b003f034269c96so13116332wmo.4
        for <alsa-devel@alsa-project.org>;
 Thu, 06 Apr 2023 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771379; x=1683363379;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9Kdnu6pWU6JngfT3ASHVDK3Q32SnxG/gqB2Vtaw6uE=;
        b=UbQmeUNaGxqXV8cdupXlUOSJ1lkWClQr2ZiZRedNp0nBYQeKzEA4Ml4c3TGZpx7te3
         Va8EX3exUgL4dZnmcFFQ7vVFMKT1fSFc4zlY5czZ/czINhmbptwL/YpBNaoue+ox7gSo
         9MueZF3tMcsZaGmnGyWomB6EjP0eXz369Z4TO6L+dO4xG8psxPM+34ssHFQfMUAXfCkT
         uaSr77WKKCzbDs2E6AboSq2B/vPHcxnta0goVmoeHuVd82q8Nux/h1MTeFE5JnFsWhaQ
         8kkYpUYXLGA+AaaCVf0rMLLjKEU7ACFpywK+l1BK5I34vhV6OdE4v/tdgZXMqi8ttaEC
         AIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771379; x=1683363379;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Kdnu6pWU6JngfT3ASHVDK3Q32SnxG/gqB2Vtaw6uE=;
        b=i2Fzc49nJtGr/gRxn4TSkyHr24an8VZ9DoVIWsAkpvXkeuAlixRFenEITKivZZSADl
         wClFVkIcTu8Ki+YkWJpTnL8zHsI1jXhWFA7BzcYry2bis53qX4puN+k6a8IMEPvuI6a5
         QYBAMVeOO4Du08qIP+3r4T4ce1aSnKJuOTJtJX3Vn1ddKazyr3C/wh8Cs0tq4oHhcFDR
         NtMKz2zI31/yRC4Rv3+bJ7x8xiIUZlS2wwu++vxUxGgvXR+5y1Cb8BiULUipz/ZBzDUp
         n+7uMdleo7TWZEUeYRu7j9k41TTuFaVa954c9pdu133OK6Q8ymtrv4zvRJfLKKXQacYT
         1/KQ==
X-Gm-Message-State: AAQBX9d657XtfKlzjksLwxBgjTzjLMtlkuGxpin15rZ5R6vo6GjkTq71
	TAoXcovP9db0EtKvss2NmMw=
X-Google-Smtp-Source: 
 AKy350ZuxTCGF6FAybs+H9pOieULS+SaRroYklAtuYdOERGcF4RL65O7ukIKRncyeouzdv6vz9jBuA==
X-Received: by 2002:a05:600c:254:b0:3ee:2552:7512 with SMTP id
 20-20020a05600c025400b003ee25527512mr6402080wmj.13.1680771379290;
        Thu, 06 Apr 2023 01:56:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 c24-20020a7bc858000000b003ef5b011b30sm1001876wml.8.2023.04.06.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:56:18 -0700 (PDT)
Date: Thu, 6 Apr 2023 11:56:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] soundwire: amd: fix an IS_ERR() vs NULL bug
Message-ID: <3be30516-a1b0-412b-8379-06011855e46f@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Message-ID-Hash: QYBVSEBLQO3VPVGHYBEG5W7N562SODUH
X-Message-ID-Hash: QYBVSEBLQO3VPVGHYBEG5W7N562SODUH
X-MailFrom: error27@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QYBVSEBLQO3VPVGHYBEG5W7N562SODUH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The devm_ioremap() function returns NULL on error.  It never returns
error pointers.  Update the error checking accordingly.

Fixes: a673a8dfc214 ("soundwire: amd: Add support for AMD Manager driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/soundwire/amd_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 9fb7f91ca182..9bb8ae8c5f32 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -910,9 +910,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
-	if (IS_ERR(amd_manager->mmio)) {
+	if (!amd_manager->mmio) {
 		dev_err(dev, "mmio not found\n");
-		return PTR_ERR(amd_manager->mmio);
+		return -ENOMEM;
 	}
 	amd_manager->instance = pdata->instance;
 	amd_manager->mmio = amd_manager->acp_mmio +
-- 
2.39.1

