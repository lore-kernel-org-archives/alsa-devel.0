Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34EAC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 14:56:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FF74169B;
	Wed, 16 Nov 2022 15:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FF74169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668610596;
	bh=Nr+ExLIp+x+cW5C6ZvkuaBkU6fzvsXWbHbEhHJQYLTY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krCeUPajFvDTtHvPatIhFWaWwUVU5BergvaH3z3UutGQwc/d49mmLlR6atZlOjaIJ
	 zxFTyqMk8lhNP4xXKldpaos34exSlMslaU8UJY0GWYkB9+V5xZ1QKM9giRsmWnYS29
	 8fqmKKhh2Ff5AzneASD49mDm7GNifNKL1u+VsdoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 650D1F80240;
	Wed, 16 Nov 2022 15:55:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6B21F8032D; Wed, 16 Nov 2022 15:55:38 +0100 (CET)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58269F80238
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 15:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58269F80238
Received: by mail-oi1-f175.google.com with SMTP id s206so18753014oie.3
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 06:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7k52RsIpzmIjTbZWyy00dgymBBcd65eObrR5Yxdag1M=;
 b=SjDjd1yqMXZuIvVogQVwboysjTHjnPGCrxDGlBjeXwK11O96T1JNqXQ+91EJWUT3dL
 j0mwaz2QR/mt+cqI6a+paeqBHIr4TbaLgloR1oqNI7k7XGFpzptBC1NTC0P+nJq297BX
 8klQ4++30fkxriKt2RgK1BgUXVcMS+N8Rc0LbHSdZI1ZPVPeU0/wAZzwUitF5/BLc45M
 HcR6Cdn6pb32Q/nVNnxdDJHdqeibzXoXSxtcHcepVv5cj1xZyvWmhCol4IaMUxxYLt4/
 QfLKPZngRJgj+keKCLv8cw7Fp2w75xBj4c0MU971HRT3jbkpp2A/VoT12v7vPTgxczhC
 UPyg==
X-Gm-Message-State: ANoB5pmMhW6Cq2gbZoXH9lMZhhiHGixx2Kmdk5VYzC3BU8h31V1coNXg
 7lqGs3H98cN/0jNm7Md27Q==
X-Google-Smtp-Source: AA0mqf4m1imWn+Vx90xbRU3LajAp2Wwgdv5+qbG6dWiLmAoZvRNxUkQS+t7NODLtlefTWzNnPKfKcQ==
X-Received: by 2002:aca:e082:0:b0:35a:4069:85d8 with SMTP id
 x124-20020acae082000000b0035a406985d8mr1821869oig.101.1668610534178; 
 Wed, 16 Nov 2022 06:55:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 n10-20020a4ac70a000000b0049f07909c5fsm6141421ooq.3.2022.11.16.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 06:55:33 -0800 (PST)
Received: (nullmailer pid 3837304 invoked by uid 1000);
 Wed, 16 Nov 2022 14:55:35 -0000
Date: Wed, 16 Nov 2022 08:55:35 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 09/11] ASoC: dt-bindings: qcom,q6core: Split to
 separate schema
Message-ID: <166861053490.3837248.6746478589858183717.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-10-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@quicinc.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, quic_plai@quicinc.com,
 quic_srivasam@quicinc.com
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


On Tue, 15 Nov 2022 13:02:33 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the
> Q6Core service to its own binding.  Previously the compatible was
> documented in qcom,apr.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/sound/qcom,q6core.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
