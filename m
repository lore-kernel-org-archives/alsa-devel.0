Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2643BC433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D18920829
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sdh0JBFa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YCPcf4zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D18920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7458C1616;
	Fri, 11 Sep 2020 04:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7458C1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599792590;
	bh=DUCrnnRvTGJakxtg1kqNCoUvlKaoBoyqkG8BZwDVfK8=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sdh0JBFa8dDHU/QnmzD+h177uYMr19jOWz34rj7Nsz4Brz4UxeMwm51iNi/HSocdm
	 x7cmxEdHQsUTIS6PIcB3/+rsa8/exnEYUA20FT+GZx2m9v2z/wCWVxReFZQPs0yb1S
	 hNaI1u9cCgQaCQlCqu0yL1KHCAzLSDsRB7kGGzHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98652F80115;
	Fri, 11 Sep 2020 04:48:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C554DF800E9; Fri, 11 Sep 2020 04:48:56 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5090CF800E9
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 04:48:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5090CF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="YCPcf4zW"
Received: by mail-pf1-x449.google.com with SMTP id 8so5878007pfx.6
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=bLNTRYbIes188tpc0mDmg8PeKqWkLkLsLS+cEmRfJ4Q=;
 b=YCPcf4zW9n2xKiuS5+Sk6CHvfpFrQXUtAG/znA41cDBEii323Cv+ykNKyUkB3Q5pbd
 vTxTyvi+ZeQTvz26dBGf43cou2OZ128LsjlxxL1DcuH/Echu1+uSnS3hk45Lg2aahSqM
 mr0yVHhFOM6TWFkxi3QJI7EK/LuguF4NyPg6TKV5wt2gOfNRZKBnHeBymysJileSGytE
 YGCIlyEHvzkc2ZsvBC84VwRA9U/HNNP9XBXIIUqwEA0ck/pg2hJLlhQ/5VPiLkMtvHN5
 P/RAOiKrliU8Nxr1woz73U+1dNizWjUCpLgg+YUgJrZuLQKSFk5uZum+4wv5veQHFdM+
 KB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=bLNTRYbIes188tpc0mDmg8PeKqWkLkLsLS+cEmRfJ4Q=;
 b=uYfQdY1YsdZ6QYio9KxlazdbQH3jPHXYeZnFhEXrbq6sbUmsPeqHzghMk8+fI8JrEW
 dkwC2X3WcUivPmvec8c4yXblBHBCsC23ZRNuwcW8oUkjzTQjnuXRXYlMjkPRS4KuE1yD
 EDma6BRHjUjBAbUd6M1p+MX372EDJHl1pPpkmaK8KaGw76n/N73H9LqDYYuEnKGg4C7S
 qB8oiFh8C41exVNJNw5afdqbR19wanyQxXKf6L4UmC69KeuCmlMruY1Qe5M+8UmuBqsL
 Ym81/XS2N4rJ1euuWKQpLzn6oYeLhgwT6CoTOna42Cr/qt108RKboXWgwEQA4BlaBM8g
 /IOg==
X-Gm-Message-State: AOAM533ygW2Fy4Li680A8CXFwKwzXbcNoRBnEV2gcCWPyeMlzu8cdCmr
 EoDMBBRcIRryF8bW6Qbc1wM+kDiBkqY+
X-Google-Smtp-Source: ABdhPJyIfmz+RgSdsE9dxfSUuq4vYwku/EgyIMRrTQZW+Sp90HxOGM4j3hTDem3RAzXvTIqjnn63jWgqGf2s
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a17:90b:941:: with SMTP id
 dw1mr602456pjb.1.1599792528048; Thu, 10 Sep 2020 19:48:48 -0700 (PDT)
Date: Fri, 11 Sep 2020 10:48:31 +0800
Message-Id: <20200911024833.1673961-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 0/2] ASoC: mediatek: mt8183-da7219: support machine driver for
 rt1015p
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tzungbi@google.com
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

The series reuses mt8183-da7219-max98357.c for supporting machine
driver with rt1015p speaker amplifier.

The 1st patch adds document for the new proposed compatible string.

The 2nd patch changes the machine driver to support "RT1015P" codec.

Tzung-Bi Shih (2):
  ASoC: dt-bindings: mt8183-da7219: add compatible string for using
    rt1015p
  ASoC: mediatek: mt8183-da7219: support machine driver with rt1015p

 .../bindings/sound/mt8183-da7219-max98357.txt |  1 +
 sound/soc/mediatek/Kconfig                    |  1 +
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 40 +++++++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.28.0.526.ge36021eeef-goog

