Return-Path: <SRS0=sipn=AY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DCC433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCDC20578
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FIED9hAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCDC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDF56847;
	Mon, 13 Jul 2020 16:59:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDF56847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594652416;
	bh=nzASuH9Aa6QzRRlwVHAvFBo4qZ+A3sWOlJRsPr6CAsg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FIED9hAYmcEgyxshIP0B5UqUGNLhjejIY+YIC6IwbdbP52S7H73g3GFZn3KSrAl7W
	 RJm0cQmPre1+AXWyGwNTY0HChjaPwIytO3R4QduH/PKnKLnK6yXG+0+cxnitdlhpyJ
	 ZnGslorfr/g0tgBDRpinS1Xp/O7aARFsHshKWtmg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BFCEF80217;
	Mon, 13 Jul 2020 16:59:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40FEAF8021D; Mon, 13 Jul 2020 16:59:23 +0200 (CEST)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBC56F800E5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 16:59:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBC56F800E5
Received: by mail-io1-f67.google.com with SMTP id d18so13813608ion.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 07:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5WwrQCBfCGD1oAlfh4Q+LcNaL9+7pA+S/ObwRTYKA7s=;
 b=SltTJvqu65eCGJ/G+90mqnrX5nIO8XsqQ8445gmh7mSiDpoNaXwjTWCpD7/zkINtXh
 sGyc0Fpr60yS54qVvwL1aHzDuPbzcs8ZzGY7HHc3VmHsytP/pTCGKIvxUhSj3K/MhhYA
 P0CK4KEu2Xtx6IqgVYpK4g9N20XQYizr76LWG681yGeZ5WeANLViLlOcd1fiFH+xX/ba
 xKonYKR6mLEpmlbuxPc0fY5yQkuhjalPpEp6gmnHdVl+y1bWZHBcBedN7GYxdXmkb+dy
 XhOZtWIoyBGl+PAhkpoaxwQYt3BMJwq/jd3NLE5YoMWTRBAM1kYuYqu5M0VcUqBvXmow
 esOA==
X-Gm-Message-State: AOAM53103Mol5W8SDwvuhmE/fXU9498IARNmmIQYeMldfFIovwOgUuoq
 2xdOn2IXlYIgE1KYa2DlEQ==
X-Google-Smtp-Source: ABdhPJzHZq+wMFL1ggb2CsSFLDEJagYQZrr2Q2lLGCkDm5iY+m/zhSLIJpn5qI8RV2IDmpYmYErCOA==
X-Received: by 2002:a05:6638:12d2:: with SMTP id
 v18mr502732jas.4.1594652354184; 
 Mon, 13 Jul 2020 07:59:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id y12sm5507378iot.49.2020.07.13.07.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:59:13 -0700 (PDT)
Received: (nullmailer pid 173994 invoked by uid 1000);
 Mon, 13 Jul 2020 14:59:12 -0000
Date: Mon, 13 Jul 2020 08:59:12 -0600
From: Rob Herring <robh@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/3] ASoC: samsung: Document DT bindings for Midas sound
 subsystem
Message-ID: <20200713145912.GA173446@bogus>
References: <CGME20200710173512eucas1p101c03994a728150f18428295192edf25@eucas1p1.samsung.com>
 <20200710173500.22365-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710173500.22365-1-s.nawrocki@samsung.com>
Cc: simon@lineageos.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, broonie@kernel.org, krzk@kernel.org,
 robh+dt@kernel.org, m.szyprowski@samsung.com
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

On Fri, 10 Jul 2020 19:34:58 +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of DT biding for the Midas sound complex.
> Partially based on the *txt version by Simon Shields <simon@lineageos.org>.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../bindings/sound/samsung,midas-audio.yaml        | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/samsung,midas-audio.example.dt.yaml: sound: 'mic-bias-gpios', 'submic-bias-gpios' do not match any of the regexes: 'pinctrl-[0-9]+'


See https://patchwork.ozlabs.org/patch/1327065

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

