Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D8C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 03:23:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8984964E0F
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 03:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984964E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 393B01712;
	Wed,  3 Feb 2021 04:22:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 393B01712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612322588;
	bh=EHnEUDbfZoCQYLx07hiNYEKRvesqMt3JznZA9wkbkFo=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HpA3/My/NuDwvvliQvHYGPnU4o0ebCmvS7tARvEeDFfjCP2Bd3vPR+4bWV6AAtPIM
	 Zsyol+hz2nUzwoowHZQdT8IuSbgZUIbzrN+oLaPPHwICPtf5X2oOuYb7w2mssD0DfY
	 x9uli2dprRhOywedxdBacsSMvbxjkl2dEvbJFtqs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4773F8016E;
	Wed,  3 Feb 2021 04:22:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD8C7F8016E; Wed,  3 Feb 2021 04:22:16 +0100 (CET)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64829F8013C
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 04:22:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64829F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="eDKGma3O"
Received: by mail-qt1-x849.google.com with SMTP id t5so16009038qti.5
 for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2021 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=3JCWNGE3ZyHScHCRpa74xaQod1lp3UEEsNxgKZGh2Q8=;
 b=eDKGma3OLADxHCW4RNz8X6h6XoD7erMEsEBfk/GM8gvFcSLASHNS9DUKdLeZT4wlsY
 dNjbEnb7jDwoutHVBb6oAudu6nBKgquEyt73Jiq/6/KNe3t1wDKM99ZkcK0xTM5wyzWy
 Ej1MqQuUcpXCgHdLPxYG2svploqC4hUOhImVBeUg44Ola+E+lMu0UDTP+e/UzYip+Y6V
 52VnVIK6H6xnulbdAEo4/ojeB5wlftv8i37ulmAlalESAGmemf551bFxoIA8758NJalq
 SbpCxBAEHNigWatzz2/lBVxgCRETbcgvLlJB8X7IxudlYsWGU+Twod1XyvNYsbJwkmb/
 Je/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=3JCWNGE3ZyHScHCRpa74xaQod1lp3UEEsNxgKZGh2Q8=;
 b=RVv7ironeEt9A/uOu2qr5ux8DVvdJewLHcUEOFepZPSXt/ePavEj0OxilqIFnSTLdC
 VLdqC3ppGMGkaiLT4ULnCNukwBZfQ3Ndk/1zNtDOW/1jMsC44KzSoTlg+Efbmlv8bKSv
 i+z/NVtdGSTCXrHhJmczGdUfMEZL6azp64ZRkQyzpseMfYqSFD23Iofl60R5etyXYZcX
 4Z40d4TkkqTyD8nF3m/4LahVeUacxI1V9Xx9WDCTzvzQW1tKttqRMYTtCuzO5yZqsl1U
 OmpLdQgQZqqTKXnc0QeEy+xh7GUFbM8m7V8oeQOL45U40LLFHjD4NgpWZgwC72XyrDCY
 v+Iw==
X-Gm-Message-State: AOAM530malCXrUJ6ivv+SGuMP10mIoZyDqs0vN7Q0nt8LhlPPugqGzKZ
 YoX1ROlTrXzMGt2zlErSdzyjfLy69cyy
X-Google-Smtp-Source: ABdhPJw8yE2Gt4m5g/QaYQBjOA4GrUY0ipOVXzsh3sIQDk9S1eZugb0hRrri1byyAon+xGoy7hXiRWWYtKPe
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:dc88:dd2b:a03:4076])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:14f4:: with SMTP id
 k20mr1162365qvw.27.1612322528273; Tue, 02 Feb 2021 19:22:08 -0800 (PST)
Date: Wed,  3 Feb 2021 11:21:58 +0800
Message-Id: <20210203032201.2882158-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 0/3] ASoC: mediatek: mt8192: apply some cleanup
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

The 1st and 2nd patch refactor to use asoc_substream_to_rtd().

The 3rd patch simplifies ops of Capture1 DAI link.

Changes from v2[1]:
- Fix typo in 3rd patch's title, s/simply/simplify/.

Changes from v1[2]:
- Separated from v1.

[1]: https://patchwork.kernel.org/project/alsa-devel/list/?series=420919
[2]: https://patchwork.kernel.org/project/alsa-devel/list/?series=419769

Tzung-Bi Shih (3):
  ASoC: mediatek: mt8192-mt6359: use asoc_substream_to_rtd()
  ASoC: mediatek: mt8192: use asoc_substream_to_rtd()
  ASoC: mediatek: mt8192-mt6359: simplify ops for Capture1 DAI link

 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |  4 ++--
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 24 ++++++++-----------
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

