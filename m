Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB7FC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Nov 2022 18:09:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B1CF209;
	Tue,  8 Nov 2022 19:08:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B1CF209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667930982;
	bh=B6uu987FBV7Pm7/M23OnSqVr4ki2hZ1csrZaoH2vNek=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQMHH/v2S6zmAM5wZR51pIXLbYmJmC3LHsyL7UfEEnt8ha7xNeY5yhBvEjyL63sYt
	 yKH30o25HGFg7LmXPsvYddrpNxZJsk5vb72Ll5rc865yP+MUl/rugQ0u8h/1oeVRQh
	 LOFmh3pXI703t37hhO3WXCfDB0JqJgzYiSaouzo8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08D32F8016E;
	Tue,  8 Nov 2022 19:08:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE32CF801D8; Tue,  8 Nov 2022 19:08:50 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52E3FF800F4
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2022 19:08:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52E3FF800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="TMHCOOqA"
Received: by mail-lf1-x135.google.com with SMTP id j4so22398885lfk.0
 for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2022 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ocux0pp1E+FeRNpO7DTAPUYF97MyHzA2fZ5zmFok8Rc=;
 b=TMHCOOqAcUzN3uR5F/zXXSbAwfZe7p1vuuhaYPiH66PD/EYb/Oh2mlqn3d6KwNwE2/
 3IgsCyGEJ5ZLc1iPGgvtLw3gWv9oFQEqgUsu0ElSBVMGjFoDnqGm2y+H44XZaYLvlIHw
 N+yRPAY60wiBHLRdaXnOPMG0djnnGAx50eqFQ4NQjzLIGeeM9mnFagcGIkFkbodFKppw
 wh1J4ANE9EBUtEIKl3OiLGIrXB37hhOnf9J4MG0HDH+1mtdvWcbypgCmMYClm60F8RSA
 E9LWFcJSpwncuzZUK+w3JHHDnKpnq9jw8ay5Vxqred1nXcixIBGO1M7oMWXDeayCWuPo
 jgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ocux0pp1E+FeRNpO7DTAPUYF97MyHzA2fZ5zmFok8Rc=;
 b=OXkrShtZ7Yr9pU1Xc/krIhUhoBH1MrcB/avpfQCTydSEsIV8JASNmFm0U7USz2/qzL
 CJbmsoagr8zen+7o8WOpeE9A4V4JKgFrnT7YQiiC5W24z3rlUFhGjNNF7HxUdt1XU/lD
 HJG6woRQynq2Y5KD/HdJnMgwmfY9ir71VjN/2PXp9XGbw0W6/ClPgZz0nDoqALiCCtI4
 HqyI5AwutFSunE7+Q4r3O9fT7vBBIuefc4QtK7ofBg3bFqDHO3+lqbNHv0ENwfpFUWJC
 MtEdimCCY5G07PifixlvotJf3UPY0PLOmfzFUueVDXLhljGI+1LKb6YJByn5NEOSvM0V
 GIUw==
X-Gm-Message-State: ACrzQf2HiMIg2KMh3YShDDQw+9KsNuXAjzKl9rgWTtH9tn82VxBM9epq
 SpVjp1/w6AFNwYVdFZ6E4/GuZg==
X-Google-Smtp-Source: AMsMyM6DPRsbvcl+c7foHNWB2NPljcYmU4yf5sCU5gzjt2FmWq8Bl8Kr8HiQ8Xe/E0FiBDDBlaqtDw==
X-Received: by 2002:a19:7009:0:b0:4b1:11a3:789e with SMTP id
 h9-20020a197009000000b004b111a3789emr14342630lfc.39.1667930920698; 
 Tue, 08 Nov 2022 10:08:40 -0800 (PST)
Received: from [192.168.0.20]
 (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
 by smtp.gmail.com with ESMTPSA id
 p15-20020ac24ecf000000b0049adf925d00sm1882779lfr.1.2022.11.08.10.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Nov 2022 10:08:40 -0800 (PST)
Message-ID: <c28e0c1e-3aba-7c80-baa5-7f8925dea7c8@linaro.org>
Date: Tue, 8 Nov 2022 19:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 4/4] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Content-Language: en-US
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, vkoul@kernel.org,
 agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
 broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
 srinivas.kandagatla@linaro.org, dianders@chromium.org, swboyd@chromium.org,
 judyhsiao@chromium.org, alsa-devel@alsa-project.org,
 quic_rjendra@quicinc.com, konrad.dybcio@somainline.org, mka@chromium.org
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
 <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
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

On 08/11/2022 15:46, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree, as it is not
> appropriately described in text file.
> Update some of the properties description with minimum and maximum range.
> Update secondary node info which is used to describe slave devices.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

