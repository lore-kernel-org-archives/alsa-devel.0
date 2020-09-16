Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E5DC433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:00:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977DB2078D
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BgAIs1lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977DB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D53061660;
	Wed, 16 Sep 2020 09:59:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D53061660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600243216;
	bh=VB+iul707xQHJB3MPFHg18/n/MFhXSGhTa9PlCiNdNg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgAIs1lYwGfuliDhHPL9Ga0tWRN6eYx+of3sf6no+6R1YgskjV0p158T5n5/xpUNt
	 Bh/HXsjpS41JblJai9T7SqHNlEaRhv9ZRkxPolDdZ76D3yq6i8oo1HD+ubJ/D0yqgV
	 ulY+YaiXmO3ew9S1W90qxUgmJysA+Y8uyqesPPq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41730F80150;
	Wed, 16 Sep 2020 09:59:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DE4EF8015A; Wed, 16 Sep 2020 09:59:23 +0200 (CEST)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDA67F800E8
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 09:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDA67F800E8
Received: by mail-wm1-f66.google.com with SMTP id k18so1910001wmj.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f9vR3Ti7HGJjlVupS35gCwKRPU2ouBmpdxOZm0a6pHg=;
 b=F8By3H+ntmi1GHBeHc2c+wCUNXyi0yLeBEh6o1gxC0CtOlsnHyYiyw5wqlG4j71hrD
 dUcr2yOW65/QvAR2mLgnCBoR0RpN35obSbBLpCyNvGac16IbRYHYXiDSG9cW6rqc/hA5
 vqipUyP8KyiYYUYIN19+vfAJLtjsKgFpoCROpK0QmKEoBxrLUTpeG7TEPmCvwnkIZ2LD
 Ey6DrHi43sWyfsGQqpHjtoeoCYdVahQqUgBzs+MMlnvu0k1dwxSwxXSBWhbvrn7E081L
 u3HVVle5o2N2ZisxC91bi/MCxfRq1aTj+2gtwPcK8LX5De0J7h0mweUGeWLlIn8P9eNk
 5RPA==
X-Gm-Message-State: AOAM532o3PT2yfnK8OZtKJoo31zvLS82tlSZT1fYWzMFWg3iTw/5fKGV
 4PYTXARLJJWV5fqDAvA/haU=
X-Google-Smtp-Source: ABdhPJxvAiLHTzMl+wXAqNoAvB4Yv/BV83AUKMAclJ4hQWRQUQ98jocoP+WC+dpkBraRRwrLGVhbrg==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr3467656wmc.112.1600243151114; 
 Wed, 16 Sep 2020 00:59:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
 by smtp.googlemail.com with ESMTPSA id a81sm4022587wmf.32.2020.09.16.00.59.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Sep 2020 00:59:09 -0700 (PDT)
Date: Wed, 16 Sep 2020 09:59:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFT 09/10] arm64: dts: exynos: Correct port of USB-C connector
 node on Exynos5433 TM2
Message-ID: <20200916075907.GA10270@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
 <CGME20200829142602eucas1p1ce457a8fddc6b1fba4bf8c08992fa0b3@eucas1p1.samsung.com>
 <20200829142501.31478-9-krzk@kernel.org>
 <4eb7d0d9-29e2-9162-4521-10e4422f9c71@samsung.com>
 <021495a9-7a00-eb91-ddfa-885cc2fb5462@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <021495a9-7a00-eb91-ddfa-885cc2fb5462@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
 David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Sangbeom Kim <sbkim73@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Thomas Gleixner <tglx@linutronix.de>,
 Sylwester Nawrocki <snawrocki@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Wed, Sep 02, 2020 at 01:23:50PM +0200, Andrzej Hajda wrote:
> 
> On 31.08.2020 14:50, Marek Szyprowski wrote:
> > Hi Krzysztof,
> >
> > On 29.08.2020 16:25, Krzysztof Kozlowski wrote:
> >> The USB-C connector bindings require port@0.  Such port was already
> >> described in DTS but outside of the connector itself.  Put it into
> >> proper place to fix dtbs_check warnings like:
> >>
> >>     arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: musb_connector: ports: 'port@0' is a required property
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > I'm not sure if topic should be about USB-C, I will call it simply USB
> > connector node. TM2(e) uses Samsung's 11-pin micro USB 2.0 connector,
> > which has nothing in common with USB Type-C.
> >
> > Anyway, this patch breaks DWC3 (tested in Device mode) driver operation,
> > so something has to be somehow adjusted or fixed. Added CC Andrzej
> > Hajda, who actually worked on this.
> >
> >> ---
> >>
> >> Not tested on HQ. Please kindly review and test.
> >>
> >> Best regards,
> >> Krzysztof
> >> ---
> >>    .../boot/dts/exynos/exynos5433-tm2-common.dtsi    | 15 +++++++--------
> >>    1 file changed, 7 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> >> index 6246cce2a15e..bab6c1addd5f 100644
> >> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> >> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> >> @@ -871,6 +871,13 @@
> >>    					#address-cells = <1>;
> >>    					#size-cells = <0>;
> >>    
> >> +					port@0 {
> >> +						reg = <0>;
> >> +						muic_to_usb: endpoint {
> >> +							remote-endpoint = <&usb_to_muic>;
> >> +						};
> >> +					};
> >> +
> 
> 
> According to not-yet-yaml documentation of dt-bindings (patch 05/10):
> > -Required nodes:
> > -- any data bus to the connector should be modeled using the OF graph bindings
> > -  specified in bindings/graph.txt, unless the bus is between parent node and
> > -  the connector.
> 
> This is 'unless' case - muic is parent of the connector, so the port 0 is not necessary.
> 
> 
> >>    					port@3 {
> >>    						reg = <3>;
> >>    						musb_con_to_mhl: endpoint {
> >> @@ -879,14 +886,6 @@
> >>    					};
> >>    				};
> >>    			};
> >> -
> >> -			ports {
> >> -				port {
> >> -					muic_to_usb: endpoint {
> >> -						remote-endpoint = <&usb_to_muic>;
> >> -					};
> >> -				};
> 
> 
> And this port belongs to MUIC - it describes connection between USB-HOST 
> and MUIC, it has nothing to do with the connector, and is necessary.

Thanks for checking this. It's really appreciated!

I'll work on v2 later to address the schema warning, hopefully without
breaking things...

Best regards,
Krzysztof

