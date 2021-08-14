Return-Path: <SRS0=5JY3=NG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F3C4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:33:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BB460F4B
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11BB460F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4109176C;
	Sun, 15 Aug 2021 09:32:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4109176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629012817;
	bh=KprtPVAQeSYjdjaMhtKd0nT2UBiU8p/mtmM3Tnk+vxM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R858cleWBOvLmbEWprJr/F9lFLudY8baUlZu7F/pBDtt64AjdKq3rhmsAd949QM+j
	 ZEAjCVhP/ObsYxjQtXWrY/E/S969xCx35zKLV7XoisROM7P9Qd0VdQtNpUjT780od5
	 8qbiedp7dhRnGCqB1JH3Inr84EFwhmzMyXDiy5gU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3297F804EC;
	Sun, 15 Aug 2021 09:30:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35EFFF80279; Sat, 14 Aug 2021 22:20:04 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4137F80127
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 22:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4137F80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aw8w4Wno"
Received: by mail-pl1-x629.google.com with SMTP id d17so16175122plr.12
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B5k7GWGp6zz6FFJMpbfsb/wqc1GC34css4EKFgIvTFU=;
 b=aw8w4Wno9Dz2PJ1rQMJgC4h+thEdCERa1X2zFtnQ+64fLv7bgIyTSL/D99Z19mNG0b
 FsG9715dSap8EPnVA9X3bhuYQG7eUq5wNr9lwW4b/0sP3keSGYR9mtQy0KtRPlGsYBeJ
 aOJsRiZZ2WcIVJG0xmj1gFmeBz0PU6ONKogngmKv7PzAH4EvwpHryplf+zsCdT+bCE1F
 0MM7P2QYzuDEjyvdRoGSCRAr6Z1P5bwAJkQEpvsW+xRZC62hQ5+uzN/sN6+YTJbANMtu
 E+LUyEBn2nMzUI1PhqCzlIDlYUVLwyOazsynJd9NukFBEsIuG8+XCCUfAOaMyUhkSobw
 d7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B5k7GWGp6zz6FFJMpbfsb/wqc1GC34css4EKFgIvTFU=;
 b=G8iHQ0+6GxeX/s8CW4VRdUkvYmVW783SGwoFAjiBUIWCi0TAKnrjvmV2I9DcUFTzNv
 CdFL5MOmEZs7jMsSIxKhKzeoJkq/nYMjXwshEcpK3qphe253x1nT0C3kWsSo+x9//L7y
 XeVOZQUtFinyK8UN1xV8sxzYuz2IrHxfe4prBw/Ys49wSU1JqfYoSqTTly7mARwwoBTX
 iIilP0IT/Sqkr1B9/1GpV9FLq79qc926It0AIdNFV5clo19r9XgD+gh+FNghvMkC8ETn
 jeBTfXFBZls5xv3VYGCIzyKh5ZmeWaPe7PLXt06S24Ny7DPmI/5RToyfysqLMl3p00yc
 BjVA==
X-Gm-Message-State: AOAM531mTvoBWY70v9SmQgE/PgUhiV8PK0ICkEukhhWvXbPfdx/4MC6A
 Cc3wg/5EGWWThjP/iE2d27s=
X-Google-Smtp-Source: ABdhPJzQa6P1b996Rhma2rJ5WA3QLSQV46gIgVX4Uo6Z5DywjTwgLpQESuRb0uCzCzIYFEiSlhRihQ==
X-Received: by 2002:a63:b47:: with SMTP id a7mr8201504pgl.181.1628972393665;
 Sat, 14 Aug 2021 13:19:53 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
 by smtp.gmail.com with ESMTPSA id u13sm6413121pfi.51.2021.08.14.13.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Aug 2021 13:19:53 -0700 (PDT)
From: Aakash Hemadri <aakashhemadri123@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/3] ASoC: ti: davinci-mcasp: Use of_device_get_match_data
Date: Sun, 15 Aug 2021 01:49:39 +0530
Message-Id: <ffe9b568be52cc075df56bbf07f20a92cb54f07d.1628972198.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628972198.git.aakashhemadri123@gmail.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Aug 2021 09:30:27 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Bjorn Helgaas <bjorn@helgaas.com>
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

Prefer `of_device_get_match_data` over `of_match_device`

Retrieve OF match data using `of_device_get_match_data`, this is cleaner
and better expresses intent.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 sound/soc/ti/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 56a19eeec5c7..b26e8d324078 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1881,7 +1881,7 @@ static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
 static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
 				    struct platform_device *pdev)
 {
-	const struct of_device_id *match = of_match_device(mcasp_dt_ids, &pdev->dev);
+	const struct of_device_id *match = of_device_get_match_data(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct davinci_mcasp_pdata *pdata = NULL;
 	const u32 *of_serial_dir32;
-- 
2.32.0

