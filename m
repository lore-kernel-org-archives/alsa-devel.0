Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C384C83F14
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 07:44:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59D4974C;
	Tue, 29 Aug 2023 09:43:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59D4974C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693295038;
	bh=zE4J6/S+ao9m6UCCNJP0GcSsJaQZz4thgm4kUsCIIcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QbzBYxYlhC0vQQ2Ww1i7X7FdBsi2EJPKHB6SyL+JB5cCvYrnYtLDjiFqArlMkb8L5
	 8RLuF53ka2I+yUUa+LtaPocOb7VQa2jQDJlicPanIzcEMOF7l8ODA2YofGcWnXNIIl
	 Fd4e9eGl4Bdxj6+jjQWDflo/LcnGdop6DW4hcIVg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F956F80155; Tue, 29 Aug 2023 09:42:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC17EF80158;
	Tue, 29 Aug 2023 09:42:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD551F80158; Tue, 29 Aug 2023 09:42:35 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6AC23F800D1
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 09:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AC23F800D1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=i5va1TsU
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99cdb0fd093so527454366b.1
        for <alsa-devel@alsa-project.org>;
 Tue, 29 Aug 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693294949; x=1693899749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZidkGWNPi5BjyVLjLVMFpv4YzU60iSJ/Ecori1AkQ0=;
        b=i5va1TsUR/sivxWYmTNw0ts25LKsB6R7S9P3dyzzTC+Fh7W68bccjTByx/vLozPCD7
         It7sG2Ds7/CWT2/M7z8KA6r0Zx5v+Lqj0ks1AHc2YuE2LIFYmOyqdNSFemEYsWB6gd6v
         dzAoiFpNymOG7WMSmamobMgoHU7JfXgdMmHXuDqKieR1cFTu6Fg4SonCIH6An8oTxsnQ
         RqIL6KjiHnVgEEK3qiD/20g2v2VcSQkg25MLPb/ioLLr5TcP1rqanOpbrBeaRmA8PbAV
         IQDFriKYp3OMel93CxJxtaaOwpESEjrNGmC0bs45BksGbVMWvgsiZEWgFeZHhTkn6X8R
         eIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693294949; x=1693899749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZidkGWNPi5BjyVLjLVMFpv4YzU60iSJ/Ecori1AkQ0=;
        b=EkEV69CHoUBM2BuWqw8UCBDcrW2Uoj5zWG8qqEPNGY8MQCCYje2CrDRdClrDgilIMh
         pZTDRh0C3EDgPVXzsA7yv2S6v8Rny9HwjjCnVIywgfCc1J/DhRk5OK8RyzxtcqweByMq
         vZ1riG3oZyxJnJiCI5ULa1awEuPHQcTaVXGovaPNfw0VKu8c3rDG74giLLwzpC+xWmOz
         Qld02IzLU67fcgkWm/dGn3bERE8BcmW4a8Xj7D903ojZ19ko4ou1voSwMZxAuVhwuYD0
         z2WKBHXxYamUBX3D+jrVIrStta/Xy3MbQyl/p8Wchj3QH/naJDkbjItk+Oq2AiWvgdPZ
         8m/Q==
X-Gm-Message-State: AOJu0YwIErgRk8A0HLlDqUDxTBJwBtZZYWPNETqGh1cyCAXXmX1p/dAA
	DDY+2D7J69pRJsFvAxgzVjhRJw==
X-Google-Smtp-Source: 
 AGHT+IEWQr3QZ34jpK/5hL3ExGpvkPxLMtK2asR6mbFflpZ3LI8Ub6Apso9Cl+apOGcp3MwFMSZd6g==
X-Received: by 2002:a17:906:2243:b0:9a1:8a39:c62d with SMTP id
 3-20020a170906224300b009a18a39c62dmr20024316ejr.38.1693294948996;
        Tue, 29 Aug 2023 00:42:28 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id
 s11-20020a170906354b00b00992bea2e9d2sm5615023eja.62.2023.08.29.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:42:28 -0700 (PDT)
Message-ID: <e2b2f268-182a-5ba4-2541-f0a401eda1c8@linaro.org>
Date: Tue, 29 Aug 2023 09:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
 broonie@kernel.org, lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 agross@kernel.org, Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
 andersson@kernel.org, gregkh@linuxfoundation.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_jackp@quicinc.com, quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
 <20230311134008.GA20831-robh@kernel.org>
 <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
 <73655c17-5246-2c96-d415-6a30497966c3@linaro.org>
 <9d31db9c-4e58-767a-15c5-65f7c04bd989@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d31db9c-4e58-767a-15c5-65f7c04bd989@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: V74652JZHI5SOXZRIYIOQPBTVD7BUQSN
X-Message-ID-Hash: V74652JZHI5SOXZRIYIOQPBTVD7BUQSN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V74652JZHI5SOXZRIYIOQPBTVD7BUQSN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 29/08/2023 09:19, Wesley Cheng wrote:
>>>
>>> This is a XHCI feature, but the DWC3 design is built in a way that DWC3
>>> host initializes the XHCI device and populates the properties associated
>>> to XHCI dev.
>>
>> You speak about driver now, not bindings. If driver has limitations,
>> change it. Not really problem of bindings.
>>
> 
> Its the limitation of the HW.  Depending on how the SNPS DWC3 controller 
> was implemented the vendor it can support less than the value mentioned 
> in the Synopsys databook.

Then what is "XHCI dev"? A Linux device? Then a driver topic. What is
"populates the properties" - what or whose properties? Of Linux device?
Then a driver topic...

Best regards,
Krzysztof

