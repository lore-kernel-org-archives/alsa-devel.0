Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29C5C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:10:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6AC23142
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6AC23142
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FB5517B7;
	Wed, 20 Jan 2021 09:09:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FB5517B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611130205;
	bh=3CmGx8b07JiF4eKVpK2DwRUPW2WP/stAaZ1aTFysffY=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d5NYntf+THpaHF5r3Czsylc0XsKojao0kzb6DPZw9wb+JaUzWBknn7wL46Ctgtdjy
	 ch0XT5xPglJ++mpr3r8IWczJtwX85iTEfgl/4XxeGp76x/UbRZhEo2Di/QU0iSaT0b
	 WH2u9o0TWFtANGoA1lusuQnnGBgr1vt/ncIEyPgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09D7EF80137;
	Wed, 20 Jan 2021 09:09:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84F80F8016E; Wed, 20 Jan 2021 09:09:13 +0100 (CET)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A090CF80137
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 09:09:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A090CF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Ks8OjTqH"
Received: by mail-pg1-x549.google.com with SMTP id s17so17776483pgv.14
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 00:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=2UNkLMKxfUH8wVYMI68h+KNHu9g9Zcj2Vy8Bc2Qv/Hc=;
 b=Ks8OjTqHIjYprKW3LvMP4gjRw0O9BI9/7jpsol3gDMtB/csmL9DD4/q2F7E+LSvWfB
 Y5RDv9OUHYyjjxoGzy2br/wyVU5zUBR8ykqUaJKmywnBdptEIiCX08GBzsoExgK5IZqI
 49+AsQWHu3cduFAVW0NxW+Tv0AFErHPQsmmwGlXKPqPZxRuwEJ9CT5wUYYncFf+3PMdC
 adL9Pt7ZiM177nh2grAl6uQWGCFT8ZlIgzRgfz2MfQfN9eHg2fGLhF4CpgFBqyy/ssge
 Bl15gltcrONhgD4dLe/EwinT0ENCnIYB5R4GVY62OYC7lR0lq7vgk7jc1wF60PH0pZ0L
 Xm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=2UNkLMKxfUH8wVYMI68h+KNHu9g9Zcj2Vy8Bc2Qv/Hc=;
 b=SCR0j0Mz1q176kCDO49uB+o6SVhyB6m609KdTMHEcyj1erxNg60ZFuSmWcsP/D39TA
 UrSsI4/zfisUh1949cb8xW9ky5NqSMFbwe8yX/8uzkS4Jbs1Ts1jGtfcQBdrgdj5xD0e
 /MwzoJW28soJm+QvGxUX2Xo0gViKHst7iVNfk76upYuITxTzWAGxjavNNbf2yQShkWz5
 nhjU5Lxgl8XeN9W7uXOPKgvxxB/HTwN0Y0+Okxw1yQKqOcSUijJRug7bpDXllGd5j9Ig
 wyurfqxDUvxJNVEgymmU7uOATrwerWp6fXyIXAPzCr6YDwYH3dTYNvO3RAhfo+ibtVTc
 2WMg==
X-Gm-Message-State: AOAM533T/YStxFsKZmhavC2ScilhBxCn8P9ozAIXS0yCdBWDfdxhMS6B
 gxU6mMba53PY7xFx8F5tblbD9IxtvoXH
X-Google-Smtp-Source: ABdhPJySxvBQGrSjMO641lZBxijWdD5f6vHmOkMVTyalC71ml4qudFLKXinOfQj3ivSslIEKR+YVzrFP1jo3
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:1164:8893:969a:b338])
 (user=tzungbi job=sendgmr) by 2002:a17:902:8687:b029:dc:2a2c:e99b with SMTP
 id g7-20020a1709028687b02900dc2a2ce99bmr8854136plo.37.1611130142800; Wed, 20
 Jan 2021 00:09:02 -0800 (PST)
Date: Wed, 20 Jan 2021 16:08:45 +0800
Message-Id: <20210120080850.699354-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/5] ASoC: mediatek: mt8192-mt6359: support DP audio
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
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

The 1st and 2nd patches refactor the machine driver.

The 3rd patch changes the platform driver to support TDM 8 channel output.

The 4th patch adds an optional DT property.

The 5th patch makes the machine driver support DP audio if the optional DT
property is specified.

Tzung-Bi Shih (5):
  ASoC: mediatek: mt8192-mt6359: move headset_jack to card specific data
  ASoC: mediatek: mt8192-mt6359: simplify mt8192_rt5682_init
  ASoC: mediatek: mt8192: change mclk_multiple of TDM from 128 to 512
  ASoC: dt-bindings: mt8192-mt6359: add hdmi-codec property
  ASoC: mediatek: mt8192-mt6359: support audio over DP

 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    |  5 ++
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c    |  2 +-
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 54 ++++++++++++++++---
 3 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

