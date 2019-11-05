Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A163AC17460
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:28:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2994521D7F
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iFm13nSN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFsnwvZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2994521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35C2516EF;
	Tue,  5 Nov 2019 14:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35C2516EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572960522;
	bh=mSyiJdqPiH+T8fLRhxAuc9T1iP7DlGrm7oI6wz46gzg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iFm13nSN9fqyIyPix948uNPzBiStsYEtGwtNVQWadHcH8ocx0K9QkmcNNfIbvooDd
	 ZMnsEfz+1yLDEB8lPPngsmhxoIvKgQzThh73DlVPJi6xkr89u5l3xnkxkgv4eDNYDL
	 q+QJUrjFAJx7OKfrsO0rU0vKnQETow57I9Yq0BQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B669DF80446;
	Tue,  5 Nov 2019 14:27:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C84CF8049B; Tue,  5 Nov 2019 14:27:50 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BA3AF800F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 14:27:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BA3AF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="VFsnwvZS"
Received: by mail-wm1-x344.google.com with SMTP id 8so13113117wmo.0
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hB3wQvRGrj1ZRhAhArvMifryRxQS5+RNbsqGlKhKgzk=;
 b=VFsnwvZSNKJMSeyhPMRpdB4ZkZ6AYmUUNRhN4Qn+9qfNHNcC6ktaTqN6hlQY8z30qG
 qlF43veqqmkNVZy9CfnyD0A8yBtPAxgvhX1uh+3IhiKA3TksGJ5bYEwJwqDUAyp6qd40
 yRDtgCQeFEhnOzGV3i/z3lUG99341c2z6YYWi7kYJ07qZt7eWSO2fWXgIlifnK0ZclNb
 mBi7qt4Tj1sUxRWtaFORfD2h4hQSbwxU+GQjWBt/F0ItPYmf3/n1RcS4QH+YKJIMMa0u
 WyWxnIrPBBJgV5MVCJsi74KqKHS/skjAwXoKuvF+MVMxXPjU7B9rzIHuFmjaw5OagwRA
 Aoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hB3wQvRGrj1ZRhAhArvMifryRxQS5+RNbsqGlKhKgzk=;
 b=dYpNYN7bZEf5nASTqYTqlXSGgTsD+YmVHPZGTe2WOqKXo39JcwOvJzEbTl5LxO5vSJ
 jlohTWDkvsrKElvQUCMdKbCbXDySN9DdFtU+ckp+Og27gp5T4ia1/QPG7I20cC8PbQZW
 J3Pyqjy6TOnQCLX2xxze0KDuBpb0tAdoyM2bY38RKGdjuxMByBqMGVhTCMgbIuAdaqqz
 sb5xEtckuI5qDyB2YwI2RPnAAHEMgqJynELoN+tdFT6iZCZTb83wbFUxtMhYYKzW41jt
 UEAtdosMROFKL2+dNuMFqvF9vSnnUxu/pgYiXF+2s8KmZ8dZunfC6WVo1pisN2oSI83Y
 yU5A==
X-Gm-Message-State: APjAAAWlYTecVTqjM+NJZ9ekUXVTInjQqeizTX+5EIaKQVuw2kKZMDBM
 PTmW2dKAQM6kQIFVDSkjV2XjQQ==
X-Google-Smtp-Source: APXvYqylIjqSxRwVDLHiilqgwmzoUpkTemPlTon9ahW0PhuOvXEZCINEZ4digiAahGcNH2/GlE6RAg==
X-Received: by 2002:a1c:411:: with SMTP id 17mr3955910wme.122.1572960467354;
 Tue, 05 Nov 2019 05:27:47 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id m25sm995475wmi.46.2019.11.05.05.27.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2019 05:27:46 -0800 (PST)
To: Linus Walleij <linus.walleij@linaro.org>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-9-srinivas.kandagatla@linaro.org>
 <CACRpkdYc-3Nk7VGj8mAjaM4C0dc_X7ZOK0cptW2Sr+kKwvyFVg@mail.gmail.com>
 <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
 <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <502c64dd-a249-bb2c-7bc5-8c66fa66be35@linaro.org>
Date: Tue, 5 Nov 2019 13:27:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
Content-Language: en-US
Cc: Rob Herring <robh@kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org,
 Vinod Koul <vinod.koul@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, spapothi@codeaurora.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v3 08/11] dt-bindings: pinctrl:
 qcom-wcd934x: Add bindings for gpio
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 05/11/2019 13:25, Linus Walleij wrote:
> On Mon, Nov 4, 2019 at 10:35 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org>  wrote:
> 
>> This controller just has Output enable bits, No pin control properties.
>>
>> As you suggested I can move this to drivers/gpio in next version.
> OK perfect, thanks!
> 
> NB: this probably also affects the compatible-string which contains
> "pinctrl*" right?
Yes, I will suffix it with "-gpio" instead.

thanks,
srini
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
