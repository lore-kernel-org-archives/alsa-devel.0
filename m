Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B6C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:20:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766532067D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vZNyGFzk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rawG1LNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766532067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFEB41676;
	Thu, 16 Jul 2020 09:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFEB41676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594884043;
	bh=0xQ/am6woNxh3DruGf+dAScKAPL+8zkB9Nmyj1htUOM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZNyGFzk4Mja7PnEeIq6pH5HlRK6/vlk1zaywKTHmqk4gIw/wdGgvFS3IoDnLgnyr
	 6y89vvWCShSEdyMq7knV4jKh3t59zxanCHDnFapMCEYJFJJDsoJtFDtInY3R2OS0Q+
	 tbkolSyBWfQKch7JrYMdgm1cexzW2Mq6sowxNkBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C450F802BC;
	Thu, 16 Jul 2020 09:18:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06A97F8019B; Wed, 15 Jul 2020 02:24:24 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9DE1F8014E
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 02:24:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9DE1F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rawG1LNi"
Received: by mail-wr1-x442.google.com with SMTP id z13so571577wrw.5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=iewP6kBBGkoM+NWaS3DfjUXvQDRr2nJUEdxQPlIIFM0=;
 b=rawG1LNi+RAb1ZzCXDdwd32vQxg7rvvqBJiHSOWkRGlttzJ8pqTMEsWwmtvcFKTfvX
 Ut3tOUR0s/AkQSrZiCrJPS/biRHToPRz4/PNQCMbo0JXds3zuRERaseMpyG2TBD7mmJZ
 BUzLpGxAKG4ZT0HCOA0muhLorV7Hu7vPPmQiGiF7pNPAjvcTeyWcSRfL7IDCheONIV/d
 oQ37wF3EFBlLSQYn1ub1ASjtUacrWtnJSvc3YkreYTZRTpEgBOKJRvA21bNq1iARoA0k
 nbTjrN+yr10T/FQ9DTbEZylp45wl6ztXkPAb81ALO+Fp5ecOwRiEhvCHRGddgWsggOWK
 JWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=iewP6kBBGkoM+NWaS3DfjUXvQDRr2nJUEdxQPlIIFM0=;
 b=SY9CcmTdaOFF0mHVmkvQIA4VZyuyoK5uCjnWjeuR4qb0yzg+oCqMLXNXZS5eVBydJt
 wg4tPcclqpwPrLQdhPprf1lnXFYdChTfHJbVJ09mP9a4DmefkLPOI3OmYBBPmuMaWafO
 HQwzMr2I0ddKgO9iVCtjTukFfmyYO78cqu5AsSMiC5YMeo0iORdviBnp3gXo1I33xOez
 3da7NlrTwM5YtL9wVvNTFKyMGGBT0GSyusvbTcX/hRQaVh8wEGPk+Xt31f4uY+mc2MtT
 rjO+ZTYnpYaHQ67Gc9Dl/J/PQ6ZeR52yREqlRfdpcjxivOnCm5yg/OJn+/OeDKLtmYqu
 iYuw==
X-Gm-Message-State: AOAM531rSyGDR2wu8SoY4HCsNoIo6JKeXSyzCbiQwF/HGv+/L9dTkA1K
 hxXnAGXv85UImfzCiKN1WuP/PrFuvLpdS70UjTk=
X-Google-Smtp-Source: ABdhPJzMsiHuahVmxHGl1O1iCFxyz0OXaHxlhJ9mKuK/83xI4YCn4L7U1waH+DACUr56IBhQt1IiTWFEc/aRP/zNFCc=
X-Received: by 2002:adf:82f5:: with SMTP id 108mr8356831wrc.218.1594772656307; 
 Tue, 14 Jul 2020 17:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <5f0e49da.1c69fb81.1ede7.a8fbSMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <5f0e49da.1c69fb81.1ede7.a8fbSMTPIN_ADDED_MISSING@mx.google.com>
From: mnlife qiao <mnlife.qiao@gmail.com>
Date: Wed, 15 Jul 2020 08:24:04 +0800
Message-ID: <CAGjHXR2ExzMO3ntwzZy9QUhpuqe-VZAXOucNkXXZK+0XZcaQWQ@mail.gmail.com>
Subject: [PATCH] ASoC: soc-jack: calling snd_soc_jack_report causes a null
 pointer access
To: lgirdwood@gmail.com, Jaroslav Kysela <perex@perex.cz>, 
 open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, 
 broonie@kernel.org, mnlife qiao <mnlife.qiao@gmail.com>,
 mnlife <mnlife@foxmail.com>
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:18:09 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

When snd_soc_card_jack_new is not called or the call fails,
calling this function causes a null pointer access

Signed-off-by: mnlife <mnlife@foxmail.com>
---
 sound/soc/soc-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0f1820f36b4d..51b799ee98b7 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -44,7 +44,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int
status, int mask)
        unsigned int sync = 0;
        int enable;

-       if (!jack)
+       if (!jack || !jack->jack)
                return;
        trace_snd_soc_jack_report(jack, mask, status);

-- 
2.17.1
