Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B97C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:11:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9507364DE0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9507364DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A7C4188A;
	Tue,  9 Mar 2021 20:11:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A7C4188A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615317112;
	bh=rGhveete8wtIwV6aC4PJe+Jq9aY7wefVxCB4EEzRxy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o9NKv1oF5XeEF3+vIGsjz5iGBXI6pgRHX8C/JNRS1LaDOpsVzcSC/dY7OaHL6XfhR
	 mqoXIhw4KEI3iuO5eyWAfcTTarBOu+1EBiFsA4wM7q2b4ZZui8HwTzs6wRFzthgZwC
	 h4cbcCs5l1uPCKHaOWPpdVEX679S3ycT0xsOwj0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E76F5F804C1;
	Tue,  9 Mar 2021 20:08:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80BDFF804CF; Tue,  9 Mar 2021 20:08:22 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9452F8014E
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 20:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9452F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="eHr4XURQ"
Received: by mail-lf1-x12a.google.com with SMTP id p21so28912764lfu.11
 for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2021 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YZtjmevkTD4OwnVekKT3y0VDqJKshXYG7EZriwiqfrM=;
 b=eHr4XURQG7ueBti6UgZfsaOJ82SLWkchlP0UMKAOZVYpvAAINpOK2r2zoV9feZAy2S
 LGrWrwaHz+XMPpMa2XXT/qyXcp2G44njqEEO2ME93vfPP+r4FJnUvL4Y5hJunsJU2n3D
 8nVmVTvOXSpRoP0qE9iqsbYNWv6/EiAI7OBiUzln1CGUpKPI5ZSDH9DnjSp1xSCfxpdx
 rrYpEw6uzKv8P6+nH1UQqP2CdcrjWcoFxrxo33Q8G20Y5UMo+fMthyggJOD/hOylDIce
 7Yh8WClm98Wm+Pz9yOKpoJmZKQFXLkIK7YYqKtUjmCPlJ8JnkNz7zo7RtOLBl4Q5qgMW
 1aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YZtjmevkTD4OwnVekKT3y0VDqJKshXYG7EZriwiqfrM=;
 b=PQZVHbCrYHuE1XfgC18b7ibnwUyjo/g5Buc87YrEfRYM9rMH1D99AYlN6RUjwZgaIQ
 v6J7AwuL+uwXwvs6A7a9eoOk2StrZvXnlU91EhoDckiOpOFtvECX9Uo7X2EFiiI6IXpi
 DbmaBgyaV0AhnKjQvDNwBJaYzliDryPGXzoFc1DM8qQW6SK14muFJTpmThuocJj6j/4K
 7Qn/vDjrAJF8Tc2C/mLEUfgTl1GOo9X3xzYboRlk2a5ywxxd6VQChr4MDicmfg6A3wtj
 4EruU/NcCxnOV9eMGIGMkz04CwMbqCdbckDi75a9Jxus6OiI+1wmKuKN+TLxv2AB03xZ
 tlow==
X-Gm-Message-State: AOAM533hi5AWi6PQJNzQj7IWjPwsG2pV3DQTeUo33d/ohDHGdlQProiU
 srpQPxd7Uo/KMMtmwS3BDC2w8gB1rD/xdCosfCApgw==
X-Google-Smtp-Source: ABdhPJxi4EkLPvb3adcLZHV8k26dgNv1asUlJdCPJWrCcvaEh4Bcr4aFXpSmVPW7eIrxmlqmq3zw37dHXDqoDWOHzY0=
X-Received: by 2002:a19:7fc3:: with SMTP id
 a186mr17385948lfd.626.1615316892281; 
 Tue, 09 Mar 2021 11:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 9 Mar 2021 11:08:00 -0800
Message-ID: <CALAqxLVf2_GJg=krRmwoqX_GxDMsuR6BYOoZfWoFk0dC0xVhOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Amit Pundir <amit.pundir@linaro.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Tue, Mar 9, 2021 at 6:21 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> During testing John Stultz and Amit reported few array our bound issues
> after enabling bound sanitizer
>
> This patch series attempts to fix those!
>
> changes since v1:
>         - make sure the wcd is not de-referenced without intialization
>
> Srinivas Kandagatla (3):
>   ASoC: qcom: sdm845: Fix array out of bounds access
>   ASoC: qcom: sdm845: Fix array out of range on rx slim channels
>   ASoC: codecs: wcd934x: add a sanity check in set channel map

For the whole series:
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for fixing these up so fast!
-john
