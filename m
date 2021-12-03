Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCFCC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 10:35:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 223D6209B;
	Fri,  3 Dec 2021 11:34:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 223D6209B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638527746;
	bh=m/JbckFCoi6y74GV2wg6e8/1A7a6USW8v6KZi01Jpew=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QEmp6CBUdCEiZ/Op7gv+SGmaw7tZRrNc9hX/zG9JM52rFTwQ94iKF1uc0DCrEdIRA
	 0u4s8uCWsONV5G3J7sMJh2xpk0MQWnfASNHOsbF1dDg1JN8ty5uvsYOmo+qORvjGkZ
	 Orun8Z2h8piYaUlkbd6iFiFpxQNG4RNttU6Ik6f8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DD2BF800D3;
	Fri,  3 Dec 2021 11:34:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B82D8F80246; Fri,  3 Dec 2021 11:34:53 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EA33F800D3
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 11:34:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EA33F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uXuxTTbt"
Received: by mail-wm1-x333.google.com with SMTP id
 i8-20020a7bc948000000b0030db7b70b6bso4489608wml.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2021 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n+Dus3eHmtLufPbm4SvZ5gg6kEi5fp5P2DSRbOjthl8=;
 b=uXuxTTbtb1pN1Bppn4P4bzToqQCL0jT41EcDem7jrDSh1wJMTvb6ZpJAsn1fMwQdfC
 VPNpuh05dOaHSi35Bhr3i1B6t2zjDgWjWScVacdHFne5KzH+pdZKIBt2TfjUmGLQb9QF
 DZ/WH9CZy98FKZ/ma1jHWueRlGBnNVUDkggbuvyc5cKGzjsssRE36RAgGdVEn11oxsrx
 rYewZPbOI33v8gfkXIi7CPxzlFoRNB9xJ6hWeahuUrD6pDW3IoDg+UwuBwNrjF8P5b6S
 C4aTgJVkUW5uwMU+d7o4gXXoRGH3eYAQNojRVcf/4ON69b0Vd5l51k0fKO3+o4qxFR67
 km5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n+Dus3eHmtLufPbm4SvZ5gg6kEi5fp5P2DSRbOjthl8=;
 b=NBKlruIu9s8YxDiNtsYvAZ+5kS1E5tQ9vj44xJ/Yo+5ZjdV2lH0bFDNCR8kanDYzrB
 0viqm+Tulx8IcIp9zKtO5QvGGVXbM+dvFWHv6JfGn9W+dgmbbTAkMJdjaNsI8B6ukzLT
 5LDtUmxvdFRr6R/DG+RrhKCgnHRFUlJy9Ipdbv4fdOLuV1W9D+x/o8vXJcuhie/D1x4K
 0lYQv/GzYxPmbzaBYc+kjjAdlDrDUUonqVu8VABpbxshIzex0UmMSZnQbIjAxucSMENA
 gGZkBabngiEWsNUSl5CkQ5xwqYenZu2/XzJgcjj3TzIKEzga0ERJ6oQRFWRNfDO2PtwJ
 wp7w==
X-Gm-Message-State: AOAM530HLKF3rfDx2qqiICVY1HqjId7uy+zolPT5/VHUUcE0jo6b8BRl
 8pmq1SDqPguPLQn/rgzN3aRRqg==
X-Google-Smtp-Source: ABdhPJw1oCGhQfauYMuvEYvwt9fqxymm+tx/pLU4hWhduokdPxXKS+1uo5bUH/HJIh+mk4s3NC6y7g==
X-Received: by 2002:a05:600c:6022:: with SMTP id
 az34mr14086321wmb.22.1638527685467; 
 Fri, 03 Dec 2021 02:34:45 -0800 (PST)
Received: from [192.168.86.34]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id g198sm2321262wme.23.2021.12.03.02.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 02:34:45 -0800 (PST)
Subject: Re: [PATCH 0/5] ASoC: qcom: apq8016_sbc: Allow routing audio through
 QDSP6
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
References: <20211202145505.58852-1-stephan@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d8fd4999-0ecf-dd8b-ee4e-094063e941bb@linaro.org>
Date: Fri, 3 Dec 2021 10:34:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202145505.58852-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
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

Hi Stephan,

On 02/12/2021 14:55, Stephan Gerhold wrote:
> This series makes it possible to route audio through the combined
> audio/modem DSP on MSM8916/APQ8016 devices instead of bypassing it using
> the LPASS drivers. This is necessary to support certain functionality such
> as voice call audio. See PATCH 4/5 for details.
> 
> Also, qcom,apq8016-sbc.txt is converted to DT schema by adding it to the
> existing qcom,sm8250.yaml. The bindings are similar enough that it is easier
> to share a single schema instead of duplicating everything into multiple ones.

Yes this is really a good start, we should at some point in time move to 
a common yaml file, currently most of the dsp based dt-bindings very 
simillar, except some codec specific routings.


> 
> Stephan Gerhold (5):
>    ASoC: dt-bindings: qcom: sm8250: Drop redundant MultiMedia routes
>    ASoC: dt-bindings: qcom: sm8250: Document "aux-devs"
>    ASoC: dt-bindings: qcom: apq8016-sbc: Move to qcom,sm8250 DT schema
>    ASoC: dt-bindings: qcom: Document qcom,msm8916-qdsp6-sndcard
>      compatible
>    ASoC: qcom: apq8016_sbc: Allow routing audio through QDSP6
> 


--srini
>   .../bindings/sound/qcom,apq8016-sbc.txt       |  96 -------------
>   .../bindings/sound/qcom,sm8250.yaml           | 136 +++++++++++++++++-
>   sound/soc/qcom/apq8016_sbc.c                  | 134 ++++++++++++++++-
>   3 files changed, 259 insertions(+), 107 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> 
