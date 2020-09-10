Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84AC433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 04:31:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7ED2075B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 04:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KSfX0whC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ILec2zoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7ED2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E14AE1657;
	Thu, 10 Sep 2020 06:30:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E14AE1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599712267;
	bh=sFSnBAivTFd5nT85vb120vUu2mOLRrq3xkVxhZZQuZo=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KSfX0whC2g0XOw4vJAMPhDvpOHeMaYjrX19cdEsmxbFMe/5OfWhuyKemAYOuVRONB
	 Hnzg09HloQQbKBgizbso/TYBJUmNfb+JTABZ0S7WDhyoeossflI11o238SEeZdcZtr
	 6oLOA7PbEfZprwvoatNoXZ1Qsh4xvw+vGCDF08Ig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 389C8F8026F;
	Thu, 10 Sep 2020 06:30:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECE0FF8026F; Thu, 10 Sep 2020 06:30:13 +0200 (CEST)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85480F8010E
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 06:30:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85480F8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ILec2zoU"
Received: by mail-pj1-x1049.google.com with SMTP id y5so3049521pjw.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2020 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=hAy5Z2kT60SpmL91IykD2jWw5/FSREturFd1fEa37go=;
 b=ILec2zoUc0KU5BxTnqkXN5Om6B8Eo4qJ0N1slgBweo70S/lGlECV+9l6zJjySY/Ssr
 UV1k62VXvltDFGiJiIdYUJYV4tCWMGTUAqz4OOwnWAZdrubpCnqEkEDINVE7/mUQKYjn
 +MyoNTrYkTXxEoOER/Nc21vL9nDLR17dOZ1SDdxQ1o4iMbjowZqsUTMonhXuDr5ixFF/
 rsXE2/44971/XvYCkRwmwjT87Q4KAkQPgh67w4hqBogo8Oisj3j6A5nyM+qjNmIlh9Ku
 HkH4Vkt+UolJjBmgylmPS7KJ8RUt4AJRx8eN/iyLD/iGVehPsq0xiaAEhan8NWKCw+de
 QWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=hAy5Z2kT60SpmL91IykD2jWw5/FSREturFd1fEa37go=;
 b=J2eQPivtX5NKD+JS8XmoW3z6uVuaMJ2qTrd9AoXpzvWE6/UV/L+2+7Sfi7J6ohmRGy
 3I+YXaCxLtKOx2utfZ6SaEH6d8PDhCYy6BTfWs+lepEJHw7W4rEfggieWqR2J6e6qbNi
 gL9xyeF45cJReaM/gRMmABhCpdBvdaLnop+Q/hz8M0JcsxrHnZoOuqnLAx2mMMQLH955
 YA3ptthJt+rseTzteFwbsyA0b08cuss0LPWq8w5srSUF/45HK3mqKYvCa8mn03qwyfFb
 l2oHpUo/rsg5h2xh8kaaLmd+jHGrdpJSst7+RKAuecJge2q2IMHqnQ8g4H8yiM/C0Sjy
 Duwg==
X-Gm-Message-State: AOAM531gbcAwCzZTYoBagf+xqgT8REXrqIo1xpeh8x9SN6aOVqXkhcOp
 jOCx5f/KgY7apgY5gUnDuRP6utXHMIUi
X-Google-Smtp-Source: ABdhPJwklslF8ArwRjHIfyNKvIleNfPMPKLD4J6oOgDVxTevsVkaxsIkSpQnvvFjvBcvLU/mUIYU52tcbNnj
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a17:902:6ac7:b029:d0:89f3:28d1 with SMTP
 id i7-20020a1709026ac7b02900d089f328d1mr3878871plt.13.1599712198295; Wed, 09
 Sep 2020 21:29:58 -0700 (PDT)
Date: Thu, 10 Sep 2020 12:29:47 +0800
Message-Id: <20200910042949.3795682-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 0/2] ASoC: rt1015p: add rt1015p codec driver
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, tzungbi@google.com
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

Adds rt1015p codec driver.

Tzung-Bi Shih (2):
  ASoC: rt1015p: add codec driver
  ASoC: dt-bindings: rt1015p: add document

 .../bindings/sound/realtek,rt1015p.yaml       |  36 +++++
 sound/soc/codecs/Kconfig                      |   7 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/rt1015p.c                    | 148 ++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
 create mode 100644 sound/soc/codecs/rt1015p.c

-- 
2.28.0.526.ge36021eeef-goog

