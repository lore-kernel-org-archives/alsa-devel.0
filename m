Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 13:53:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C8F611BF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 13:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C8F611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6005B17C9;
	Tue, 11 May 2021 15:53:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6005B17C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620741235;
	bh=hQIwNYmQ8VVWjUe6Qfy0Fi3EoWnmJXX96ryC/N8Rlmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bsDLCUShaUEau4RtGnJK6cV8LL0Gpw7X+XomS0+zHKK7woWteDSGaiGmX2Mj72o1K
	 6ixcEs8KQlfydxkNu56qbKbYQ2AkXsySL+QVRHkepfpaE4U1/fQ6hiojlB2G6X8j+0
	 32hk/jWKVVmnjANd0+cet+Na7HfdISL581Q/lG3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA05AF80156;
	Tue, 11 May 2021 15:53:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5E37F80163; Tue, 11 May 2021 15:53:02 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFAA4F8013A
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 15:52:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFAA4F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rkV2ifSy"
Received: by mail-pf1-x42c.google.com with SMTP id i13so16252706pfu.2
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CD4qa8FyAT6mL+EEYGbyY0wBygRbxbqBvXVGfdE2Evk=;
 b=rkV2ifSy2lgtlbUuIgsoXLgXbRczYROMcDPWDUkJztxrvOZBBmI1hMd1/9aFfI7jtW
 Kjr8ljJDkO86QZrT/UZ/xc1c37fBOm4FaAjy94m+mZRJ1m/lf02CHIu+5tAPqQuPoeEg
 cGcukqqcyQ/wWa0tN7rrtVS50I3UX2tK3+sLpMPdrhiLTg1UWWlf9XePKCvZCfsl1Vqq
 jiXznX0W2LWVsB1Z8u/cva4Ky8LMdejJYKNYFM21INGSj3SnSEvFz5Q3aYkeKHkeB8pU
 5VADP4sstpdIkF/dacfeYAwC4Xidv4U6n5fhLj9B4ryRrEwv/gqCKkFnEC85eMBX4VSD
 Htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CD4qa8FyAT6mL+EEYGbyY0wBygRbxbqBvXVGfdE2Evk=;
 b=fHpDLMexQVpTpUfnuA/z0DR4S0FFDdkI3gO3QCdNrRpQmmxFuHORFwLt5eCJDVDu9h
 dawlvRbF9KAEmUP4nwz7MoaxES0Q9Nmjj8JP7bPfaK9P4Gfza7egBFF3NIh4Exvba5rJ
 4OizhXohncutE7Nvw4VVEUGaGwFAPL92ehEU3V5fm/2YUhPBAvQx3WpAYxYnxViFBexS
 IzKJNKhi1WDTVzUTnjcWwzWNVmhiYkVn7gDk4z6MCoDj+mghZTeZk5fHK1sc3gxJr9Uu
 hgbjSBZhCwCX7pBaBXFULHJ0CV5Po3NsFez7bjo8khokRGH0/zeiiS0oYQYQ1poifCrL
 /O7A==
X-Gm-Message-State: AOAM533+59UVOCAF5kCiehEOJlylh8jWryaXMy1nOCEZitq+ORdG25ME
 UvTsibPHJaPgTP6qdQCl6iaRhB6OZa71MHTGEiE=
X-Google-Smtp-Source: ABdhPJwnOIQ3nc4MPpWcwjkvu2Scafr7CXpFjmL7/aVxuFKV7X1yh5DoeflKHx9vByTnLfY9SeLH8ybUmya74kme7gs=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr29900674pfb.7.1620741176603; Tue, 11
 May 2021 06:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk>
In-Reply-To: <20210511134706.GI4496@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 May 2021 16:52:40 +0300
Message-ID: <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

On Tue, May 11, 2021 at 4:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > > > Set of cleanups here and there related to the SPI PXA2xx driver.
> > > > On top of them, adding the special type for Intel Merrifield.
>
> > > [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
> > >         (no commit info)
>
> > The above patches are effectively missed.
> > Anything to fix in your scripts / my patches?
>
> Like I said, patch 7 didn't apply so you should check and resend.

I didn't get it. I have effectively rebased the entire series and resend as v2.

I can speculate that your scripts have a bug since they might try v1
as well (as far as I can see they usually send a confirmation of
application for all versions of the series in question).

Sorry, but I do not see an issue.

-- 
With Best Regards,
Andy Shevchenko
