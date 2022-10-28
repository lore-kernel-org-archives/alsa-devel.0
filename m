Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A674C38A02
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Oct 2022 16:53:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E406E1DE8;
	Fri, 28 Oct 2022 18:52:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E406E1DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666975992;
	bh=wp7I65cC4L0O7OYe9O4RTG18t8J/z+sW9P1rKwUJXco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myJAqRvP/Sm9ck+//H8X1AatZJCwJsJUNtOjYjCuwTghvybClxZAR93MwQOnMEha1
	 LkNBWCrQpv/mmIfs+nUXqlA3njbEKZL9tPrEKDCy+XL4/Qw41u+SuswmMH8J6Qi9WM
	 c47q+WTDrgmIDhx9JugpZP++g3RvOJeBtO43sbog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8828AF8024C;
	Fri, 28 Oct 2022 18:52:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A72B7F80095; Fri, 28 Oct 2022 18:52:20 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34B37F80095
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 18:52:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34B37F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="fqPTWnUu"
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-35befab86a4so52344557b3.8
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JFuZCHp6RPG0OZ+ZcxxiWhSMU9E34XF2yS0NNOUPKoM=;
 b=fqPTWnUuuck0bAxRjaW+t2+TNbmZRCzTB/mgIBtEByZSJ5rEB0x+gt6p8YULIDMmIo
 QJd/YrVYMoP7ZmrNzykTvlYWJUjGde5jgd0lm+NgNhmAwMUNAjRhhWb0JCULKjglLPfI
 wSGtrvHKTq7jeAxq42+CL6FCbx0fKEugliZOo5bRuV1bL5tVHZkgBVdVH6E3A9TidzSc
 hcpyvVGDtcA7tJYS2ah5C5rRuFFhvszme2WH8clxRaplmpfCF3VL+fdfZ2s2HLRWl+HA
 eL0/fWb6+IjvzUNetxTZuxNR0qANnOSnlAMm0ogoBoTpJZgN7DGrCjlPJ1gI0B2moZLk
 7clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFuZCHp6RPG0OZ+ZcxxiWhSMU9E34XF2yS0NNOUPKoM=;
 b=RuETYzwgA1Jljs1xJw3ZoQTtK3TRyRxtc7iGrX6VId5rB7ihctIvm63o5ZHh//Y7ie
 Bes8ThZgWWYJ8ASUp7OiIj8rFls3Ng/mXDjQm5Z9JISIC60IMRL/Qcm0NJtokMnhdex+
 4jJEZGtYDDCBY5QVKK40hQZsn3LXPYsHji7wM31u2zzK/sJW4lwl+TKstfMd6BnDpqRB
 gbN+oQrmAgIMfsjqVOQd9d2rIO9rz6UI4CFgWsbcCejEokMr7NLOeDyd4XCs2wI+AKFp
 yDbOme9k1ls8Su0ZgQ2S/xrfVpXuI03EnJ6lEaZ61ua7Aj0h36275wALYLYFcFztS6fx
 wrfQ==
X-Gm-Message-State: ACrzQf0/h9RzMbJxqoVTT8R9jGiJFFfz92Kxy+vmpMFYRdGBZxsfgoAv
 wkvYGBpSxQD6+YxvMuDv7prC5l/Y6nhhpOjhrugQQw==
X-Google-Smtp-Source: AMsMyM6vjerUWgxxTrEsm3O1K4kgea+m/v98N6LpjqhoWL/YTXSYhqV+cegvXn3NJBWoYQcPrP65gYAr7BtftOd8w7I=
X-Received: by 2002:a81:4f89:0:b0:36a:f09f:73fc with SMTP id
 d131-20020a814f89000000b0036af09f73fcmr312625ywb.487.1666975935785; Fri, 28
 Oct 2022 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
 <20221028160733.1390230-3-ajye_huang@compal.corp-partner.google.com>
 <Y1wApOeV7OoQzkt5@sirena.org.uk>
In-Reply-To: <Y1wApOeV7OoQzkt5@sirena.org.uk>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Sat, 29 Oct 2022 00:52:09 +0800
Message-ID: <CALprXBYf-V=gidvNpoRraPdJgdrYaCoCcJPhgAmx6UX5wUXzxw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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

Hi Mark Brown,

On Sat, Oct 29, 2022 at 12:17 AM Mark Brown <broonie@kernel.org> wrote:
> Also do we really need the of_property_read_bool() there?  I'd have
> expected that devm_gpiod_get_optional() would be handling that for us.

You are right, it is unnecessary to use of_property_read_bool() there
, I will remove and send the v2 version, thank you.
