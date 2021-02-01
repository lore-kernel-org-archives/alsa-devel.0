Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25531C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:54:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDA161481
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA161481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E178D177F;
	Mon,  1 Feb 2021 16:53:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E178D177F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612194871;
	bh=NvdnQ8L41Io+cWOrm76Dirkh4fU/wu1ePPDbQyJGmgY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYrAHDWjDfr80yMaVLIu5uvfYxWZrFWZfTRBwcoq40Phoj0c5mDtMpI3W6QHjr9tQ
	 zHerDqDj7ZX1uDmLR6klxs5owqOQJ/dYqeBsPSldOLVG0otdAfR+148JEWftD3pPsg
	 0dlp4CdQD3Lw8q7H75F/jZNQ84ivKdUh8ZU3d+R4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69D15F8032B;
	Mon,  1 Feb 2021 16:51:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80A2BF802E0; Mon,  1 Feb 2021 16:51:23 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3A9EF800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 16:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3A9EF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="RZt6EQ19"
Received: by mail-wr1-x433.google.com with SMTP id q7so17081739wre.13
 for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2021 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hW4zbPjEI4/zS1ugenZya9710di15wb/LEVwBwRfkQE=;
 b=RZt6EQ19yq1+Zt438AyIJcgifQcWsqhHemxUK6rZJzEc2rnxcRXyhhFxTcUm0hK02v
 BRhnHSTUpYhWaOO59zKmUJkdLPyn/tJ/Rj1u3CCMe+jxbpzcXxiKZamu0QoUaSF1FTJM
 uAaVWKeWyJLqABxx5P5Cy1QjccDfKUSK4QXrwyrkoXfGUiwWmItHq20LuLKpFwZM6rRd
 kDE6fko0ltQ/mIPLlDMH1TjI8BenP5ujutcL4Vpo14KIkclYjyKpj9OrwoLB7Ewf//3t
 S0TIsL9htfmEeHvcnnWUUPX6vF7ACJNw557YdCOsv3dYya+/AYzA3tcpmHdGR0G57g4u
 RVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hW4zbPjEI4/zS1ugenZya9710di15wb/LEVwBwRfkQE=;
 b=RSU6MvMYhEVZ4KMS9GEE1YR9gOu0/fmgwbcbhjsDp0vIph9DXGwjGK/nccFfv6b5oM
 OjcAE2tvFKiwVQVOy/PmA1lJMShoib34cfErJaMKKy9+bxxpoWj7y6yHGj348YeI2D+u
 rlD09ucaD+pCsq82pqHuQYm7MLXHysQTWSS4V1pIbW50gMnfPwYUaRSsLj39fPhQTc0T
 0C8K/C24T4OmH/RhbFcF6/BHgttFbQCmpSXFZDmn7JAvmk3zsRmjxKnN6iKcUoL98b+T
 +2H5CsMevGeroGJRKCw73JWQcb47fMJRtIP69JlpvG+5NCF+Dy7TX+bJzFDtuH5mhd7U
 hGFA==
X-Gm-Message-State: AOAM532Nsq4swl6u6pyndA6kZXRk7ws2kYxH/riYeYDZoJvoCJod4ERS
 nANvAUBPessj6W/FBlUTpm/0Jg==
X-Google-Smtp-Source: ABdhPJz5Pc3Ab1nDFM5/3jz4Ydwz7X4TkyNPu0nzMu54J/QBEjD/IIewPGdNk1u3t0eUkdzyYJYK2Q==
X-Received: by 2002:adf:df12:: with SMTP id y18mr19036592wrl.141.1612194679756; 
 Mon, 01 Feb 2021 07:51:19 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id m18sm26854336wrx.17.2021.02.01.07.51.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Feb 2021 07:51:19 -0800 (PST)
Subject: Re: [PATCH 6/6] soundwire: qcom: add support to new interrupts
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
 <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9707a9b9-1e10-e7bf-aea3-4da164c31ee1@linaro.org>
Date: Mon, 1 Feb 2021 15:51:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org
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



On 29/01/2021 19:38, Pierre-Louis Bossart wrote:
> 
> 
> On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
>> Add support to new interrupts and update irq routine in a way
>> to deal with multiple pending interrupts with in a single interrupt!
> 
> I can't parse the wording after 'update irq routine'.
> 

So, basically if we get an interrupt while processing previous one there 
is a chance that we might miss the new interrupt!

This was a bug with existing code, which only showed up with recent 
Headset Button Tests!

> 
>> +    swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
>> +    swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, 0x0);
> 
> what does this second write 0x0 do? Usually interrupts are W1C, and you 
> didn't have this before.

Digging it bit more seems to be an HW work around for one of the issues, 
recommended by HW team. Will remove it from this patch and add it as 
separate one with more details!


--srini


> 
