Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73476C7618A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Mar 2023 20:35:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E5A31090;
	Thu, 16 Mar 2023 21:34:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E5A31090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678998946;
	bh=Ayb5rEabCE8X8DNs1xv3rvRhvFcUE13OafuxOT/dCek=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UwHSA/hZfHLJYgAEc+lT/6I/koJwOzynzy8gFyJCXFiubkwCX8qIdcZjRgYosIYHW
	 f0u0VPsUgZLeH7hrphxQbIWyJVX0FGdUuwVM64m8GwFUH6oKANZxx75rereITincLW
	 WD7BeDRvZlw9DN0zH12esK9AGNu1OpPE1qfCnt9I=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1891BF8016C;
	Thu, 16 Mar 2023 21:34:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DD4AF80423; Thu, 16 Mar 2023 21:34:30 +0100 (CET)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63AA1F8016C
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2023 21:34:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63AA1F8016C
Received: by mail-io1-f42.google.com with SMTP id q6so1377814iot.2
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Mar 2023 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CYbM47sU5ai4TXEql000Ah99D8S1/cVmeQxmiAsqhs=;
        b=Uzil6yvIUyKmDtAwzAOtbJ+GYxI4DHOPRIJ+sHq/PlfpFGoqrGqhLULQeYAOYGuryE
         8grYpOW+dfahRCOdXX/egoEyteroUiooDHsMQwDt0jODrzsOAOt7jsHhSGVd/NrroliL
         LH8AeS1ogGArBLfIVKPEMZkdgGBaElZ5pCfEb/ei3zmhpklpTHd5ONeuJOqpN37rNncU
         qVSYnsVR9I8X8VMV/bmO4uwNTPlkJJ98E7mDff4lAGvSexHP4OMqG1nPV5dJ/UEDr8Ch
         tRaixNh1QyZO7+olHdZ+s3XEvMAjEyHmcnUQJhE48RSaQsCSPhK3iH+m6bsMzs5zuDwN
         XV9g==
X-Gm-Message-State: AO0yUKXCd50HVRnjjDfDBGop7548YEuNVbi0Bn2F+fJnctqA8xgHmqft
	Sn0s9s6AUjKaQHd1c2T4Xw==
X-Google-Smtp-Source: 
 AK7set95htVCepu2fkqTuH63ymkWubjwHz01woOvMx5gt6cqqYiqMELyvuyd4SP0vC6lmQKNMoI68A==
X-Received: by 2002:a5d:980e:0:b0:74c:8b56:42bb with SMTP id
 a14-20020a5d980e000000b0074c8b5642bbmr102686iol.8.1678998860080;
        Thu, 16 Mar 2023 13:34:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id
 q15-20020a6bf20f000000b00704608527d1sm43269ioh.37.2023.03.16.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:34:19 -0700 (PDT)
Received: (nullmailer pid 3837822 invoked by uid 1000);
	Thu, 16 Mar 2023 20:34:17 -0000
Date: Thu, 16 Mar 2023 15:34:17 -0500
From: Rob Herring <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: firmware: arm,scmi: Document
 assigned-clocks and assigned-clock-rates
Message-ID: <20230316203417.GA3833267-robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
Message-ID-Hash: KBPBAZTMWYLHEK5I5YD2TF73LJXUKHQG
X-Message-ID-Hash: KBPBAZTMWYLHEK5I5YD2TF73LJXUKHQG
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Drake <drake@endlessm.com>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, kernel@collabora.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KBPBAZTMWYLHEK5I5YD2TF73LJXUKHQG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

+Stephen

On Wed, Mar 15, 2023 at 01:47:56PM +0200, Cristian Ciocaltea wrote:
> Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
> protocol child node properties") the following dtbs_check warning is
> shown:
> 
>   rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are not allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)

I think that's a somewhat questionable use of assigned-clock-rates. It 
should be located with the consumer rather than the provider IMO. The 
consumers of those 2 clocks are the CPU nodes.

Rob
