Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FE5C6FD1D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Mar 2023 16:04:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAE951E7;
	Mon, 20 Mar 2023 17:03:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAE951E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679328281;
	bh=hAjyhCRMuCFb3zWLiv5bbVA2UU9Gdc0Rbh7lF2hnOhM=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N3jjdOML5bDSbKDwdOMLp2RKK+mwjmRbTVGSqPtKPzqJga8qSlulfMsv62zQzpt4t
	 q94IRAOsSWzqAdw2crOU5v+1BtUcGeVnEt0N0AlW9vPmfKkcBbVrN/u1yU0m3jeJOP
	 Z2gVD8UeVCpXeu4qn8OmS8o+5HNNjlW2HPDkV/rM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BCB8F8052D;
	Mon, 20 Mar 2023 17:03:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C843F8052D; Mon, 20 Mar 2023 17:03:38 +0100 (CET)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A55BF80482
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2023 17:03:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A55BF80482
Received: by mail-oi1-f178.google.com with SMTP id s28so2865355oij.3
        for <alsa-devel@alsa-project.org>;
 Mon, 20 Mar 2023 09:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aykrVk11PH84fM2GSSqZSCXIg7R/09zXllx+hc7KgiE=;
        b=h9u5vV/Rpwqaa4TPPPRgbXc4GwRQHRPYW5SYNdfR5ogUqbOi/zYtvbAGrj4ukhNAr9
         aNb+39GuO2gLwBVt9deJ/7yIYHNbWlUdJssTX0SFX0zaz/Hn9vJfhXhzaPguywc41fqc
         PV3kBmW03iXmRZJypyCtAEEkrpuDLkn4UIpu6DkNz5+qjCmn1TYZ8flStHPYrtyYOINm
         tMiGVcof+Sm5Ne74KPIJPoC2lm/QtrzoQ/oT87SsopkxpT9lDJ2yaNy++AKjmf+Xq+a3
         29/Dl4muphyUjmo8XLEhqbpz0rlw3dO9N/PZBYBWNj9ndQSkIvdjciPn7z2Rwa3ypO30
         2FOA==
X-Gm-Message-State: AO0yUKVNzykGj+rrfJ4uDZMdEYB1Jf8S4zrfa8gzN0utsZiCRG+uu8Kg
	4u8Ao1wlEKKdsfqXEgFHjg==
X-Google-Smtp-Source: 
 AK7set9ZC/44ndn2AZ6WEHBP02JZbPv8blbEpBCxNo4pJk573f1aK48pBSdsvLxsUX2DiFnh9mSSkw==
X-Received: by 2002:a05:6808:6286:b0:386:c6ca:2b1e with SMTP id
 du6-20020a056808628600b00386c6ca2b1emr181632oib.7.1679328213843;
        Mon, 20 Mar 2023 09:03:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 p204-20020acaf1d5000000b003845f4991c7sm3895828oih.11.2023.03.20.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:03:33 -0700 (PDT)
Received: (nullmailer pid 1771818 invoked by uid 1000);
	Mon, 20 Mar 2023 16:03:32 -0000
Date: Mon, 20 Mar 2023 11:03:32 -0500
From: Rob Herring <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 07/11] ASoC: dt-bindings: rockchip: Add compatible for
 RK3588
Message-ID: <167932821168.1771757.7958131150512632634.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-8-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-8-cristian.ciocaltea@collabora.com>
Message-ID-Hash: KNCTFTEHU2BRUDUHS5T47YRFTNITMDVQ
X-Message-ID-Hash: KNCTFTEHU2BRUDUHS5T47YRFTNITMDVQ
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Cristian Marussi <cristian.marussi@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-rockchip@lists.infradead.org,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, kernel@collabora.com,
 linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Daniel Drake <drake@endlessm.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-riscv@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KNCTFTEHU2BRUDUHS5T47YRFTNITMDVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 15 Mar 2023 13:48:02 +0200, Cristian Ciocaltea wrote:
> Add new compatible string for the Rockchip I2S/PCM controller found on
> RK3588 and RK3588S SoCs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

