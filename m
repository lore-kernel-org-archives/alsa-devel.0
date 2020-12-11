Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E21C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:15:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A1E23EB2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A1E23EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5B8716C1;
	Fri, 11 Dec 2020 06:14:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5B8716C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607663722;
	bh=936Nv5lJJ4m3oM4i5V1ULve6M4w02D/jWjoLlIACON0=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oGCdyEfk1ogI094EY0bapXEDL5oeUpuFsrH3h1HiDD74JGq8zaiUhcS9bRgf+0bbC
	 2fFkQDIueVuKE2la4BbB/pZpqANdELSe21UzMpDfEARV+IZEsHOHzPc6bvo4mD3zpP
	 +mVD6tnlY2nk9k4oNXByROwBNeaphxgHFT1xoUvw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F00CF80217;
	Fri, 11 Dec 2020 06:13:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD647F804D6; Fri, 11 Dec 2020 06:13:51 +0100 (CET)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47F2FF8014E
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 06:13:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47F2FF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Ae2o721p"
Received: by mail-pf1-x44a.google.com with SMTP id e126so5597240pfh.15
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=rfrdjp1A4rf9KJuMsS7idMSchmUaB6OkvensJ7rzsxU=;
 b=Ae2o721pPEA/Y5k3DWa8iPjW0VKJKcKE3+YXjpkjA4HelRShUthd410Dcogdrl3Aav
 OylnyT97yo5a8+CLe6/MkXRAsVJ+UFcJwsz/GFDbie6tDRzEphdY7HWWiRfEDpoEb2tD
 vE7+npFa/3QuU1FlwyR4TxUFVv8mBaSJO473yNr28v6yS6d6qVuCkU0OKnee1kX1ypyD
 iytn/hQAMIAx7iEMsc+F8xgaqX3h8LN53+iFt8GUdOSJEPNJhnoOTRQRz/8i/qUH9ram
 LSDg4oPxe5KMXuDdklIWQ88gYlL39PmHboQDy6xBQIUbi05Z03TCP/JAXrAQo3Zof3DS
 7fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=rfrdjp1A4rf9KJuMsS7idMSchmUaB6OkvensJ7rzsxU=;
 b=XEX0sQvp9BPq9ob3//p5j3UCQ8m6t0EtCb7x+KdvdlutZUjjytoCUk6VGdNtE7Zo0k
 qygwFeH2QeIH+7bd1L2pmqQT7TqHn7H5bOXQgUXwqIv4rjyZjEBF4+YpJbym/198WBUA
 W2YAKQg4WGeAcYEL7e/iyBtyXM13EbZFGT2GowLuAq+6FAjtAB7ACaLG/3xXyOtWhs6u
 U2kWfJPZzMlDQFNfO0UeqQ4FDvO2+Y5t6f+ckzMsU/ysMcXzX4KNGMEIovCtHaWME2Ie
 8sff2yGF6DEAmN6MYEoX3tCVD0lxCbMUyu+VVOIoZXIfIlfHW7Ai4UsRYkuWk0lVw8OR
 /dtQ==
X-Gm-Message-State: AOAM533eWnF/Vjviih3hCr3QElLfNhR+xKukz4o6CjFqCZnUqrPDFBQL
 3bm63Aac0CQchNg2vWRKKrArZV+E13u/
X-Google-Smtp-Source: ABdhPJyPjBDpLJO72s3M66CG7vVWXtpLDqpkJ6sG9sT5xrRSWEqBgGBLuggoc2NLDwFnxz2xcImOtvjHqjeU
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr1126371pja.0.1607663625496; Thu, 10 Dec 2020 21:13:45 -0800 (PST)
Date: Fri, 11 Dec 2020 13:13:34 +0800
Message-Id: <20201211051334.2313899-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] ASoC: mediatek: mt8183: add PM ops to machine drivers
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

Adds PM ops to machine drivers so that they notify components in the
sound card when system suspend.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c         | 1 +
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 26e7d9a7198f..078e58f1ad0b 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -811,6 +811,7 @@ static struct platform_driver mt8183_da7219_max98357_driver = {
 #ifdef CONFIG_OF
 		.of_match_table = mt8183_da7219_max98357_dt_match,
 #endif
+		.pm = &snd_soc_pm_ops,
 	},
 	.probe = mt8183_da7219_max98357_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 327dfad41e31..8c8340854859 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -744,6 +744,7 @@ static struct platform_driver mt8183_mt6358_ts3a227_max98357_driver = {
 #ifdef CONFIG_OF
 		.of_match_table = mt8183_mt6358_ts3a227_max98357_dt_match,
 #endif
+		.pm = &snd_soc_pm_ops,
 	},
 	.probe = mt8183_mt6358_ts3a227_max98357_dev_probe,
 };
-- 
2.29.2.684.gfbc64c5ab5-goog

