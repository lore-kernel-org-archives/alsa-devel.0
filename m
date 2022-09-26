Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C72C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 06:41:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBC0DF3;
	Mon, 26 Sep 2022 08:41:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBC0DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664174515;
	bh=xp0LaHp/oiXYkGgnQkFPfGbOivOwbU8cnR2d4GjylTU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lwGo2UwIkXxKgYojXfZZoyQbwU9bgHIO4Fnk/eWrpXyzDa23WR+24oE7K31pFAfTK
	 mAVNU+vVwESTkJWtZCA1kZenTJfBA8zsbc8PGsMKg9NZ7ucBrK2z1YuXdsutqEutE+
	 7tWwUOE0m1WijeX97YKocMZLsWmFHnAaaWdZd7PA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D242F80254;
	Mon, 26 Sep 2022 08:41:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7FEEF8027D; Mon, 26 Sep 2022 08:41:03 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE6CCF80115
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 08:40:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE6CCF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="w60uglZU"
Received: by mail-lf1-x135.google.com with SMTP id w8so9239998lft.12
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2022 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=eEvomUPAbiilR0mKyM+WIzCcrPikO0w/LFnRQciIxbU=;
 b=w60uglZUbrcD3QCNC0WDlhn4fApibMa2aQsWpBwYCibhs1DBWo5EBY/PjL8wxVv26g
 477bVsR22foGesJpe6cgXjXh3fmpoaFaCgZ1soGWKo3GW7FIWSdYRRLPNEVssFg8HB0O
 Lx4oaqIjEOJtNMl4DW/U/RVPRI+ZlWAFgkgLa88o3DJROB0BAgtHDHQgxfO7jyUqh20o
 ciCfTypVKX4vkHxCT+GXFL34RM1AtsrJKCDNvZLPckBvqe7EigRrfkMElWkFCwUoJWzC
 R4yKjVlIBL64SBieqoLefbjdN3LN3bI//9/y+1cGUojltg70VhenDoplBx1L6UJjur42
 4IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=eEvomUPAbiilR0mKyM+WIzCcrPikO0w/LFnRQciIxbU=;
 b=3l0cmM/hax4i6eykmUbFDx2dlHtDXBgHF5sB6fkg2KZ0oGNXSB2wOiq2lX4czVcD6H
 qcrESUKf5GB+g22wS3rORkJ3KIkq7FVB5NSi/NlcmdBfT6AZQoRu7eUzOwTHq13JbEkp
 07kBVZ5TLJVni2zYkbglmVdUMZOZEW5UTn0MSXZQmI325hCdCKXR37qPxR8hqGZSJl7h
 NA99ppC8LbyRt0DUt+wxoTmxG2Oqox/elHjsztC4XkxvhnY5a68dskMBELQ0M+Dw5Ogz
 IgRM1TZYQf3Ex2uA4ngbKvZae88neDoeuST1nbkv+UKjqH3ruHvRi+3foYrz+esyNL7Y
 nwvQ==
X-Gm-Message-State: ACrzQf1b9qa4XVZkWJx9XTIbR78UUhPZ1iMjk4ERt6xtrAALqvIlK570
 0Dwk/gFK/GLK5H+K+PPRTBlsLw==
X-Google-Smtp-Source: AMsMyM4ziGPYUJOsSHyxIGY8wGTAbXEUpXp6IRhzzGaBwqcucwGeDucnhnk4DeXgU7z0ZsmqNB8jAQ==
X-Received: by 2002:a19:6b05:0:b0:49f:53b9:abb0 with SMTP id
 d5-20020a196b05000000b0049f53b9abb0mr8630989lfa.166.1664174454735; 
 Sun, 25 Sep 2022 23:40:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 a14-20020a195f4e000000b0048ae316caf0sm2440905lfj.18.2022.09.25.23.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Sep 2022 23:40:54 -0700 (PDT)
Message-ID: <7b5b9f3a-129a-b6b5-4348-cca7381c2d1f@linaro.org>
Date: Mon, 26 Sep 2022 08:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sdm8458: align node names with DT
 schema
Content-Language: en-US
To: Steev Klimaszewski <steev@kali.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-8-krzysztof.kozlowski@linaro.org>
 <d3218018-45c4-4777-77a7-91947ad48666@kali.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d3218018-45c4-4777-77a7-91947ad48666@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 25/09/2022 20:58, Steev Klimaszewski wrote:
>>   				#address-cells = <2>;
>>   				#size-cells = <0>;
> 
> Subject has a typo - sdm8458 -> sdm845

Indeed.

> 
> Tested on Lenovo Yoga C630
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>

Thanks!

Best regards,
Krzysztof

