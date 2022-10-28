Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD87ECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Oct 2022 18:27:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD6B583E;
	Fri, 28 Oct 2022 20:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD6B583E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666981657;
	bh=NeJA1K76rhG01MKBkMeA6is/f4+ZPybVzEJbnL0/ytg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXlPFfXAqS14cUe8pqZdI4oipDg+UjJGbAR+wTLWTvKPyTZfrKp+96hUfx4hrUWV2
	 a3hEMye+TgOkO8xJzzqW1DpqkbzEY0TiwS1GKgGZkha7dRz2jGCNFewpU3BBNuyt1V
	 sHJhWDbVcQGRULEey+eD8CRKCE7RM5rnrZo1hSFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BF73F8024C;
	Fri, 28 Oct 2022 20:26:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 234B2F8025A; Fri, 28 Oct 2022 20:26:46 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E067FF8016A
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 20:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E067FF8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="YUvbU1Pp"
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-368edbc2c18so54416667b3.13
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j5EifIBTTA4Q9MeGr5GuWpo/RfwKB+MeKNIB/9GceQo=;
 b=YUvbU1PpsyUC0xVCXSieAxZ6vYr4VEA8nHXSk5P4lFHIX6oEJWc5mCr/kQzfazyxZD
 GXNWik6tau12kCTYEtG1jEVTFeQ8x2qsmTErDuLDS3JTMIFWDf8nxG1b/6dipQTGLJDZ
 Vmh5w9sxSDqx20AH76/n/mZCllNsxjdto+XjXyH2pLBkhk5AAyNVtb82L74Zrfh8BQ9j
 5I5JyxrW5aKRKrFTZL09I9LT2rrVoBduaQRJ6UoFj7kE4yZFAnImYiKzm68Y07t0xrIr
 GURnBWhN2u0b90BaMv1cNUkOopljZM/G4Od+GmpmM0L+7JizDwTdNnOGIZa1IUmsjlA5
 GcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5EifIBTTA4Q9MeGr5GuWpo/RfwKB+MeKNIB/9GceQo=;
 b=BH+tWBbW4YOXRsWYDFek1KUBnTtu6Sw1QQcxByQA7I4ziRrs+jQACwg4cZCg1bVZs9
 uQbvxJGFOxP35+hWCm/pTvt9CfeIUgYCwY/gpQY48hQvTUZDZ8n5ya/7+mFbcLGRawTR
 kIdZ+QujaEb43rYER+wt4orzehCl+xLYq4lP8DnSdeV5sWB58/edCfrvpfhB3v82EKMi
 ZbzDLex2JI4WIQyoN6J0vIC5SaubBUKv7J63k22eguLELjF4R1HzQ4K1Gfgdd8rwrNBX
 /s7Tg6lMeDXxX+dtj4eAiVEckHpkGY8aVsQeDnYPbfC/WzyAGP9TzbmitUp9kAz5Knha
 gCLg==
X-Gm-Message-State: ACrzQf0COLmrga5bqNDj8QAGNw93/+FMbk+38zHn88nY3sW0GNP297fv
 borBXergq2sSNsq500lFrep0RwCEAbVnFOOy4zimcw==
X-Google-Smtp-Source: AMsMyM7UOWyL2Dv6r9TIrvrO+niGjVrF9GXwAEmH7LXG29idxrg8+LTErqg85FMT3mLbPbDQ2bGc6ZQBpNv9Bl1DiMA=
X-Received: by 2002:a81:164b:0:b0:36f:ced7:985f with SMTP id
 72-20020a81164b000000b0036fced7985fmr773896yww.360.1666981597226; Fri, 28 Oct
 2022 11:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
 <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
 <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org>
In-Reply-To: <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Sat, 29 Oct 2022 02:26:30 +0800
Message-ID: <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Sat, Oct 29, 2022 at 1:58 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:


> >
> > +  dmic-gpios:
> > +    maxItems: 1
> > +    description: GPIO for switching between DMICs
>
> Switching how? Enabling? What is the meaning of each GPIO pin value?
>
I think I should add more like an example,
  description: dmic-gpios optional prop for switching between two DMICs.
                    Ex, the GPIO can control a MUX HW component to
                    select dmic clk and data form a Front or Rear dmic.

Do you agree with that or have other suggestions? If do, I will send
the v3 patch for you to check, thanks
> >
> > +        dmic-gpios = <&pio 23 0>;
>
> Use defines for flags.

Yes, you are right, I will change it to
dmic-gpios = <&pio 23 GPIO_ACTIVE_HIGH>;
