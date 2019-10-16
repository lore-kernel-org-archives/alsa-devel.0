Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E494ECE588
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C11D2054F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XwGDjwn5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmxLnnlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FB1C846;
	Wed, 16 Oct 2019 10:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FB1C846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571215362;
	bh=2uyb/9Yu5WEkLO4ZV7ZfMkmdc+5ocPINu+pXsKNeauI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwGDjwn5Ip6GvdUzUZxkfGPp1tOs39ABkM2nV1HKRmfN6RIabiFu04kG65aAYxNFK
	 2p8GVEbWVHumrVrb/y1udz8zx7Y/zVZ0jD3TwByy2l5oJ2xst7+5VUzFJLpRmiR404
	 IFNiwJteUC/XCKPkmOE4OKJiUsN6uFL5HxNP+Xn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51AC5F80323;
	Wed, 16 Oct 2019 10:41:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8161F80362; Wed, 16 Oct 2019 10:41:48 +0200 (CEST)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A34DDF8011F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 10:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A34DDF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cmxLnnlv"
Received: by mail-lf1-x143.google.com with SMTP id w67so16751009lff.4
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P5rCHjs55GhS0d4QwWMR+IRXm4cU7A5acMAqOom+agM=;
 b=cmxLnnlv3X8JzjYTOrMqk+TrttOUQO+7Ws5eEWIRsEywSi1lz7WA6MOWF2jvS2WjdU
 kNnUvK2cVJU0uIxO8GhtsUwz7YRYCcSD4sc5HojMnTJHNi7TV/4LE0IDtg48eW6tv4EZ
 yp0HfIdJ3n5GCBA/L3alVcWo6V6kJ0OkrWiyeEiCV+GqXCr+1HCkWjqYygrdRdst0E/s
 Jw0IuQIhHHnjpLvdhnWnk2MEqsxtjlmE0E7FyNcMmIeJWuHqQMjPcMkbaaQ1Yx6fRUuw
 p5rWDLQWh+mWjmnGrmjPilU4K8yetyUqCqxz6D/6lCKowZu9tOEzyy1oZ17LVeq65OFv
 NAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P5rCHjs55GhS0d4QwWMR+IRXm4cU7A5acMAqOom+agM=;
 b=FJOpGLiRFfkFS+jE2ITHPnbLCz47WMPM77FpIhXqf66EmEat0jKjnPlh12UMum2Uw2
 QZIFHQtNHVTXMl4hRBH2BNstlCPK+FI6I/OtlYX3SRkYId2Vnz0wKUvDfmvYUT8aQ5mH
 7fV0rupdjAsaXmMFPQBJyqN98UTcKlD8PDphrtRQvi23OEFjQWT+Ar3oQ70jK3IT6fpd
 C1LEeKvzY+oELQ/fkpSfEKF86pRpqbIQ/4uHHQsdVxEsxLCQ2KPAvDx8vLRKgHRZpNm4
 6QSXG1MXwzgoSZQIcfZI0X6HcnPopzUW9MXs4wogirTVduQdmcGFtWqLCafJVgSf2EpF
 nshQ==
X-Gm-Message-State: APjAAAXVk4BaW1vLDD0tr0LHYbalKZIjw+AyFIrDpoUj/mKqmHJZSym+
 vVv4tAiKj2XEC9Lx645MeywopoKisJTJgzvM63Q=
X-Google-Smtp-Source: APXvYqwMqRyrV6KURGxOk+nK8zfx8iulHbs2fxXoCl2l6ahgWaJLEk4ZRRTnkB348AtFsLAoa2OCoYz7BbpqTULv2UM=
X-Received: by 2002:ac2:5610:: with SMTP id v16mr23568149lfd.93.1571215303287; 
 Wed, 16 Oct 2019 01:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-2-codekipper@gmail.com>
 <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
In-Reply-To: <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
From: Code Kipper <codekipper@gmail.com>
Date: Wed, 16 Oct 2019 10:41:31 +0200
Message-ID: <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel
	select offset
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

On Wed, 16 Oct 2019 at 10:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs the offset is used to set the mode of the
> > connection. As it is to be used elsewhere then it makes sense
> > to move it to the main structure.
>
> Elsewhere where, and to do what?
Thanks...How does this sound?

As it is to be used to set the same offset for each TX data channel in use
during multi-channel audio then let's move it to the main structure.

BR,
CK
>
> Maxime
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
