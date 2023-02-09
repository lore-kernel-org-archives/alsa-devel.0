Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7913BC61DA4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 18:04:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1DD7AEA;
	Thu,  9 Feb 2023 19:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1DD7AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675965868;
	bh=KI9Rl8JQy4bt3NwZnh2ZdfZI55LeXrm8NmE5OXZ4fRA=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iDmgwPWCTrlkWVbXlJmOfhRS+Fuc026/wr9tDuLIjARr18vkX/2aW5E65/U/9pnqm
	 nEB+3wnEkGZ/ZxKYdZxoolMROrvBz6ga8aBl7YcLusnJSiRkof9EIGtv2I99Pra5cQ
	 MU9IodN0f5RGGVge5U0ja19M2betd+yLcHPymx2Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10543F80027;
	Thu,  9 Feb 2023 19:03:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3E07F8021D; Thu,  9 Feb 2023 19:03:26 +0100 (CET)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B06BEF80027
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 19:03:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B06BEF80027
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-169ba826189so3617639fac.2
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Feb 2023 10:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el29K1onL5teh/SyUVO3DFE6M+GR2+jlsIc+fzWBWGc=;
        b=LFFtX5H3geu0JOYdFk+nK7j8nHIBjJZSMLnmwJR+G9ib0xurNLWsoz4oVN3J2wapF/
         4Y7SQOd+QtZXKMxZUtapVaP7fJ5jowQFIgMSf11BYr95lx5v2VPX1Ba62k2vv1ufFGqA
         1aSHu4bWTEEmYnKSN0Q9JLsEcEIyjOekEKb1jw8Uz5j/GNGOrodjisgsjMHGZG6aVGqD
         qCNh1XB8OgDjcHMgcoWWUWRdgtwPvaJQwmIG2lf1FZLmWaicMgnDlwRgQdqNMWnZQ2J/
         +i6oFkXZfLepDR8+lPmyqvS/OgmqR6HBm4TS2wVF8QufAPGUwBEUPSrDjaEdDhSlp17L
         IJEQ==
X-Gm-Message-State: AO0yUKUxJA2VjQn6qn3zl4BXAz8vsWqm9ohT/2MwbeEfOEgP8ysjPjqB
	0b6sMisVbeGw/ODQTedWyg==
X-Google-Smtp-Source: 
 AK7set8WUgE0NQMjMBaBstBG0JR+aa8X4O/nx8En9XwR7htZ7gJVD3rGgSEa0Fj21MeQn+9Yn3NV3g==
X-Received: by 2002:a05:6870:ac0c:b0:163:b8fe:1e5e with SMTP id
 kw12-20020a056870ac0c00b00163b8fe1e5emr6546220oab.6.1675965798635;
        Thu, 09 Feb 2023 10:03:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 n2-20020a056870844200b0010c727a3c79sm205619oak.26.2023.02.09.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:03:18 -0800 (PST)
Received: (nullmailer pid 575369 invoked by uid 1000);
	Thu, 09 Feb 2023 18:03:17 -0000
Date: Thu, 9 Feb 2023 12:03:17 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 7/7] dt-bindings: remoteproc: qcom,glink-edge: correct
 label description
Message-ID: <167596579699.575308.1762809433746364701.robh@kernel.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-7-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: NFJZJYVJSHMSCWKTGTD54JA3ML2WQH6S
X-Message-ID-Hash: NFJZJYVJSHMSCWKTGTD54JA3ML2WQH6S
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, Banajit Goswami <bgoswami@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NFJZJYVJSHMSCWKTGTD54JA3ML2WQH6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 08 Feb 2023 11:15:45 +0100, Krzysztof Kozlowski wrote:
> Correct the description of 'label' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  .../devicetree/bindings/remoteproc/qcom,glink-edge.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

