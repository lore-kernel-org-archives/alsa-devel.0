Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F46C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Nov 2023 20:44:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4612E741;
	Fri, 10 Nov 2023 21:44:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4612E741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699649097;
	bh=a8NZWEyrZ2cqDwdcROIsd8cFnWtC/rSLoxNkFwE/A2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PBfNRMnoE53hhMNJ0HtmI9w7mrkQho4q0maMTXwKbgML3IRGqdZOf1TUyIbv7joSC
	 dvXmENIv7jo1TNjMdIw5W4BOpVunNIUVSOwyoec9ZVI6gPmu7BgS9yKKUmPLEtIccT
	 VkrBJtDyMxj8ZZmwCB8KyQri31Z+yWRdk2FCvWII=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E597FF80568; Fri, 10 Nov 2023 21:43:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 831A1F80570;
	Fri, 10 Nov 2023 21:43:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A82FF80568; Fri, 10 Nov 2023 21:43:41 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFA38F80431
	for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2023 21:43:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFA38F80431
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-6ce532451c7so1342893a34.2
        for <alsa-devel@alsa-project.org>;
 Fri, 10 Nov 2023 12:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699649017; x=1700253817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JelqBtasuctrFq8aA1lg5BQxbworEzE8yTnhOMjZkc=;
        b=qNpY9Z7sPVrMghVfE0+Qv1yIxvPeClhdP+3Jh7zmMlNkTqfdBbhidl2S7qzfViK1hh
         hMR9eT++x9qhINLrV4s5NcmFEZiUGI1IFMRa7KhOZlbwthnTf/JTR2fMJpWPSITSD9bs
         RKQGsfKwz1Foz+5AXNtVfn8CdEMIziIiCoJhrMBR6GicZ9z5rHr0Efs+xo1MwwAp/Qxr
         eqdU6Aj4D8OODdVuadjf9CWDl+9XsFgcoiTWK9TlnSzXE0xizmVJWSp8yvAKrbQT4C1y
         ty0L6E2GvNIgVGk/ZR6HSsEsH6sdTmFt+h7S2fZYi6cyRXON4qNiGcsP37CheGtl5oeR
         GZRg==
X-Gm-Message-State: AOJu0YySeHb1KDi+VdS2hm7ctiKdvv4bwSfxdAdzhFAeWdDOPRGLOWLC
	iCDClzQt8qzw7AgCdzqOGQ==
X-Google-Smtp-Source: 
 AGHT+IHvxcWxE9DKzdafhiZ3HFcZS9N0tFj/iDRHQnxnirdx157d/x13I8sAnvTh754BbGSMSLyN9Q==
X-Received: by 2002:a05:6830:3492:b0:6b8:dc53:9efd with SMTP id
 c18-20020a056830349200b006b8dc539efdmr345339otu.3.1699649017102;
        Fri, 10 Nov 2023 12:43:37 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 l19-20020a056830269300b006ce2fce83cbsm52941otu.25.2023.11.10.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:43:36 -0800 (PST)
Received: (nullmailer pid 399226 invoked by uid 1000);
	Fri, 10 Nov 2023 20:43:34 -0000
Date: Fri, 10 Nov 2023 14:43:34 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>, linux-sound@vger.kernel.org,
	linux-iio@vger.kernel.org, Sam Protsenko <semen.protsenko@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, linux-i2c@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
 Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>, alsa-devel@alsa-project.org,
 linux-rtc@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
 devicetree@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 12/17] dt-bindings: pwm: samsung: add specific
 compatibles for existing SoC
Message-ID: <169964901433.399188.3619478168082919994.robh@kernel.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
 <20231108104343.24192-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108104343.24192-13-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: KGSGFITMED4WUSUG5J6Y4KSYEX2F7XWU
X-Message-ID-Hash: KGSGFITMED4WUSUG5J6Y4KSYEX2F7XWU
X-MailFrom: robherring2@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KGSGFITMED4WUSUG5J6Y4KSYEX2F7XWU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 08 Nov 2023 11:43:38 +0100, Krzysztof Kozlowski wrote:
> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
> 
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

