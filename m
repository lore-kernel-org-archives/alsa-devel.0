Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB3C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:19:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E31920775
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PlpO6YNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E31920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D37171697;
	Mon, 27 Jul 2020 19:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D37171697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595870369;
	bh=+BtY1gXQuzt+gs+zPIuIDgEDq3OncCsVhwsW5Q6dSgs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PlpO6YNgUT54IQUUPDUKmhItGwhkDRx/KHgv0rUQ/+2NK+WB/8ZqHKIar/cuBM6aR
	 AXV0LNTn7blRUPjNEGhVF1pJHYReyLboRR/A8DDuTSlk8J9o72AWG+ZRtgfzsp2YQ0
	 xtCAC78GLQJz09IiVI5nrTL7tcwEk1bECQwE0p2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74182F80158;
	Mon, 27 Jul 2020 19:18:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 301C1F80171; Mon, 27 Jul 2020 19:18:38 +0200 (CEST)
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2299FF8013C
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 19:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2299FF8013C
Received: by mail-ed1-f67.google.com with SMTP id b13so10326718edz.7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 10:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0k4jIH1gSgo1iTNyMMauxWmx+NsRK7IQO1nAgcxxRgk=;
 b=p5aJkwQwwSP2GzwkSt7/iTeqd7Ad2EFmS5wvK8AJGX9/3WQBqyPV7Je5vMC1jzWMAI
 KGGbktTR8GI4K5wJfFPtXcTgFLlfRH6OYQpV0XsI3WZPwILK4iFH2yhm4/gcowKEapKa
 WWrW92IwhS+BYW1otmZa1S4VW6IiTskn6A9Z0/xYOqz74jvcg8goYtb/TpBKb4z+AwN6
 ictQKitDBRHV13SccYNW4B+JD3FKS6+RxkTrOn/70EGjSi02oBvvky0WL5IGwHOx0lB2
 41FBMDgHwh/g3K4KtJw6MRLum26xZGOSFwIO0s3Eum35MvJ7ziQLh+ooXZ5sn0NZWbWS
 rDtA==
X-Gm-Message-State: AOAM532M8pHWSgFtKOkZgvU3BmQOgAtgM+7v4/l23hn9gs9qv0z/JJEZ
 n48G9MC1MXutUB60T2o22t8=
X-Google-Smtp-Source: ABdhPJxTxksxPRcpsDCoyrpO6+LcacicP6eSXof2gvuPMink0TfhYhM/bbzXRymtvtFdU28AZwGSug==
X-Received: by 2002:a50:bb2f:: with SMTP id y44mr22324357ede.351.1595870302547; 
 Mon, 27 Jul 2020 10:18:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
 by smtp.googlemail.com with ESMTPSA id w22sm7455914ejj.123.2020.07.27.10.18.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 10:18:21 -0700 (PDT)
Date: Mon, 27 Jul 2020 19:18:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: Add sound support to Midas
Message-ID: <20200727171819.GC3507@kozik-lap>
References: <20200727163027.9242-1-s.nawrocki@samsung.com>
 <CGME20200727163148eucas1p1ed653cb71a473aa02c7508b2cc9beccf@eucas1p1.samsung.com>
 <20200727163027.9242-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727163027.9242-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: simon@lineageos.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, robh+dt@kernel.org, broonie@kernel.org,
 m.szyprowski@samsung.com
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

On Mon, Jul 27, 2020 at 06:30:27PM +0200, Sylwester Nawrocki wrote:
> From: Simon Shields <simon@lineageos.org>
> 
> Update the never-mainlined "samsung,trats2-audio" binding and instead
> use the new "samsung,midas-audio" binding.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> [s.nawrocki: fixed DAPM routing entries for MICBIAS1/2, adjusted to
>  new cpu/codec binding, corrected the regulator nodes indexing]
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v2:
>  - reordering to maintain alphabetical order,
>  - corrected the fixed voltage regulator nodes indexing,
>  - whitespace fixes.
> ---
>  arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 42 +++++++++++++++-
>  arch/arm/boot/dts/exynos4412-i9300.dts      |  4 ++
>  arch/arm/boot/dts/exynos4412-midas.dtsi     | 78 ++++++++++++++++++++++++-----
>  arch/arm/boot/dts/exynos4412-n710x.dts      | 37 +++++++++++++-
>  4 files changed, 145 insertions(+), 16 deletions(-)

Looks good, thanks. Unless few more DTS patches come in, I will not make
another pull request (it is quite late). I'll take it then after merge
window.

Best regards,
Krzysztof
