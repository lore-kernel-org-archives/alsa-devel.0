Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A140C77B7A
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 12:31:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE6C8820;
	Tue,  6 Jun 2023 14:30:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE6C8820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686054673;
	bh=gV1QCNkGoRmktbI8Su9BX3S6m2/Wd9pWZI5mYOtEJKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EdED2VMXJYjglqRegmjeqIAbB7kanDL/whQOQL0GIDgCOH80BDTYu7wb2gX0wL1Rd
	 VV9K13bv3c5CyUUKBJ35ODDUu7XfR/uLGzFYWPXQp6Dg9RMRH5Uz3Q32mtHV9D4niC
	 Nc7hdhegq7xQbQcqS0i8NiXkjv8Vdp1ygHam6Gyk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5671F804DA; Tue,  6 Jun 2023 14:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2AC6F800C8;
	Tue,  6 Jun 2023 14:29:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A314F80199; Tue,  6 Jun 2023 14:29:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16673F800C8
	for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2023 14:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16673F800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UANglB0I
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-977c8423dccso634808066b.1
        for <alsa-devel@alsa-project.org>;
 Tue, 06 Jun 2023 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054581; x=1688646581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8bjNW006lIGeXXTvLEmyObQQvWZdXaKzwPi+Kg6QFQ=;
        b=UANglB0IvH5VFytUBHWTDZr279hkDNYZk3bE/mwXdOIJ7a/USJf7JT6YT4ZlctCbJz
         V/CbT4QIfMBx0oNExmEx1Ij/xUHn56+RkvgHEiSouvLIELitNpRnb5fRv0rMNDjc1Tl9
         VAvbPCj1O0oSo0ZGenpnc5S4sJqXEJRcvB8sFoTDPCzSxoZeUCbdUtsJsDa/2bwXg7jA
         P2PQuYDoNqPZK+24zDTYSUgGI1WwS8Ve0VcxUmYlJxuMPrkj99Y2nJGjz03w/F8E24E6
         QKioE5gtAQLwV3ugVZNCGApZ5NfE5ijPrYUvWsWcW4mDYXftPpr+P8qKUyusJwJNk1V6
         GW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054581; x=1688646581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8bjNW006lIGeXXTvLEmyObQQvWZdXaKzwPi+Kg6QFQ=;
        b=fCbUD/l2UblqN1hLUpYj5bN/QKpmSttf3G4RT4YVmhfm8I8TXLP0vB09Bh0Rtgp4s1
         JtnN1RgCzOkSqlTTuP59ahSB8ja+MSg6S6ABPHs1K4ktnpxOYd7fb/KOT128nvwUOtT8
         OnrYXCLftHBhl4m/WMfQgeqdfs44Uz2xvfTBFR5XZbX+EnaKO2hqCAUdw/ZZ324kEgOw
         bIn3EQMQroJMoYnAcNZLFqIKeG9ehwrL/5U3eVtmyGsPBF8fpnUKWK75hsVpoGsVTLK3
         2AyBDa2lPZhTefwxI7BHHn+OmdEdKEPA+MP5WQLxr2svCpChooEKDXohQC8ymeCUJlcW
         v0FQ==
X-Gm-Message-State: AC+VfDys87/ftfluVxlFxP2lluPUi30MDwK1GfFLF1WziN+dbG+HtMSw
	5XdAc9cdjP2JPdDMQnNwuuSteQ==
X-Google-Smtp-Source: 
 ACHHUZ74gCkWdqGt68D2uqIK/FVkMqv6PEjoxCaeOaRCVaW8otYDttPJwhpDSCZcZtZGFkgL/JjU6Q==
X-Received: by 2002:a17:907:70a:b0:94e:bf3e:638 with SMTP id
 xb10-20020a170907070a00b0094ebf3e0638mr2152290ejb.11.1686054581099;
        Tue, 06 Jun 2023 05:29:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id
 l4-20020a170906644400b0095707b7dd04sm5421948ejn.42.2023.06.06.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:29:40 -0700 (PDT)
Message-ID: <ba853327-9faf-3b2f-6e4a-e674c8b75b8f@linaro.org>
Date: Tue, 6 Jun 2023 14:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: stm32: document audio of graph
 port for i2s
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
 <20230606115605.1633595-2-olivier.moysan@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606115605.1633595-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: LP546FONNRMNKHOLCEYXVUWXTS3DE7DI
X-Message-ID-Hash: LP546FONNRMNKHOLCEYXVUWXTS3DE7DI
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LP546FONNRMNKHOLCEYXVUWXTS3DE7DI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 06/06/2023 13:56, Olivier Moysan wrote:
> When linking the STM32 I2S to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

