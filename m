Return-Path: <SRS0=ibvm=M4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C7C4338F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 09:19:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0822561029
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 09:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0822561029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 979B31693;
	Thu,  5 Aug 2021 11:18:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 979B31693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628155144;
	bh=FiyaLWrw2fM5vbPkd0/aCwGhQFcI/3W6ACpjDkQwdnE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ro40FXJfJoplgdCXchH1dHWEoq+i4XHlDHEaE7tn19rRrAz+4uvkIXvL/WDSNjTAP
	 8pDmOK3BpVphjze38Qtm3PsrDcoRp38BqMusXOcBd8COSqfYr+NI6iIQGHTGueYelu
	 uIIdqrNy4oKL8KMHbaOeRkLI5E+sRKvSZqQ5tUwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59AC8F802E8;
	Thu,  5 Aug 2021 11:17:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EFD6F804F1; Thu,  5 Aug 2021 11:17:51 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B33BDF804EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2021 11:17:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B33BDF804EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="FoeB+ExM"
Received: by mail-wr1-x42e.google.com with SMTP id m12so5554395wru.12
 for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2021 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GJa/B18PSEsyuwuolhK87OQEucGZlB6tOjan1zRCNT0=;
 b=FoeB+ExM0YyDzrhJr5Hrfq/5Ie3qBvxf3tj3hmjniSZ5+q2tkESR4New7V5OvgKipz
 kbYZYUwjy9QyRovmHnqgjKJA8MYh/kg1IXccqlzXRGOb+7SUwl1PiBo903EbIOkqVQt0
 8jBG7zN3oMtJ/V4Py+eE4EmwvJgXLBsiYuxLaicwdkMEgfXG4+SRjwEKGNizhUpIGEwI
 ywZsxlNwBMugfCkjuRb3MJYJFfl2PVFyaFWjOYvONjOSFnBjHThwhe+aNm+SnAeOG0MD
 opkcvcuGVnpHyNxjX6W1LjnfJpK6HJ0c5aXh8dgDb6vF6k9S0xXrG9zcPU8kKmOOQNhz
 AWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GJa/B18PSEsyuwuolhK87OQEucGZlB6tOjan1zRCNT0=;
 b=CNrc6cbbl4bqBRFl0jSFio9TH9mAscs3674SoXUhaR6CNN8dPHR7ZgB/tViYEqDpFW
 QmLI7YKuDtLlxa0vwkMGahR3fk4XHpmT5bTL6xdjiIkyH81n03s07rMVpXM2mtwsmTyX
 ALXuxVNCVJOwfweA3R7JBIik3bXL0ppHyP62PZZOxYSIp+8RfhviT/N8uY4EW/Jc+eTT
 ljeGzHvsGUoE+bilZ4nQxobsH6jSrka68eb+EnszWH2orlT4guvXzcAFeDoKxlk8KkCT
 ELPf273hs5OcIVrrL2hT+BavbKZKQzNtjoK5d+GGeT1B66jEW6WpC0ASiilAKcHhK9PS
 9ByQ==
X-Gm-Message-State: AOAM530YfeAidt8cb17/zpGVn4s2Uto/JrYfn2do3cX3BpxTvYVDhNCH
 HxdgwIliGyiDEAlB1djZrgEmDw==
X-Google-Smtp-Source: ABdhPJyw7RtsLTkUNzM22r7POq5inabh4RlxT4Iy01PZDkOWRZ+kwsUqzOEZmDpvnOjRZ3pc64cYFw==
X-Received: by 2002:a05:6000:1818:: with SMTP id
 m24mr4019566wrh.49.1628155066067; 
 Thu, 05 Aug 2021 02:17:46 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id j14sm5617073wru.58.2021.08.05.02.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 02:17:45 -0700 (PDT)
Subject: Re: [PATCH v3 13/20] ASoC: qdsp6: audioreach: add basic pkt alloc
 support
To: Mark Brown <broonie@kernel.org>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-14-srinivas.kandagatla@linaro.org>
 <20210804180947.GI26252@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a23bdeed-9986-2e29-54d8-dcfba440825b@linaro.org>
Date: Thu, 5 Aug 2021 10:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804180947.GI26252@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, bjorn.andersson@linaro.org
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

Thanks Mark for the review,

On 04/08/2021 19:09, Mark Brown wrote:
> On Tue, Aug 03, 2021 at 01:54:04PM +0100, Srinivas Kandagatla wrote:
> 
>> +config SND_SOC_QDSP6_AUDIOREACH
>> +	tristate "SoC ALSA audio drives for Qualcomm QDSP AUDIOREACH Framework"
>> +	depends on QCOM_GPR
>> +	help
>> +	 To add support for Qualcomm QDSP6 AudioReach Audio Framework.
>> +	 This will enable sound soc platform specific audio drivers.
>> +	 This includes q6apm, q6prm and associated dai and clock drivers
>> +	 for DSP.
>> +
> 
> We're adding the Kconfig before we've added all the code so the thing
> works?

These are compile tested, but as you said previously with other patches 
I can move these Kconfig changes to patch at end of the series.

> 
>>   obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
>> +obj-${CONFIG_SND_SOC_QDSP6_AUDIOREACH} += qdsp6/
> 
> This adds two different references to the qdsp6 subdirectory which feels
> like there's something wrong...

I could have avoided this extra config by adding all audioreach configs 
under CONFIG_SND_SOC_QDSP6. Will fix that in next version.

--srini

> 
