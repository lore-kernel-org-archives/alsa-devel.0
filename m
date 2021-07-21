Return-Path: <SRS0=2VZE=MQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCBC4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644AB600EF
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 644AB600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02F4617B6;
	Sat, 24 Jul 2021 10:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02F4617B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627117108;
	bh=Y5IdCRJZdJYIiudXPCqxlRKiC6LdgtZkGmH8rRPhgTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CkSt3K4O8J9W7haMMyiKecxmWYnaJTr1fEyrQK2ujNmlTzU68tdLXXmbzfP/USk6s
	 e1LoW5Cj/hWg9xPWUJc5zWwq1zVeGsmFjlup7R7DRwbdujg8xNBrrOwvCAwHLWiA57
	 5DQYFv4a2ajrBvREzpXgqzutyXvvlPsa63uzixIs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98E34F8051C;
	Sat, 24 Jul 2021 10:53:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9CABF800FD; Wed, 21 Jul 2021 16:26:26 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70C52F800FD
 for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2021 16:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70C52F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="DfZty/Ix"
Received: by mail-lf1-x12f.google.com with SMTP id b26so3460200lfo.4
 for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2021 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y5IdCRJZdJYIiudXPCqxlRKiC6LdgtZkGmH8rRPhgTM=;
 b=DfZty/Ixt/tbCkEATYd7Xctiu3ogAgN3WD/IwiROnkAKSZv3xwTODhlTlCT8Xi3nv1
 Dg1qfPy20ffG87fs1hWVi3Q25QSj0diOYe09xTXjyv6um8idOFHt/ZXV3rgZe9NgqdN1
 yEyzWn9IBYZGP9L8EmDpmRxNpbXAYwqRXc8AEIlWBl5F5mpmMfVKsuonN3B9ProzGngQ
 FtKpxS++Sb9F9gquqZzPud504nw7wq++64NoUphdP3fwj8uB/e3VLCpXjjacCc5sBbNu
 oeiMP8oGGghMnRlAM06pfMf3TdJGTqA5LoVQu6KZaJXAzorOV5PfOVReFX+O2e/HD2OK
 PL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y5IdCRJZdJYIiudXPCqxlRKiC6LdgtZkGmH8rRPhgTM=;
 b=hP9oH3o6JpRjDy6Z+A7LP4bYhif+TJFCvoB7e8bDO+Ho8TUYPlyMbSOKIfRj5GPgHN
 WX/++T8tGLWYIINXo8OOPF/cS/It4MCvMTFokC//DK7T3RHBxDzCXMUI1s7XvVornd1s
 /xj1AHdgGwFTvbyDEYh3MDK4V9SE7XO7A1CRO84IfC64zeeQ4eFMd+Au6dLRXduAvWo8
 GMdSNAPDbRfjRl5IJchS68RPPn+y90BdYh1RZM/MgpU+VevA8hXXYpCeLN4lsfXXBmkm
 1oOPjI+OuOYZ7z4p76lnKQObmzBapqFEnqsuoGgv17ZywT4AQHCZuB9QYOi+9S50yjHD
 4C8w==
X-Gm-Message-State: AOAM533OPrFxTWit0IS26UEZm0+8A4dGJ+pbb6ns+fPqCBQSuXjldqWR
 bhU1vBMcV4wS/nztCU8ghfdDeKeD7LKSZLjr56/rmg==
X-Google-Smtp-Source: ABdhPJxLJxuektkYlmThnTeKs9wi2CGTur5nFPRKxrsRGLrNNjiiMAw1eN/JZqtaD96z1vToql3upVxtxcQHSW4GACE=
X-Received: by 2002:a05:6512:169e:: with SMTP id
 bu30mr5421776lfb.291.1626877579556; 
 Wed, 21 Jul 2021 07:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210720172025.363238-1-robh@kernel.org>
In-Reply-To: <20210720172025.363238-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jul 2021 16:26:08 +0200
Message-ID: <CACRpkdZdm=ArA3H86iHwmhLnCtTePxCtuik8O+bOhDBPMXOP=A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove "status" from schema examples
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Jul 2021 10:53:21 +0200
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Olivier Moysan <olivier.moysan@st.com>,
 Mateusz Holenko <mholenko@antmicro.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, ChiYuan Huang <cy_huang@richtek.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, Karol Gugala <kgugala@antmicro.com>,
 linux-rtc <linux-rtc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dilip Kota <eswara.kota@linux.intel.com>, Wei Xu <xuwei5@hisilicon.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Ramesh Shanmugasundaram <rashanmu@gmail.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Mark Brown <broonie@kernel.org>,
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Alessandro Zummo <a.zummo@towertech.it>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Jul 20, 2021 at 7:20 PM Rob Herring <robh@kernel.org> wrote:

> There's no reason to have "status" properties in examples. "okay" is the
> default, and "disabled" turns off some schema checks ('required'
> specifically).

All of mine are mistakes anyway.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this up.

Yours,
Linus Walleij
