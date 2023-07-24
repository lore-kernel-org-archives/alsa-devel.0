Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F139C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 09:07:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1DD9827;
	Mon, 24 Jul 2023 11:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1DD9827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690189641;
	bh=l18k187mtitk1gVC9byMCiklZ8xeAE/bhdhOTerQq3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gyAk8sjq5kIXBwny4su8vrKcPkSi7vu/e5SDa8xMQvAtdwscX8GL4YmsXpeJ50agy
	 WzyploZrj6x8E7GQyotwa0+CpkE6GLhyWIvGM3sS1se+yFFb2xeGuARhfBsI/oR5rP
	 yryHEZLICU+H09L+xnWvfKThtANeAtqoHadqW1Ik=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAC35F80544; Mon, 24 Jul 2023 11:06:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3819FF8019B;
	Mon, 24 Jul 2023 11:06:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 239E6F8019B; Mon, 24 Jul 2023 11:05:59 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 61207F80153
	for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2023 11:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61207F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UfKiaBvD
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-992b66e5affso704345266b.3
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Jul 2023 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690189549; x=1690794349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qBTrjnoLMPhI5YTQA6DVRtgSqXnXbNpJNoKVH85RHE=;
        b=UfKiaBvDzfuRZfFZTzzjwQ3j8D4qXCeEqovTw+BFdwYYQsQ/bSd8SpMCg5KI3NtoHS
         no3tx7bqUwjQ+k4qHHUw/417iFuUB/B+xWSWNVjmbSf86DtlLGazVtPiJMawJFgcp5jV
         +C57nto4QTHFYrfpsHWa3EU5oM9qVMJEl887lRC9fHKW810esRi8c2Yq3CLHVR2Qxd+f
         gScmx6pcJgmHIUw36TFMu3kBRfJ6y6vACqhqeBTi/EHVKce25sACNqBTr7ZEOp/EYn4d
         Ou1Hh2LAzkpZw/Q3pY//h0NzynXaX6ni7zSeX76J7XlRi/r3aIqucul4f4Wufhp9P01N
         obwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189549; x=1690794349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qBTrjnoLMPhI5YTQA6DVRtgSqXnXbNpJNoKVH85RHE=;
        b=BWOo5X2hOfpYGiBfZsLYcFSvJ7Cr3agVBCirPzU09ER3wNyGhkD3eMcw+LxYbjBIY+
         Tlx6N60T20vcngTs4K3EFdMo4ozhT3gzAROtqFL6tmSLGOpBtVPWtLym3DnnCgi2kU97
         eNM/i2oBcmhHBYoCy/anKTdMOcVSJoRk815OZPWA0/HeprxZYyHmLeCw+CJvmdVED8Mj
         YJo2kHJIV8lNWQ3O1aNWpqAWeiGAeVsgj8vsCcgDf7jemQHSxN+DVpSdheDCDLzcOsIA
         nisiqBdAaSGeXeDADgAz/2Ba6RXjFKi8nshCSallrLyXnOsjh7uzZa43IKXc5ZkAqta/
         kb7A==
X-Gm-Message-State: ABy/qLalsWBK6y3yEFAiNhDLGbhuQ1KIYOD6lfqGZqbKGo62mVqpD0n+
	3Bx3XKkIZwP+ekl7302BgKptXQ==
X-Google-Smtp-Source: 
 APBJJlGEaeQNWfy5PFWso8e07aTFyy4J/IEQjoHP1CCmOgc32EJRFyrwx6VuXaTiMbcq/GqEflFuPQ==
X-Received: by 2002:a17:906:5a4e:b0:99b:4f06:492e with SMTP id
 my14-20020a1709065a4e00b0099b4f06492emr10205331ejc.64.1690189548870;
        Mon, 24 Jul 2023 02:05:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id
 b10-20020a170906038a00b009929ab17bdfsm6406085eja.168.2023.07.24.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:05:48 -0700 (PDT)
Message-ID: <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Date: Mon, 24 Jul 2023 11:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>,
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>,
 Zac Crosby <zac@squareup.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>,
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev, linux-usb@vger.kernel.org,
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: XEBP3G7WCPVKCORJ2LSXO25RDWJYJAJC
X-Message-ID-Hash: XEBP3G7WCPVKCORJ2LSXO25RDWJYJAJC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XEBP3G7WCPVKCORJ2LSXO25RDWJYJAJC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 27/06/2023 18:24, Konrad Dybcio wrote:
> The description of reg[1] says that register is optional. Adjust
> minItems to make it truly optional.
> 
> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

This patch does not make sense. It wasn't also tested. The code
(minItems) is already there.

Best regards,
Krzysztof

