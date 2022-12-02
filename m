Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18646C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Dec 2022 00:11:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2431F17C6;
	Fri,  2 Dec 2022 01:10:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2431F17C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669939899;
	bh=maN3HmSwTnxT3kLD8fUrziroAS+4tYBWZBHKqsMkMSc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SRREqeFgxrJ+/eYq9Ap2T4W8Nd1wceY0NUiNVZfND47k+n8Q5p4Agvm9MXBMSwii9
	 t0c5vJFPyMc4yqtdYNseq04GKPRGwa8FdigPLSSEvR3Ej//+g0cmASGMxGs6VTz46r
	 YTJ9nTjroOTID/ArVH+nZ+QGZSgg17LyEtJfyNZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6DC7F80166;
	Fri,  2 Dec 2022 01:10:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D39AF80162; Fri,  2 Dec 2022 01:10:47 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98DB1F80162
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2022 01:10:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98DB1F80162
Received: by mail-ot1-f49.google.com with SMTP id
 p8-20020a056830130800b0066bb73cf3bcso2004575otq.11
 for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2022 16:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwV47pF0x8U7rd7NR79rNEXGsagQJIpvbm5W5UmYny0=;
 b=crtLQwJzqWSBPjsz7pXV38+3IauNQ99CGnkRnAW+jyRMQuhtkjl6DTe66Z2PXADwEZ
 v1dQT/BqH/Qq5z+JnoWXf/ekF4s1yB5dhmb+yS0oaJTA7y0U5vv2LGWvuxhu1maa+W1z
 ZhzwMamhhSTueteS0FUfM1tMUCypxZqyLG2O+TJ20BS6oet7k+2DBatecSsqnHYUGTb9
 pl8LYHFdctpV6KBEWgb+cXwVNsCjV4S9iL+QGKslwX52jJdX2NbQDK9ZibwyNqpK3VCl
 xbeeJUJC5BBh9vhLFpaquLI5wBG2n8bVboYpQ/SRdQoXnZfkXkIKN4/gyBFtrc36hZD0
 YZVQ==
X-Gm-Message-State: ANoB5pn/E6FRoSN2//uVUvWtEmnMSOCkZj7wuP6xBlg85/27RmszR0gi
 Pjaci7Ol3Jdx7bSF1eZYZw==
X-Google-Smtp-Source: AA0mqf7AEpmA2qWD6lE5NIau1JNEjmDdHQY0KFYIoW3nQGe/ogvO3xevqCCrDzz9W+3Ftf1ypOHr4A==
X-Received: by 2002:a9d:2aa:0:b0:66c:44be:cf1d with SMTP id
 39-20020a9d02aa000000b0066c44becf1dmr23953181otl.267.1669939839576; 
 Thu, 01 Dec 2022 16:10:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 v188-20020a4a7cc5000000b004a066f9a7b4sm2311577ooc.34.2022.12.01.16.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 16:10:39 -0800 (PST)
Received: (nullmailer pid 1740146 invoked by uid 1000);
 Fri, 02 Dec 2022 00:10:38 -0000
Date: Thu, 1 Dec 2022 18:10:38 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: apr: document generic qcom,apr
 compatible
Message-ID: <166993983796.1740107.16144015318255344818.robh@kernel.org>
References: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@quicinc.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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


On Thu, 01 Dec 2022 14:36:37 +0100, Krzysztof Kozlowski wrote:
> Document the qcom,apr compatible, used by Qualcomm Asynchronous Packet
> Router driver.  There are no upstream DTSes using this compatible -
> instead we have ones with APRv2 (qcom,apr-v2).  The driver does not make
> distinction between both compatibles, which raises the question whether
> the compatible is really needed.  Document it (as compatible with v2)
> for completeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
