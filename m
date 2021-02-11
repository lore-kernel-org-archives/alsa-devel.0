Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 08:42:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A9A64E05
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A9A64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EACF016EA;
	Thu, 11 Feb 2021 09:41:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EACF016EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613032920;
	bh=l0uZb2k98Qq2wTz02gk52DaMWSWX2uq6nC8ZPoKNse0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsSl9397MUh/yRaJBLEKfiZUCvmbeht+g571xJObW75ToRdBTD6ufqf66iGo5a1iG
	 T7/lQ1c5/eVxYCZeiv9EygDPXOnqNC9uHkoio5oD83gjPHOjzBZACJg5GviEUZw2s1
	 qnjaeSoyV1CgCI3EMncFPt8j/CcS9Rdfz5EJS7BA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69903F8016B;
	Thu, 11 Feb 2021 09:41:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01D8AF801D5; Thu, 11 Feb 2021 09:41:07 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C78E5F80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 09:40:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C78E5F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="kWQF1mop"
Received: by mail-wm1-x331.google.com with SMTP id m1so4708944wml.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=IdP+qyRSFybI1/gnZTWLtvslIUuKOdoDM3GLkBcoXRI=;
 b=kWQF1mopki4JCJLZ0q88KjoCNZGWx9kCDvs/srjKZESDvNeL1lJ0cJQk6yKZV0+St9
 hAfy8w1RX94b0SpG3RL2cs26QEzBxnBskmQ6l6m2bUM4sQd6OdPb/JVM5q8dbcG7CYrz
 Vn53yJ3gbLqwl0fjAkPN23h2YgCHTDWJD13NdbBBBvb5UnDzdkW2BFMOlaNzmj6IULlP
 LtGXBWKgWUM90oKKD1LfUj95lVFpHPgd+unGOrUkAf8t1VuOHHhai/4/KtRoBILvb7Nw
 fOF0z4RJIlNP/hmFckZmpuc3v0zSAfP6wyslDhQEYiBjPqLuj33f6xf922/txrVo9uUQ
 VOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IdP+qyRSFybI1/gnZTWLtvslIUuKOdoDM3GLkBcoXRI=;
 b=GhesqcNEWV5PskY3X9TmzqfsVZf9ajxF0EVHlBZOVMYCkJ7rFf0dg+qeogDx0BtkcW
 d2+UhloF4MbVMgSd1fkagdMq7TdBIauPZX2qQRcs9MhR2Z19lvXtSvVdbb/B7wx4vtTS
 o26+fQWkF9TlgVTJNGjhxoctguuarYK9cxBZEpvmbzNqmesGy5DMmC+yHsbB16VNXR1P
 6uXqn3suBoL7xC7JYX99qTsU2vZEpLFeVWqn3sH45xhjhZdvKyI/YEVNfuhEW3wWWFhL
 P6SyBD3ZllXT5uXPfhG0xRpvfQE637oq55+rWDGCIYLxOq2HrwBm5Je5unY8pVKAlbAk
 hGTA==
X-Gm-Message-State: AOAM533z9l4S4tXbKvyPdrhfJPXYDa3z6XjGiXU/93fSwrEhiKhiXPoG
 hFFx96v1E+29bvMwgPOCt4v13w==
X-Google-Smtp-Source: ABdhPJxqlintMbTctXKkk2dBHU/1iC2hNdGDbuAnHCrU5zv2rKdmvfxPBiegzVWMHdRp3seLp2WNww==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3885442wml.116.1613032858007; 
 Thu, 11 Feb 2021 00:40:58 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id g62sm8632458wmf.46.2021.02.11.00.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 00:40:57 -0800 (PST)
Date: Thu, 11 Feb 2021 08:40:55 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210211084055.GA4572@dell>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
 <20210209141420.GE4766@dell>
 <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
 <20210209154511.GC220368@dell>
 <20210210195700.GG4748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210195700.GG4748@sirena.org.uk>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 Chanwoo Choi <cw00.choi@samsung.com>, patches@opensource.cirrus.com,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
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

On Wed, 10 Feb 2021, Mark Brown wrote:

> On Tue, Feb 09, 2021 at 03:45:11PM +0000, Lee Jones wrote:
> > On Tue, 09 Feb 2021, Hans de Goede wrote:
> 
> > > The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
> > > in MFD first, which seems less then ideal.
> 
> > Well this set isn't likely to go in this cycle anyway, so actually the
> > problem should just go away.  Best to let the first set get sucked
> > into v5.12, then send this one up subsequently for v5.13.
> 
> Yeah, that's probably easiest at this point.  the only other option that
> looks viable would be to add the MFD and extcon parts to the branch you
> already have, me to pull that in and then apply the ASoC bits in ASoC.

I'm not taking any more patches for this cycle anyway.  Best wait.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
