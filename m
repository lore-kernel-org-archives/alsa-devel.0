Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0928FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 14:04:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632764E3F
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 14:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E632764E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0CF7168B;
	Thu, 18 Mar 2021 15:03:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0CF7168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616076279;
	bh=dDmy1feZKcs3J/kf8CId2DGiJatVw52cKc9lne9UrXU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqLrGD5SgWUlf5stwLZtEpYwyqW3IcUlCYDTEqzwiuIqQrdWYOqbleVLSc+GmFkem
	 Ug4az7NvmodQqPB2N063ZYhV6Ke/sP8bWRBkgOnGnWZve48pcA2u6mU2kSErBh2osP
	 BYH6Scem9XftjT3otKIM0So2BTgAt15nlxNak9Dw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5386FF80163;
	Thu, 18 Mar 2021 15:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F144F80165; Thu, 18 Mar 2021 15:03:47 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1230AF80124
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 15:03:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1230AF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="kMTJZCsE"
Received: by mail-wm1-x32f.google.com with SMTP id
 f22-20020a7bc8d60000b029010c024a1407so5506180wml.2
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZReM8DwR8a2U3UBCVgcUkguF91LKjIlH9I+CymAeckw=;
 b=kMTJZCsEswCTV0IOs2LrLlG8I4bWoY2TouGrqtp9oQ21v1tf9hXqjaM9r7R29cdCPj
 zidW37grNEiC8HBmzNzEwSe7rwe2N7ctPv+GP1UC6UILZwS9QDYOWyIqkU9xBtKvtdrA
 ERNskqdPrSC0IGGctXOc786wJx5TJwWEtpFWAlKg6C3Xw7Qd9mOPhgNlA2Jqub8/3G6t
 qoNbCcDoGCB/0V6qc8uXO0PHyQXLe32BH8/tHb+PhDo+Om6guMWWrnAGDTcGGuKp+kzr
 KB7MAi+kAxg6wO7OcnD8mAPIU93c7f0T5ylKb1ijs+Lb8gQS/9Kh8/hPRDWq0i7d3GZM
 LELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZReM8DwR8a2U3UBCVgcUkguF91LKjIlH9I+CymAeckw=;
 b=gMgYxJCYpkCA3o46MGczZtAThGcfLOVoGxMD8lhOWmquQDgKPDNfmIVxPqok6P53dx
 YSNuzD7LbuF9oBjmN3W8cWABzsYTC9coXSdZYNl6QIjz9iVTRcp0AjoII4/+NcntMdHQ
 F0qYW9z9VXGx8XuPSu1LJY8ZuzEuyRXR20LtxOdcc9wyORMnMX4NprsmVS4Fkui5oWXL
 aQ4yfyRuM4NFHkuO61K1eCVzDOun6PQWa3wgiJLp7o1CcUc17pf+AaLpZoSY9rCMXGpm
 qvJ/gPjqGKd3/oyjV1SVcJ41CqJCGlth8YNSehmzNQWkl6NRCieRPlZRZ4yIM3VepV88
 cFyg==
X-Gm-Message-State: AOAM5310jvmtAw2f4iY7uH4KQUUzSGtGR/uF2NMb0Sbbds6n53Ju3BiM
 iQouQoy1ltBH/KUFO+uhkY+ScA==
X-Google-Smtp-Source: ABdhPJzGV4Gf91DcNI3fCVPWUVoFreAEUJAv0z7EsvQ3vusYi2GEvFl4vLVm9dliIy0X9/ZpQUWDyw==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr3774517wmj.109.1616076215547; 
 Thu, 18 Mar 2021 07:03:35 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id b186sm2466096wmc.44.2021.03.18.07.03.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Mar 2021 07:03:35 -0700 (PDT)
Subject: Re: ASoC topology loading vs card bind
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <09c77d7e-3def-0643-b838-94d748529333@linaro.org>
 <4a4c96df-b145-5bb7-ad91-e5d3644f704c@linux.intel.com>
 <5b10ad71-44f0-d0f7-431e-18447e11596b@linaro.org>
 <27b526b6-9432-f014-d639-d3c80af191d3@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <61df7314-0d88-6195-000b-e7c4258b5951@linaro.org>
Date: Thu, 18 Mar 2021 14:03:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27b526b6-9432-f014-d639-d3c80af191d3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
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


Thanks Pierre for inputs,

On 18/03/2021 12:40, Pierre-Louis Bossart wrote:
> 
>> Am trying to load FE dais from topology file along with the graph 
>> definition.
>>
>> Ex:
>> Lets say we have a dai link in soundcard which has cpus->dai_name 
>> pointing to an FE dai ("MultiMedia1") available in topology file.
> 
> Why would you want to do this? You are hard-coding an FE dailink in the 
> machine driver, when it can be described in the topology.

TBH, there is no reason to do that, I was just trying out ASoC topology 
on QCom platforms :-)

I will give that a go, hopefully that should help!


> 
> Look at the SOF machine drivers, they have ZERO FEs hard-coded, 
> precisely because we want the topology to define FEs.

Do you have an example topology for this that I can take as reference?

thanks,
srini

> 
> And for legacy machine drivers, we also skip all FE dailinks and only 
> use the ones from the topology.
