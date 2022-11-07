Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECB1C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 15:04:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 765B51DD;
	Mon,  7 Nov 2022 16:04:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 765B51DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667833496;
	bh=V0qOKLVqwT0TO4wugNOAzBu4/q8N+6mNvCQk7GyELPk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E286HS3/D6pwd0TLlrN8cz7xw9R5kxU96FiuXPguBeZHWWoNUlcRmJuaSw399cpww
	 YWrxesaOU0Qc0adyUJLSt0wiXS7UamTRlQiyR2RsCn8eUogGR8iRDoSZdUJ54Iw6yg
	 luwbQ+F+gSdjJQB254dqabxu08PLIbiVIDGtmrbQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33DF7F800EC;
	Mon,  7 Nov 2022 16:04:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F8F7F800AE; Mon,  7 Nov 2022 16:04:04 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29047F800AE
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 16:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29047F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ABMi7gpa"
Received: by mail-lf1-x12c.google.com with SMTP id g12so17137606lfh.3
 for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2022 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5cqfO9vASlyV1UQ/Ymj1gXHUZKIE6uTQs8zVm2OS0g=;
 b=ABMi7gpaZVTAukaw/B77ZaYTM4PQVevR8kKr1nU9K4X++l13EbJhVlgU7PHLsi2qM3
 N/qL452zRKmaOU/WbFpspe3Zm3J2MQP9pxzBAFH2bkyXe+Ig08aw17weJ3kYpvD12aBk
 uiK/nD15Bk0yhAwt4tF9FyPb0lEDvgf/yRApUJqDRzOD05r3+uhsqYvXQA2sGaKhAvwz
 sbbZxXc61tY1HYsMOuwhX7e9BFOk6NofwvNR9apE/Nz2g52B8yQnVZDZagcv0+sD1dFj
 F25Xcx38iJU9LwhzHq45KMbzXpAPYJ3ZEQU9InHvpZO8NsLhkURjIKtewRDXbiHlMIUe
 AqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5cqfO9vASlyV1UQ/Ymj1gXHUZKIE6uTQs8zVm2OS0g=;
 b=2dsuAs7W1uvT07FYwQ57UaKDGS9ayv5t1Cin+ntgECPP+rvbbFToit8+qDz9MshBJ+
 p/zmIv4tCOi6L9kiDKRlpoohayCk0xq3XqaFquLDueen6mLnBZ3xpTnMT41z71gIw12t
 nJ/xB5S9fxDQWa46mfPiSo0gbzb2LVhsAXE+127r13Yqa68rrnWtYCpxLVSDxehLrGja
 Lph1FemRZhQS2xx+eexgbCJdxKE0y93e2Jq7hOEyJ5LyVxUadj7ik/QYjHr28X78KPL3
 RTtZxz+/0c18Cabwe9Vk6ayZ9/CI7QCs66xF7a/XzIpvZgNAV54NYYyu97/ve5g5TVcQ
 dh/w==
X-Gm-Message-State: ACrzQf1AnOAfIanaEwb96Q6ujmvM9Q1oVXBAEyzTk8q01mwQ1wt+Rl+w
 pbyjmP1NNx/678fg9SyAXKnuCQ==
X-Google-Smtp-Source: AMsMyM4wGYjZBicYju8APQdvIo86aRDOkUKW+W36UmLcDJ2UOsVG1nnMwIluDHwG4hCvF4MiB0U8Dg==
X-Received: by 2002:a05:6512:298e:b0:4a2:9ffd:d084 with SMTP id
 du14-20020a056512298e00b004a29ffdd084mr17142217lfb.449.1667833435023; 
 Mon, 07 Nov 2022 07:03:55 -0800 (PST)
Received: from [192.168.0.20]
 (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a056512208700b004b18830af7asm1277912lfr.54.2022.11.07.07.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Nov 2022 07:03:54 -0800 (PST)
Message-ID: <03994d2e-261a-5ca1-36ca-b9380fe4085b@linaro.org>
Date: Mon, 7 Nov 2022 16:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Remove redundant soundwire
 property
Content-Language: en-US
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, vkoul@kernel.org,
 agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
 broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
 srinivas.kandagatla@linaro.org, dianders@chromium.org, swboyd@chromium.org,
 judyhsiao@chromium.org, alsa-devel@alsa-project.org,
 quic_rjendra@quicinc.com, konrad.dybcio@somainline.org, mka@chromium.org
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
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

On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
> Remove redundant property qcom,port-offset in soundwire

redundant and undocumented property

> controller nodes.
> This patch is required to avoid dtbs_check errors with
> qcom,soundwie.yaml
> 
> Fixes: 12ef689f09ab ("arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs")
> Fixes: 24f52ef0c4bf ("arm64: dts: qcom: sm8250: Add nodes for tx and rx macros with soundwire masters")

These should be two separate commits.


Best regards,
Krzysztof

