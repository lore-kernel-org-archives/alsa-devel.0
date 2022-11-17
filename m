Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BDDC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Nov 2022 14:59:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BC6916D2;
	Thu, 17 Nov 2022 15:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BC6916D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668697188;
	bh=7zQFpy/FThvyoS2Oh8s5pADJRem9WWaeRrr4Ft0S/MI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7JBY+uX4RyHjP/bdm+TeEIdSJIsv0IAEs5aQ0MPq+CKcnVh1zE5MOTouWuH8hyPz
	 ubJaoaNvcu9qvlHyBmtKzzIZkci/IFRviwbyzHi2zUPZCSYxwjuxMkmI9CyXH3UG/O
	 OlmWskE+bKEuHQ1LW59K+GWHhj6LXH8gALd0TotA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31B51F800B8;
	Thu, 17 Nov 2022 15:58:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46A5FF8025A; Thu, 17 Nov 2022 15:58:56 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6E37F800B8
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 15:58:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6E37F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Ur9szg1D"
Received: by mail-lf1-x130.google.com with SMTP id bp15so3166724lfb.13
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
 b=Ur9szg1DKJvl3ubQjvlChH09oAO12tYaDGESWoJRFs5nbTcgL70iq6Rk6jcbyh2eSV
 5sIr6XHiZbOMcG5vg6LYzpKXTZagjOTTXivxVfplX5GAD0O1/9QIYKFbd0XkOcolglVT
 VrJu0CgFgUecUmcpa3we0bBiZQmSB6sCWxEucrm8wK9mxNNpZRyq2THIgu40f2wTK8zo
 2iE5ibWayllqwdjGN++kkVQdW9OgLgRj0+rBH5OvzcLsoNEByi9LNspb+2B+W5wqkM41
 Rwzp9Tu2wWCQ3oQ9fSXsHYYSxRuw8yfwAEchPTid10LtcwGqSDyeXQdG7IyHwjOChaWM
 86bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
 b=E/V8GBgPqwWSjcOeCe4de0G+ZvOxsCIU0J1BgcuXKC+jViPakKgI0De2e4gWRik0tT
 J4UB4N0AX6/5FQ9+laRBVboYVH/MulobxJN0hG4C49fmZ6yGGEgPC8v1FP11tbgATgao
 BrP7BWmdYFSaxgsS2S+6jWb14lzBIikSbtAEc5YnKIpcdKrgodvbDKTngXNgtl5BsvIa
 /NiBQkKSI0mntWozWjFu86T4UrvtnP/hW+peitbNcu9WwqZstVyRBzujtYAxD8Q/WPs9
 bQLusRJtnUWFV1gPysojFh5/VKqXSDHg9HjteWc4HdLGvRcr7QWzvzq9NPyibzy3/cBn
 HUmQ==
X-Gm-Message-State: ANoB5pkBcIpztOJZoaIIIeTB+gxEevh5dKO9TRJeG8XNaT/w1lEdlizJ
 /EWSC3j+E8EKXlazFCmoUtM1VA==
X-Google-Smtp-Source: AA0mqf4/hs47bXqsUk4ZLu/jQ1Wna1nuVovn6G3NWi6j/M3148XUWs2V/ZZa76pyYbEsKXo3MQAsvg==
X-Received: by 2002:ac2:4a69:0:b0:4ac:d080:e1bd with SMTP id
 q9-20020ac24a69000000b004acd080e1bdmr1120397lfp.318.1668697131665; 
 Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Received: from [192.168.0.20]
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 r8-20020ac24d08000000b00492dfcc0e58sm186892lfi.53.2022.11.17.06.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Message-ID: <2f35b9aa-1385-9c2b-ed60-721a835645dc@linaro.org>
Date: Thu, 17 Nov 2022 15:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/9] dt-bindings: drop redundant part of title of
 shared bindings
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
 <20221117123850.368213-2-krzysztof.kozlowski@linaro.org>
 <Y3Y1xjOjijBsQLZA@lunn.ch>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3Y1xjOjijBsQLZA@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
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

On 17/11/2022 14:23, Andrew Lunn wrote:
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
>>  
>>  
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
> 
> Looks like some other automated change made its way into this patch.

I forgot to mention in commit msg, but maybe better to drop it to reduce
noise.

Best regards,
Krzysztof

