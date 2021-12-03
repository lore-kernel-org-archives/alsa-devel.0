Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34935C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 15:28:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7F5E20D1;
	Fri,  3 Dec 2021 16:27:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7F5E20D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638545305;
	bh=5I+sutZ25301fUussXltsNltM+1UbNdr1kk7t1j7Hog=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cj40kGxmqnkfqSal8nL6pUfbvCXQ4BciTaBW0c1D2O7jWH9AK4ODRq8ol9S0fli6r
	 /P1li6kKK9o4zBMk58IMJcU1GOKPS1P1H80TvjSBt3+ljJXa3S3g3rdlC2CGQbpBkc
	 Af93uiTQXuRB4dGlRqbGQHM5EasF1nXQVHIWyDd8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77498F8015B;
	Fri,  3 Dec 2021 16:27:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB459F80246; Fri,  3 Dec 2021 16:27:32 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FA0EF800A7
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 16:27:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FA0EF800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="krS4Kv9V"
Received: by mail-wm1-x335.google.com with SMTP id
 k37-20020a05600c1ca500b00330cb84834fso5170246wms.2
 for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2021 07:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+/WsUz2NTIgYD+0d+sIqCIUoU6+JU4Z8FYQ1kybTzX4=;
 b=krS4Kv9VlHaHrmYsa7ufkpHVjItqqFKwaj6kYw5aV7Jo1OJuKnQtvDrCGS2MlXWNOT
 UUGe+bzL98777Ddv0kXFvU2z61ZFH8N5KfRfG4uaKG0hWYtZUr3oArkrR53R0XHu9POv
 lqOdAvZxyhVT/svsBvrBAw8OoJhdm9Ahx+UCVi1Rll2kW4pFAGf6IbTid0EVkdm3sODN
 ioi7kWVcXQ7KIE3apRQwsSwOsycIV5sQanVFqcI3PD3hf1XtYj7HcFOT4EOlfPMWefB3
 Uk3QFTc2ST+Vjfp+0TPx6NgiJl13YK7GjjNDAkuEalSP2bHhbhL38XsGOGMjZQFcmAWB
 WORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/WsUz2NTIgYD+0d+sIqCIUoU6+JU4Z8FYQ1kybTzX4=;
 b=a6+v7U8/Ry6zUlmVia3Dx3mpxF9MHwS/B5vFEQJKt1BBKr2zQCxnSOwbG8Xli4y6bE
 rj7VeVfvQUV80DJNrWQWr0Fbhl0wRgLqiF6ELoc+38Ji0R63kSABhpN/d0sF3y0AXkJu
 Udpau40vvyHQHMg/5ow/xIhZN1qjqy7y7C+GsNqGDaQaOBiiIwZ4Ukq5dL/t14Z9tFcJ
 GbWF3Uccj5ihV70ioc4JhtEMGotVvmHcz6szrdODxVjQ/BMet4TFMQ1YP8lanmTlazLq
 iDtGiNaTl3ffcz64rAg59wPk1sz35Tlo+Qyudd4kkME+05IUEHklLAadLOGeCefeYIBa
 pPrQ==
X-Gm-Message-State: AOAM5308YLUBKyJRDvSLLnI7nWolBxG9SdiADY9dx1sDT/WORnqKhf3e
 fyG+mnkOzi9LvvYSO2HMNDqirg==
X-Google-Smtp-Source: ABdhPJzZndjAR05NjRsNKVtozMTDOwXN05e0sTIFj1OKkNnYpcltMY5p9KkMLuUvnX3IhzBu19oRYg==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr15558639wmf.185.1638545242530; 
 Fri, 03 Dec 2021 07:27:22 -0800 (PST)
Received: from [192.168.86.34]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id n32sm6264740wms.1.2021.12.03.07.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 07:27:22 -0800 (PST)
Subject: Re: [PATCH 5/5] ASoC: qcom: apq8016_sbc: Allow routing audio through
 QDSP6
To: Stephan Gerhold <stephan@gerhold.net>
References: <20211202145505.58852-1-stephan@gerhold.net>
 <20211202145505.58852-6-stephan@gerhold.net>
 <455604c2-9b73-4b9b-2ce7-890aafe41845@linaro.org>
 <YaorZnQTwvXo6vrO@gerhold.net>
 <5c6607cc-ad2a-6f90-e087-78ef3bd39e80@linaro.org>
 <YaozGfiaL2RjeY9W@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <36c175c5-7c6a-5271-0330-c4320ddbfb50@linaro.org>
Date: Fri, 3 Dec 2021 15:27:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaozGfiaL2RjeY9W@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht
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



On 03/12/2021 15:09, Stephan Gerhold wrote:
>>>>> +	add_ops = device_get_match_data(&pdev->dev);
>>>>> +	if (!add_ops)
>>>>> +		return -EINVAL;
>>>> We will never hit the error case here because without a match we can not
>>>> even enter the probe function.
>>>>
>>> Theoretically it's possible to create platform devices through other
>>> ways than the device tree (think of old board C files for example).
>>> I agree that nobody should do that, but having this check here
>>> at least avoids a NULL pointer dereference in this unlikely scenario.
>>>
>>> Please let me know if I should remove it anyway, that's fine for me!
>> TBH, I don't have very strong opinion on this.
>>
> Great, can I assume your Reviewed-by: applies without any changes then?

yes sure.

--srini
