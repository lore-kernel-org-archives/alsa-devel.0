Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD0C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 11:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2952253A
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 11:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2952253A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A133E1877;
	Tue, 19 Jan 2021 12:17:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A133E1877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611055086;
	bh=0BcCQMuvTXSv7R5IWRUppPVHs8ePAZ4nm+++GXF/YHY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RVsi0myqDMZUEt9rhpH5P/iTZ2VkpcJVMe9kkhHH+d0JHCGhulpK6/bF8yAtnDzTE
	 /w9yEkgG/uQw3RwXnCEDGVEqStgnsI8pfZnOgzOFNGJ8mjDejNyuUSE2KTE42XgF7G
	 exW5okBdca6vK6krRHG+E6iq0IdeQb6fJL/xSZyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EAB8F80137;
	Tue, 19 Jan 2021 12:17:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24F43F80255; Tue, 19 Jan 2021 12:17:12 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A50FF800FE
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 12:17:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A50FF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qLLUlAEQ"
Received: by mail-wr1-x433.google.com with SMTP id a12so19306420wrv.8
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WsO1uAj50LIfOs1CyjugaiMBtMQ6G1mLyclGaeMsN1Q=;
 b=qLLUlAEQVMJ1cTV9XcNBzzxHS/xML+3fZc6Zp6nD/MOfpLtqL2LWGxgjeo8D4gkjvQ
 os7aHrkhLy9WGApnHmN4Tybp8mPi9didFF4GFtL6Ft+fbKqfRGjAB4rtgVQK2KRR8Qi/
 BbBxn5Z2PByfEoUAEgBC97ZaG55OFddW7yXX0o2LV8TqsLpvjlw5OuYthqrbOPYkYUX1
 D+WzSfa8+p6GsZ5MIO5W+wn8easncOU3E1mTZy6kD8i0k2PALaxGm6DyzpqYZjLfbElk
 ucBMJ83Svgc7QfBXd7b+H0ithKWnO0ygeetOgS/uEBL91u55PUDVvzuQGEex7qDQVyVn
 rvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WsO1uAj50LIfOs1CyjugaiMBtMQ6G1mLyclGaeMsN1Q=;
 b=oeNek9Mm0cBZKxp7QOKOf1/s0YrYBnMmsP0SlMz+6adBJ8OG0REOW8AQTMVabLxEP6
 MB1QNffHufhCu/Hi7BUqhslRBheLXxfGGPZT6xXvXXG4mO2ld2vbF6n8knrE0SWLNEFE
 axMJEsnTCxdei7PDnvdpwFqwcmzaOVB2TOiyUdyZ+ksTQXjDGHo5jAuhLY5//IBOvUgG
 RYoqV5s0Q+Q/5VWPOP2fFjJ4jLRod03RsPmKVZ24NA5BznZqJ+g3yVbRpcogMU+HSiOe
 zzr3JSvntpt9MF4fuP10cutNwJtFHbHRLqE0joGox13HgOVj6slf0rIokh97oKS8CvSP
 KWfw==
X-Gm-Message-State: AOAM530IRzUMjgfIbvYQfq8Tx5YxNXICOV6OmJRZ10FcLuio8UV/5gtd
 KbR6RT0JZn4Ovs/jm3Vv7buuSw==
X-Google-Smtp-Source: ABdhPJw222+V7FniqHacBGKx4WEoVJbuntdkDmm3THqCkuzv3tNkOpYnwolhKKKV7Rok4zSUu0sWpw==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr3706401wrr.423.1611055020336; 
 Tue, 19 Jan 2021 03:17:00 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id z14sm1310871wrm.5.2021.01.19.03.16.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Jan 2021 03:16:59 -0800 (PST)
Subject: Re: [PATCH 2/2] ASoC: qcom: Fix broken support to MI2S TERTIARY and
 QUATERNARY
