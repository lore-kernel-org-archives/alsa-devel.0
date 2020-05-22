Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:08:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D690206DD
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OtmuPQ9M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUw+jloG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D690206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD4801881;
	Fri, 22 May 2020 10:07:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD4801881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590134926;
	bh=EJxFyJoNdAj/BSsoR4MMSUlwsZ0C7vcoeZcAJuUxEe4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtmuPQ9MXucDb8NO5v48bPnjv4pxlGc3D4o8N2U9+VPpvVYeK5wLeR71lrC2LBltr
	 q1YdwnmMohc4tqnGZsAzZ14IGhy6xUpV9jiQZotZnvTyLP8lIfHavU/S1Y6HFzPxdn
	 APSVJk+yC0oCW+45Fv14YOAvYnQYDYhHiW9xOlyI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B24CBF80140;
	Fri, 22 May 2020 10:07:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9587AF801F9; Fri, 22 May 2020 10:07:29 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 930BEF80140
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 10:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 930BEF80140
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="DUw+jloG"
Received: by mail-wr1-x441.google.com with SMTP id h17so9226468wrc.8
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=zppcH1s4Oxd9ORuhue+rbyDT8Mi3Zp/h1C3Ys2rA0bk=;
 b=DUw+jloGGhc299DIfCy40tPz3gnwkcYQEQKxyHqY+7liR//WJ5twv8oOqLHVGGT/h2
 nhE3OWCX3YfCCQyfX5bqWQWJ459cXsPhhW6UgbmzIVpvf99rIZyH0Z5o58iCtIh7Zqe3
 QnpyISth4jD1kx67+Vf1mlwYdrkhFDW7RvhxZ0LD/t8MgQAq1sTHd/tbIc3STDAIoeVY
 4+K3ztvNxWxSqHPhk0RH1gitNa62JMMxGFfAqS1PJyksLtl6lq2uq8HYSFbs4DOtdxU3
 VzMLvTU1WuUEvmxtbhWVne0ESHlfo55Jdz8j44QsRAs08h4Upz/hHw1lNeX9PxZCF/ZM
 BdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zppcH1s4Oxd9ORuhue+rbyDT8Mi3Zp/h1C3Ys2rA0bk=;
 b=WGXLt4QYK9jRLraiUdmNVVwSbxd1gZxxEUISFRVCnudErgyfscCsLSRX4qFmxsEh15
 sQOaoiLFZwDTBg+IcvQcoHYblYbgp3+gPCcKbpkb/puxYjpKMdvf3v4rKayrkKum4gyB
 IYqUxx2sqhRZ3/jvkWHzHoZ4EMD4Aww8u0BD22+9WxwAC1e+PfYYAWw3L1977SW19Znu
 KyhajzEzfyWzIzwVMtsEY1/x++21lsHNdWaGqbsA5Ka9WDdkEE7d9MHZG8V/wvowwbBq
 Wx4lNosz67Zridk2v+nPiosWtBazcerH4Uu0LYqDkKbEF+bac43CTYqEVKzIBEChrItC
 +Eqw==
X-Gm-Message-State: AOAM532GeyknEg1cJcaHkJPW30GTr6LCs+2mJcN1569/tJzbDcxg8lqn
 a4XcesNcArtr0S14NAFVyP3a1Q==
X-Google-Smtp-Source: ABdhPJxTRIndbgM1G4xc0xtn0ArdBndodyCpPDChjjPUgMyAMk3EPgXZrXgG0o3HZf2ei4pqk1TCFw==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr2274668wrw.319.1590134842818; 
 Fri, 22 May 2020 01:07:22 -0700 (PDT)
Received: from dell ([95.149.164.102])
 by smtp.gmail.com with ESMTPSA id r11sm7336139wre.25.2020.05.22.01.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 01:07:22 -0700 (PDT)
Date: Fri, 22 May 2020 09:07:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/4] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Message-ID: <20200522080720.GS271301@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2@eucas1p2.samsung.com>
 <20200427074832.22134-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-3-m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> When runtime PM is enabled, regulators are being controlled by the
> driver's suspend and resume callbacks. They are also unconditionally
> enabled at driver's probe(), and disabled in remove() functions. Add
> more calls to runtime PM framework to ensure that the device's runtime
> PM state matches the regulators state:
> 1. at the end of probe() function: set runtime PM state to active, so
> there will be no spurious call to resume();
> 2. in remove(), ensure that resume() is called before disabling runtime PM
> management and unconditionally disabling the regulators.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8994-core.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
