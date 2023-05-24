Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A622C77B7C
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 16:30:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E7CA200;
	Wed, 24 May 2023 18:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E7CA200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684945811;
	bh=zZqKJV2qK50N87o/S9GT3M0DMlyTsSOyAlZ7RRTvFPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hFHwx4IC+yj/TJDms8RTwLKetuQwxqZMCDmtMAQ5jPtYZQTl+8JXhRCII/NmNFNxb
	 MFS0JHx/GNRI+5G04kn5kYOWT+YJnBjCsgyLOGyxdYD+3bkmmJNrzPmQsVVFlEi2ib
	 PfMVEhw/OiJI+gsYAZiXkmS6BY64YG7Ll97PhITU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50CADF805D8; Wed, 24 May 2023 18:13:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D80DF805D6;
	Wed, 24 May 2023 18:13:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 323A6F805D9; Wed, 24 May 2023 18:13:00 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E6EC9F805D7
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 18:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6EC9F805D7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=BXQc/vB2
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1962e7284baso371487fac.3
        for <alsa-devel@alsa-project.org>;
 Wed, 24 May 2023 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944772; x=1687536772;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d2krvbmUqOnT4KV8ff+7HqiCvnexQ6qfpMeD5hBBKDI=;
        b=BXQc/vB2/r9Dq425nCPgq9QmObSBwPsi5anYqf70r7oyC2C1g6fTPoPoi9p2iSrWSm
         c9D/8N8/y21hqTJf1gOpXyYMdQes2dCzj59IGxkfyYh8LBDkXHDQAxrvv7vH8mJHkvJw
         yGtmuS42uE0ofz1TYDAIU+jb/hfkVvbpCBPFqtsOCPYzgNy8/L1AGiqZK6RB9p5zpb9z
         lPJxI73lFmeaf+4ZuSTk8xD6mS8czma8D89H23EPnv6jYzfBiFZ2bIgEz8XBJ6W/yCp5
         8tbMO1HjL4HxIFk1o3J9og0WW5tl985SvZV0UI2jO57IL0lUKOHuzKC3HZi5WqQgwGtp
         G+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944772; x=1687536772;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2krvbmUqOnT4KV8ff+7HqiCvnexQ6qfpMeD5hBBKDI=;
        b=iRZfemUub/cM2wbJEa20Ai5669gFFxOriaUyV5KuQWYrY8GQIn2ZOU2vqatq+nu5KI
         BBddakBmx6ZZadSOtgwtRwIXcIEguJV0Wd25icc0H49B8OkXzn5b0RQONJekxP32lDx8
         T0g8lGCQQE85+AdP/z30gIRrIn1XpTJN2VAAglbbouXn043xhjMFttPcqUzAI7PuAIKN
         2Jl02HUgLWJ6nZkBdzEYFzQ1rANe14BgNaUZIMF4wMKbdcog2yK3VFWwYedGHdCjKgzI
         3xVPvVyjDUjA/lnHlYLrGRuhjt11Qk+cmnVZJn1nVSg8NgZyfYKhE4hzhMJBp5d/EemE
         t2ZQ==
X-Gm-Message-State: AC+VfDzoELZn2ZzZDRWPCs4dO2jGB8PMQjeENcvrPGUi9mR7hg492TwK
	N2qJivx277pninb/6FWUjBM=
X-Google-Smtp-Source: 
 ACHHUZ7Lso2poEP7KecW3pW1g3gvJHrRqlkMvpmtiMnveNZ9VYZhCemAUJ0Zdx5qdJxt5oBJVxxi4Q==
X-Received: by 2002:a05:6870:93d5:b0:195:fe38:3b60 with SMTP id
 c21-20020a05687093d500b00195fe383b60mr161544oal.25.1684944772365;
        Wed, 24 May 2023 09:12:52 -0700 (PDT)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id
 u1-20020a05687036c100b0019ea8771fb0sm82550oak.13.2023.05.24.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:12:52 -0700 (PDT)
Message-ID: <646e3784.050a0220.71431.07f7@mx.google.com>
X-Google-Original-Message-ID: <ZG43gSO+UYAi6bv+@neuromancer.>
Date: Wed, 24 May 2023 11:12:49 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, zyw@rock-chips.com,
	sebastian.reichel@collabora.com, andyshrk@163.com,
	jagan@amarulasolutions.com, perex@perex.cz, tiwai@suse.com,
	lgirdwood@gmail.com, heiko@sntech.de, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/6] ASoC: es8328: Enabling support for 12Mhz sysclk
References: <20230523213825.120077-1-macroalpha82@gmail.com>
 <20230523213825.120077-2-macroalpha82@gmail.com>
 <f5b780ac-e079-4c24-9dfc-05aee52deb9c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b780ac-e079-4c24-9dfc-05aee52deb9c@sirena.org.uk>
Message-ID-Hash: KT4LVBOFDOJYMT3CCSXW4JWJ74NQM5OC
X-Message-ID-Hash: KT4LVBOFDOJYMT3CCSXW4JWJ74NQM5OC
X-MailFrom: macroalpha82@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KT4LVBOFDOJYMT3CCSXW4JWJ74NQM5OC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, May 24, 2023 at 12:57:02PM +0100, Mark Brown wrote:
> On Tue, May 23, 2023 at 04:38:20PM -0500, Chris Morgan wrote:
> 
> > +static unsigned int ratios_12000[] = {
> > +	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
> > +	48000, 88235, 96000,
> > +};
> > +
> > +static struct snd_pcm_hw_constraint_list constraints_12000 = {
> > +	.count = ARRAY_SIZE(ratios_12000),
> > +	.list = ratios_12000,
> > +};
> 
> ...
> 
> > +	case 12000000:
> > +		es8328->sysclk_constraints = &constraints_12000;
> > +		es8328->mclk_ratios = ratios_12000;
> 
> The other constraints have separate rates and ratios, with wildly
> different values between the two - the ratio (I'm guessing a clock
> divider) being written to a 5 bit field which obviously can't contain
> the actual sample rate.

A bit over my head here, I saw this patch from the Rockchip BSP kernel
branch and tested it on my mainline kernel. Long story short the clock
for the mclk is 12000000. I see that there are similar issues for the
ES8316 on the Rock 5B, so I will probably just wait for a proper fix
there and then implement something similar here.

Thank you.
