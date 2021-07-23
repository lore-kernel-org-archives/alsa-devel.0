Return-Path: <SRS0=2VZE=MQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E79C4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:59:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523FE60E90
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 523FE60E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB091112;
	Sat, 24 Jul 2021 10:59:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB091112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627117190;
	bh=LPLdTGLAlL8Ko1zvLULQKUDHCdXBQ4eRKARDHkQFLrU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I3tfsv5aiq3VPRZ3NmnufQZyiMwJZ/XzwHXdSVTW1LtUoR98UmrmZMezEJAYvjOuR
	 v0JZTyf/ZxbrAQMbFxuqxj5CuoR3bdx3rNXDbc9fEkvv1JUOOfLnN5keqlUuJLZYb3
	 j2gIrnmkEExhHPWim4kTYGDJLzUnVF7yrpEdlH5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 294E6F80536;
	Sat, 24 Jul 2021 10:53:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB37FF804AC; Fri, 23 Jul 2021 23:18:48 +0200 (CEST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9C4FF8016C
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 23:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9C4FF8016C
Received: by mail-il1-f181.google.com with SMTP id k3so2810815ilu.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 14:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CKG+SIFOLcCaYKwd2tEvLAZD7WaQ/IHSvWAesLjHfew=;
 b=B6P0mTz0difZ0EzAsYE/uThxLhpKbaV7N4tH3bLfW3kwUvuY02tMw9d23PW4bxrGia
 oVg3ZyXImMzd/OYoTkc/agqrtrFa+MoK9jDaa4BEndyxVqwayk3BMAJVmh3yitYNwQsY
 u4eOGYZQcfbHPsIckTIszOmxBSz0/9UPr/oppHKxupaWHf0qW+6054IUvGFD4KVhhh8i
 3thoo4KlQEc0hAoH3GeyHYrnPujIXQwHm8iTq7XjbAwUXJUgaEIAS2LNJuiq05ldSwMP
 u+c3MGrt7winixRvlKT7pJRaRGaU5iIy3w4BqhJHUHmKmsdixKtUBjTZOsJqczsjxVI+
 Hycw==
X-Gm-Message-State: AOAM531s5E2cKo05N2LdBn22QpzGRSLjVJH5GgnwBHOIvEfwOrzol88r
 X+gTJTpSPlLCE6nyQJCPrw==
X-Google-Smtp-Source: ABdhPJyOIbF9rq5B3bw9Tx2y/wvm92OqGc0Be5P5cyYWmK3oh5EqS+J3TTa94Os0/ICItRZB++DE4A==
X-Received: by 2002:a05:6e02:190d:: with SMTP id
 w13mr4883804ilu.53.1627075117897; 
 Fri, 23 Jul 2021 14:18:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id l11sm19496837ios.8.2021.07.23.14.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 14:18:37 -0700 (PDT)
Received: (nullmailer pid 2602448 invoked by uid 1000);
 Fri, 23 Jul 2021 21:18:32 -0000
Date: Fri, 23 Jul 2021 15:18:32 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove "status" from schema examples
Message-ID: <20210723211832.GA2602340@robh.at.kernel.org>
References: <20210720172025.363238-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720172025.363238-1-robh@kernel.org>
X-Mailman-Approved-At: Sat, 24 Jul 2021 10:53:21 +0200
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>,
 Mateusz Holenko <mholenko@antmicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, Karol Gugala <kgugala@antmicro.com>,
 linux-rtc@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
 Dilip Kota <eswara.kota@linux.intel.com>, Wei Xu <xuwei5@hisilicon.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Ramesh Shanmugasundaram <rashanmu@gmail.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Mark Brown <broonie@kernel.org>,
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alessandro Zummo <a.zummo@towertech.it>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
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

On Tue, 20 Jul 2021 11:20:25 -0600, Rob Herring wrote:
> There's no reason to have "status" properties in examples. "okay" is the
> default, and "disabled" turns off some schema checks ('required'
> specifically).
> 
> Enabling qca,ar71xx causes a warning, so let's fix the node names:
> 
> Documentation/devicetree/bindings/net/qca,ar71xx.example.dt.yaml: phy@3: '#phy-cells' is a required property
>         From schema: schemas/phy/phy-provider.yaml
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ramesh Shanmugasundaram <rashanmu@gmail.com>
> Cc: "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: ChiYuan Huang <cy_huang@richtek.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Dilip Kota <eswara.kota@linux.intel.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Olivier Moysan <olivier.moysan@st.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-rtc@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/allwinner,sun8i-a83t-dw-hdmi.yaml |  2 --
>  .../display/panel/boe,tv101wum-nl6.yaml       |  1 -
>  .../bindings/media/nxp,imx7-mipi-csi2.yaml    |  2 --
>  .../bindings/media/renesas,drif.yaml          |  1 -
>  .../bindings/net/intel,dwmac-plat.yaml        |  2 --
>  .../bindings/net/intel,ixp4xx-ethernet.yaml   |  2 --
>  .../bindings/net/nfc/samsung,s3fwrn5.yaml     |  3 ---
>  .../devicetree/bindings/net/qca,ar71xx.yaml   | 25 ++++---------------
>  .../regulator/richtek,rt6245-regulator.yaml   |  1 -
>  .../regulator/vqmmc-ipq4019-regulator.yaml    |  1 -
>  .../reset/hisilicon,hi3660-reset.yaml         |  1 -
>  .../bindings/reset/intel,rcu-gw.yaml          |  1 -
>  .../bindings/rtc/microcrystal,rv3032.yaml     |  1 -
>  .../soc/litex/litex,soc-controller.yaml       |  1 -
>  .../bindings/sound/st,stm32-sai.yaml          |  2 --
>  .../bindings/sound/ti,j721e-cpb-audio.yaml    |  2 --
>  .../sound/ti,j721e-cpb-ivi-audio.yaml         |  2 --
>  17 files changed, 5 insertions(+), 45 deletions(-)
> 

Applied, thanks!