To: Stephan Gerhold <stephan@gerhold.net>
References: <20210118164509.32307-1-srinivas.kandagatla@linaro.org>
 <20210118164509.32307-3-srinivas.kandagatla@linaro.org>
 <YAa6vCPGZXxqXXao@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6c686ee-daf7-743e-e427-456ca4af56b0@linaro.org>
Date: Tue, 19 Jan 2021 11:16:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YAa6vCPGZXxqXXao@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 srivasam@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
 Jun Nie <jun.nie@linaro.org>
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



On 19/01/2021 10:55, Stephan Gerhold wrote:
> Hi Srinivas,
> 
> Thanks a lot for the patch!
> 
> On Mon, Jan 18, 2021 at 04:45:09PM +0000, Srinivas Kandagatla wrote:
>> lpass hdmi support patch totally removed support for MI2S TERTIARY
>> and QUATERNARY.
>>
>> One of the major issue was spotted with the design of having
>> separate SoC specific header files for the common lpass driver.
>> This design is prone to break as an when new SoC header is added
>> as the common DAI ids of other SoCs will be overwritten by the
>> new ones.
>>
>> Having a common header qcom,lpass.h should fix the issue and any new
>> DAI ids should be added to the common header.
>>
>> With this change lpass also needs a new of_xlate function to resolve
>> dai name.
>>
>> Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
>> Reported-by: Jun Nie <jun.nie@linaro.org>
>> Reported-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> For some reason this does not seem to apply to asoc/for-next or
> asoc/for-linus:
> 
> Applying: ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY
> error: patch failed: sound/soc/qcom/lpass-platform.c:519
> error: sound/soc/qcom/lpass-platform.c: patch does not apply
> Patch failed at 0001 ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY
> 
> Can you check if you need to rebase this patch?
> Also small comment below in case you re-send:


Sure, let me rebase this on asoc/for-next and resend!


> 
>> ---
>>   sound/soc/qcom/lpass-cpu.c      | 22 ++++++++++++++++++++++
>>   sound/soc/qcom/lpass-platform.c | 12 ++++++++++++
>>   sound/soc/qcom/lpass-sc7180.c   |  6 +++---
>>   sound/soc/qcom/lpass.h          |  2 +-
>>   4 files changed, 38 insertions(+), 4 deletions(-)
>>
>> [...]
>> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
>> index 85db650c2169..eff5de918e3a 100644
>> --- a/sound/soc/qcom/lpass-sc7180.c
>> +++ b/sound/soc/qcom/lpass-sc7180.c
>> @@ -20,7 +20,7 @@
>>   #include "lpass.h"
>>   
>>   static struct snd_soc_dai_driver sc7180_lpass_cpu_dai_driver[] = {
>> -	[MI2S_PRIMARY] = {
>> +	[0] = {
>>   		.id = MI2S_PRIMARY,
>>   		.name = "Primary MI2S",
>>   		.playback = {
>> @@ -46,7 +46,7 @@ static struct snd_soc_dai_driver sc7180_lpass_cpu_dai_driver[] = {
>>   		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
>>   	},
>>   
>> -	[MI2S_SECONDARY] = {
>> +	[1] = {
>>   		.id = MI2S_SECONDARY,
>>   		.name = "Secondary MI2S",
>>   		.playback = {
>> @@ -61,7 +61,7 @@ static struct snd_soc_dai_driver sc7180_lpass_cpu_dai_driver[] = {
>>   		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
>>   		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
>>   	},
>> -	[LPASS_DP_RX] = {
>> +	[2] = {
>>   		.id = LPASS_DP_RX,
>>   		.name = "Hdmi",
>>   		.playback = {
> 
> Specifying the indexes here explicitly seems pointless now,
> perhaps change this to just
> 
> 	{
> 		.id = MI2S_PRIMARY,
> 		/* ... */
> 	},
> 	{
> 		.id = MI2S_SECONDARY,
> 		/* ... */
> 	}

I agree, will do that in next spin!

--srini
> 
> Thanks,
> Stephan
> 
