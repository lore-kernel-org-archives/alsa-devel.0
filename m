Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E251FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 15:42:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EA764F51
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EA764F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53F9F1669;
	Thu,  4 Feb 2021 16:41:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53F9F1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612453322;
	bh=bX8oK3FyRWuliM/JKiFwsct3FuySc/dDenOBLlopfBA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p4Ttd2xGz+03Y07TMzgnhf5n6ebvUp5cZgMVxQbYwczEI+78Pee8waVO5U4QrvLLQ
	 zE4coI8GPYa5xHvasFGuzRlhOo1DhztX4SS4IGWe2nhYhckjeAf3ggBFqO6nyAM7Vd
	 Z1j3xO1yFcv0EYep+qpRU/Y9DuN9jDWSW6LYFbkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA756F80155;
	Thu,  4 Feb 2021 16:41:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1CE0F80171; Thu,  4 Feb 2021 16:41:09 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F501F80139
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 16:41:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F501F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Z/zB5uJn"
Received: by mail-wr1-x435.google.com with SMTP id v15so4053699wrx.4
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2021 07:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dOiRiQ9oHUZ7TVaPDhFx1L3SPFp6id1hbOQ7qHtfF0Q=;
 b=Z/zB5uJnxrsopt//QvpTD9g6mM8lgWfSZYCbMfgBtPFI13huRpsQXbvjpNBz1kqGo7
 yD0M2i2ywa8zJ3ZJ6DAq2V+Tyv0E5i8QOYb30N1BlY0gyjpCPbRRAYAhaMKzh2fOSISp
 QdxOJcz72OkWYSrZ7Jr6CN+RxpsJu1hricNzLTKXsKpjLMyGHBHq2XdAgYkz/NLYWgKT
 Tw4Q1QgNH22jI1oXKR1gGQwgzW3uiKnq4b/YCxEg3BCu8ITSwbc3b5B5mmSqiNXgDW3c
 VctzYl2LAIkHhYmW+qAje3XCkdfMGNaUePndPUXFCfSKulH/4AD6+lsATCFTLsQwv4wg
 08ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dOiRiQ9oHUZ7TVaPDhFx1L3SPFp6id1hbOQ7qHtfF0Q=;
 b=EWtuv7oDVfTFlCLvVru6XG2wWgktsRVtuGKEGh+PaicCR8BLPnHgjv1Q9CtMTeEQox
 C7v7xzlH1WUimWbLTX+/EFHfSUO+EUKBd43cXJW8yOaTrhPgxTVGIIQgRZ3S4eKNoXnI
 uUJiPcEAtb28tmyY5JtqJWdTSMql4A2itpsy3DsZGbTNTMoil/EduNjxK2o0JG9TT/Xd
 UnLXJhOYxOphKoMWD/w7gv6zkVqCR3S6W81ywCUI8eaKAgIj8Vq597jkCj4xUNniSk58
 2K838hCydG/4YHsQzaauBWnYfKpL00esNg5XF/4P203IEHa4AQBwKmVuJEv3i1aiiEOY
 6Hyw==
X-Gm-Message-State: AOAM530MLptKpevqOs7XgoITc3i/MXuqDPeYuwB3NnqiXvnXX33MFTpT
 Z/jzf/st5TEtKRATHIMFhckeaw==
X-Google-Smtp-Source: ABdhPJzBm2W2BJMxu5DIvoNWvy5QIvZS8Si6KmkT/C/WupGvJ0j2eB7yrbUaANwc84Gx0e2xC89ORQ==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr10054615wrw.255.1612453261248; 
 Thu, 04 Feb 2021 07:41:01 -0800 (PST)
Received: from dell ([91.110.221.188])
 by smtp.gmail.com with ESMTPSA id x9sm6947710wmb.14.2021.02.04.07.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 07:41:00 -0800 (PST)
Date: Thu, 4 Feb 2021 15:40:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210204154058.GP2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204151139.GE4288@sirena.org.uk>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Mark Brown wrote:
> > > On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:
> 
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> > > > Applied, thanks.
> 
> > > While we we were just having a discussion about what to do about this
> > > stuff...
> 
> > We were?
> 
> > This set has all the Acks we need to proceed.  What's blocking?
> 
> There's the subsystem maintainer...

I assume that was a question and you meant "where's"?

Pierre is listed as the Maintainer.

What is a Subsystem [0] anyway? ;)

[0] https://lwn.net/Articles/844539/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
