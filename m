Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA9C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 09:03:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4381A61921
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 09:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4381A61921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7478C169B;
	Tue, 11 May 2021 11:02:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7478C169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620723795;
	bh=8FvviVsM+1Q6Of4tuCiAg7iWy/IdgqyHMtAbFa/D4Bc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pi7MkJsMYpJ4HadtVu5ac1i2yiznidm3Hj8DYTzyQdSPOp0YXHiZ097TjLex4G7TZ
	 reP/lNM0cbR1C/DBKBhujMSjrlEg8ZfqYPzTw1uu/pVrdRnWG0cAeaVQ7uS1cKH/rb
	 lv777MViQRQtLum/i22a2CwGeW1fMMU2gHLD3KP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1F23F8013A;
	Tue, 11 May 2021 11:02:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4958DF80245; Tue, 11 May 2021 11:02:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31CE2F8013A
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 11:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31CE2F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="N9gEJwlt"
Received: by mail-wm1-x334.google.com with SMTP id
 b19-20020a05600c06d3b029014258a636e8so801276wmn.2
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CEqjQE0LJp86UhhhWQsigU5SfvAnHBasJfR3WeTYln8=;
 b=N9gEJwltPLthv2q1yoI/pqI+yrjTFO+T2OyYXoZKmuY7q/ZXPgcWi4EVmtbR3j3dg4
 t5TlqdijCc0Mdbn6CSXDKLHEcyRnjA61a2vsxTC4i6UVYj2PiAtxmiUt39TU6K06GAVF
 SoenjZNnAgtFvrkNHpnGWb5/9sdWdydVKWEwwDSZCbQ/7GcSAE7znMwFmxlHbdfS2jM+
 zcSpiPyEdmlGhXVliIfit8yK+4CT6As0ZrekUC/XNOvMcfbhknjrmH4muLs1fcFfsbmu
 IEV31oX2VxJ+Fps8p/CXBPwEDT+np2wG/cu0IIncQAK2D98BtJZBhDCFxLLNwL6/j26y
 c8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CEqjQE0LJp86UhhhWQsigU5SfvAnHBasJfR3WeTYln8=;
 b=agoNiuawCVo/xkLg+szac6ebMXkPPTYdzMpqfg49Uqfl+wSKgLj6u0F8k5atxsq6Yw
 6iJHG5AJepoVy97W1B9qpwVKXHnaHcuqanKQ0KXsae76o5rE81TpNmM6oNfDlqQBb0W1
 E3c+VxN3HOjAT6DCQfCTPz5XTQmYiEXWFZEIthdrvMkP0LaPXlV8kI9+1pTtcEAGGG/3
 09f64W6OhKQPqxg4IDIHErjIcS2TdXBVcKiP3I9kZN3MN+he1dcWBVH7Bh6JCwlxj2hy
 yuY/9icn0kVBmZ23AxnOfB3O8c3Jxh5zRrT8q9/RNhLW5sbYmtI4psUuWKFPuna1MvPl
 iZJw==
X-Gm-Message-State: AOAM530L7IHjdP5gnwcaMzAMvK0wy/FoT2yCaQF22KJlBhOFhAHWTkqf
 /pV6GNSSrfFwJEexKkw7uvJgdg==
X-Google-Smtp-Source: ABdhPJzuaZ+c7GRyJ53sAuqLrcIj4BIYh6qkySDh3UN7HQ1xOcnIEghI+AOcFVJnBXhYn3HBUGGPwA==
X-Received: by 2002:a05:600c:214d:: with SMTP id
 v13mr3998488wml.13.1620723730553; 
 Tue, 11 May 2021 02:02:10 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id z6sm22732422wmf.9.2021.05.11.02.02.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 May 2021 02:02:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset
 Button detection
To: Rob Herring <robh@kernel.org>
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
 <20210510101201.7281-2-srinivas.kandagatla@linaro.org>
 <20210510164532.GA241925@robh.at.kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <26d6ce69-20ad-3195-e9b5-e95998babdef@linaro.org>
Date: Tue, 11 May 2021 10:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210510164532.GA241925@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 lee.jones@linaro.org
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



On 10/05/2021 17:45, Rob Herring wrote:
> On Mon, May 10, 2021 at 11:11:58AM +0100, Srinivas Kandagatla wrote:
>> Add bindings required for Multi Button Headset detection.
>> WCD934x support Headsets with upto 8 buttons including, impedance measurement
>> on both L/R Headset speakers and cross connection detection.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wcd934x.yaml          | 65 +++++++++++++++++++
>>   1 file changed, 65 insertions(+)
> 
> A search tells me this is not v1...
> 

I did submit something for wcd9335 in the past but not for wcd934x which 
is still v1.

Most of these codecs have same MBHC block so the mbhc bindings look same 
across them.


>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> index e8f716b5f875..b25c6ca4e97c 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> @@ -77,6 +77,64 @@ properties:
>>       minimum: 1800000
>>       maximum: 2850000
>>   
>> +  qcom,hphl-jack-type-normally-closed:
>> +    description: Indicates that HPHL jack switch type is normally closed
>> +    type: boolean
>> +
>> +  qcom,ground-jack-type-normally-closed:
>> +    description: Indicates that Headset Ground switch type is normally closed
>> +    type: boolean
> 
> I asked before if 'normally closed' was the more common case and you
> said yes. So I'd expect 'open' here, but now you've changed the
> polarity of the property. And now not present is not described at all.

Yes "normally closed" is the normal use case however Banajit commented 
on these binding with normally-open at https://lkml.org/lkml/2018/9/26/410

Ground pin may not be present on most of the headset jacks.
So we can not consider the headset jacks as Normally closed when this 
property is not specified in the device tree.

So having binding with normally-closed makes it much safer to use.

> 
>> +
>> +  qcom,mbhc-headset-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset detection
>> +    minimum: 0
>> +    maximum: 2850000
>> +
>> +  qcom,mbhc-headphone-vthreshold-microvolt:
>> +    description: Voltage threshold value for headphone detection
>> +    minimum: 0
>> +    maximum: 2850000
>> +
>> +  qcom,mbhc-button0-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button0
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button1-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button1
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button2-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button2
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button3-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button3
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button4-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button4
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button5-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button5
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button6-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button6
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button7-vthreshold-microvolt:
>> +    description: Voltage threshold value headset button7
>> +    minimum: 0
>> +    maximum: 500000
> 
> These can all be a single pattern property:
> '^qcom,mbhc-button[0-7]-vthreshold-microvolt$'

Thanks for the hint, this works, will change it in next version.

--srini
