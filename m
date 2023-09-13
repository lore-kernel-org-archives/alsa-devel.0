Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B12CEEB59A
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Sep 2023 07:00:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53E139F6;
	Wed, 13 Sep 2023 08:59:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53E139F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694588414;
	bh=K40z8px6rsKFuhJPhRl2aF+kTRlLYUt985Zex7nv4L0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QsrsONBG2LNhqJVU6E2ZIe+9utjeJ0j/M3f1BNmt/NOqphnMMoSx7atzBCma/Wa9f
	 8rbmWvwPxuKQnQRukhFUtgTrrY7iPWwhXn2BP+EU2HFGXIQUwEdCLF/LYx3FsiFXs9
	 ojS2c1mmwkmChyZbEy1Bm65zIcw44W9gyLH7ABkw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83E94F80246; Wed, 13 Sep 2023 08:58:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 04D12F80425;
	Wed, 13 Sep 2023 08:58:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4C05F80425; Wed, 13 Sep 2023 08:58:33 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 433E2F8007C
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 08:58:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 433E2F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pI6yyTeF
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so826102166b.1
        for <alsa-devel@alsa-project.org>;
 Tue, 12 Sep 2023 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588309; x=1695193109;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gksMP3dK4wn2DN+b9H7lk6Rn6eIYazmOrqq6HYNSCKY=;
        b=pI6yyTeFl814z6/4ivfmDC3tPSwL7GR4mHZVcESc41jvB9aa+7lg3x9Dt64nfIrpzB
         fLLpxwWKwSyyKtACxq2aJIhqWvcHZkt8AkbWJ3tJmKFQO96LgkjQyHp81pp9CCAmPSfH
         3w6O9miMJxq2Q/NLRF75Ve18oeT45xdf5k/c9NrvgK1hENgww1xXwum4ELkyQ+PARlGe
         WGXziMejAGMl83HPguiRWqg2C5z2KaC6EbbF+D7iBMivvCU425VR6OqogB53hUbXWCDw
         HASAqUrSK2vmOpDjqHAzPxKdTrmXJaKqCg2Y7q9w91zJPhdiId4iaynOIFZNUMqqmyhe
         rsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588309; x=1695193109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gksMP3dK4wn2DN+b9H7lk6Rn6eIYazmOrqq6HYNSCKY=;
        b=LR9IHvqkS5bLaq321GVYKzwwb2CKcHneC89Jsd003iSkJ5m9nBlh0Ka3reHEO07UOX
         dVwaAErzkIxisqia+Ti9GO9sSk3zVQWRP7ePr7jHyKr6CkCPCcXmnERd2rkk0a0vt33b
         sYeuGqlnIdpYWR2nn6rwI5u9H9LC1nvLPBe/vGmSn5Fc42p/Ii2jx+R3iyZqBQshNKTe
         ArZzmvT266mj3FrJic57iz3svX8TW5XF6XukXTv84YhXtWF6Ql+YEyLcf4BBn5EQXYnV
         XYCQDowo/hVmL7AgOUNJg5Nc9DsLpyL4YS9dkhhal5/Bqg2VpmvK53nkulp+zdbAKkNo
         jZvw==
X-Gm-Message-State: AOJu0YwBO2G2Z89K9wNyqtWCgfE4h73rmCh95+Sp4Qv01HXt4XMoiwZq
	SFFDgPqi66Hswr8Mwu3cvdL6nA==
X-Google-Smtp-Source: 
 AGHT+IHcnx3ReFLiLWludwupXN06aZgy6qjBtw6dUTISD1hUkXhOPqvhWes/iIH3f9Gbyv4kr1kGTw==
X-Received: by 2002:a17:907:2cf5:b0:99b:de31:6666 with SMTP id
 hz21-20020a1709072cf500b0099bde316666mr1013675ejc.22.1694588308855;
        Tue, 12 Sep 2023 23:58:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id
 d22-20020a170906371600b0099297c99314sm7872303ejc.113.2023.09.12.23.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:58:28 -0700 (PDT)
Message-ID: <ed2fe299-d8d1-4dfc-72ea-5e86a69b9f5c@linaro.org>
Date: Wed, 13 Sep 2023 08:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Content-Language: en-US
To: Myunguk Kim <mwkim@gaonchips.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, fido_max@inbox.ru, joabreu@synopsys.com,
 krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
 robh+dt@kernel.org, tiwai@suse.com, u.kleine-koenig@pengutronix.de,
 xingyu.wu@starfivetech.com
References: <644e3564-994d-0b51-7d58-dac6afc1e0ec@linaro.org>
 <20230913064306.1862804-1-mwkim@gaonchips.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913064306.1862804-1-mwkim@gaonchips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: SEXA5XTYYR5ULBXO2NA5JD7N6GJMFCIX
X-Message-ID-Hash: SEXA5XTYYR5ULBXO2NA5JD7N6GJMFCIX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SEXA5XTYYR5ULBXO2NA5JD7N6GJMFCIX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 13/09/2023 08:43, Myunguk Kim wrote:
>>> This is not dependent on a specific vendor, 
>>> but is intended to describe 
>>> the properties of the signal(single/burst request) connection 
>>> relationship between i2s and dma.
>>
>> How does this relationship depend on hardware?
> 
> When designing a SoC, it depends on the RTL and Bus connection.
> My company has two types of configuration SoC: single and burst 
> to meet ASIC customer's requirements.

Then it is specific to SoC, thus can be deduced from compatible.

Best regards,
Krzysztof

