Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3CC5DF61
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADF920869
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bE1aBo/U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDltopZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADF920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DE84166F;
	Thu,  7 Nov 2019 18:41:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DE84166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573148512;
	bh=1C+Xju4V9HDw+RbUW/Sf/xl0EyzkZYUpiEpMIAPLdVs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bE1aBo/U1ahgWSpVlIBSg3ZWHZgYF6j+uCgZtpSdELHydudoQjALOYaZwryDjdj5o
	 GOzcS62sVsy7FQSfIM8qmZOi0nZGfghe/rLwi3DNODHgUqQp2PbWY8L0EhZAlkYSGL
	 549mqn0ld8kPd26f8mmU3+2+KKwhDeHr0mx9uQ/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06013F80291;
	Thu,  7 Nov 2019 18:41:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B11FF80446; Thu,  7 Nov 2019 18:41:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3075F800F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 18:40:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3075F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rDltopZk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F08F72077C
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573148454;
 bh=OYgQrmdZmNroAHb74sVUuSnpCtxolSUHgVGyEjv4V5Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rDltopZkGIFVN3tdTyMtIBC0/DHvpYC//97XoCxkCgL1Wprtj27pPVltzMEqfAnS9
 H4eUUc89erhUBoVs8OiiQr9GmEe8B6Hw/1e6dQBfKiDSw4lxtaIWMORzftVi5lU2bE
 OiHu70ENCi0eJ9yVREDlYILAWx4y/Po/OkXaHVvE=
Received: by mail-qt1-f172.google.com with SMTP id t20so3254605qtn.9
 for <alsa-devel@alsa-project.org>; Thu, 07 Nov 2019 09:40:53 -0800 (PST)
X-Gm-Message-State: APjAAAWR7CBCsCWbYdVLp7ugHCeJuDcpGYkjtqZpFrSd64d7tRJrx3fC
 PxE9acI0A2RphTVjdD8IJ4teMeWP7fq8AFL9Qw==
X-Google-Smtp-Source: APXvYqymGGkqABjYdF0xhvWYzF9gyZ7Mx6LFLCCgTmCamvcfGddIsg5zyOUpdwQsy7X4I+/2Uw4D8lnhSwngyNf7W74=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr5129163qtq.143.1573148453179; 
 Thu, 07 Nov 2019 09:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-2-srinivas.kandagatla@linaro.org>
 <20191105193100.GB4709@bogus>
 <315fd1f8-b6b5-5df7-604d-4ca92b31772c@linaro.org>
In-Reply-To: <315fd1f8-b6b5-5df7-604d-4ca92b31772c@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Nov 2019 11:40:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+EUe8TiNfUN30D9x4XNcUnevUSK2cM9zVQR=jDR1wQQ@mail.gmail.com>
Message-ID: <CAL_JsqJ+EUe8TiNfUN30D9x4XNcUnevUSK2cM9zVQR=jDR1wQQ@mail.gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Vinod Koul <vinod.koul@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v3 01/11] ASoC: dt-bindings: add dt
 bindings for WCD9340/WCD9341 audio codec
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Nov 6, 2019 at 4:08 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 05/11/2019 19:31, Rob Herring wrote:
> >> +  vdd-micbias-supply:
> >> +    description: A reference to the micbias supply
> >> +
> >> +  qcom,micbias1-microvolts:
> > The standard unit is 'microvolt', not 'microvolts'.
> >
> I started with microvolt but dt_bindings_check reported errors.
>
> looking at
> https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/vendor-props.yaml#L19
>   suggested microvolts should be used on vendor properties.
>
> Is this a typo in dt-schema ?

Yes, even the DT maintainer gets confused. :) It's fixed now.

Rob
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
