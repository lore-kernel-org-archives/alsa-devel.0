Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B37BC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Feb 2022 21:02:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40B3618AD;
	Wed,  9 Feb 2022 22:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40B3618AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644440520;
	bh=oQmJ6eTe0m5bOq09T5RTya4Ift4YxBDBNPUQpIqGcao=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLnoytxDFY6yS0ggz3sj0nWYkxLEmzPAvQWh2rrpitlI9G9zV9yZElSiIltU36JyK
	 gG5oM7rtBziVzZqgdhNseqZpauE1Vka8D7MptRoM68ALqlfkxQEVv+tmR4Ke/onW8L
	 WfL/xOXcoBTsh+2uVc4BeX08GC1CHLHCBkRskFFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1ABEF8014B;
	Wed,  9 Feb 2022 22:01:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ACE8F8016A; Wed,  9 Feb 2022 22:01:08 +0100 (CET)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1852F800A7
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 22:01:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1852F800A7
Received: by mail-oi1-f174.google.com with SMTP id u13so3841565oie.5
 for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2022 13:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qlhsBrk58d+PBEsXLf1Gub/eoly18zDY283TQ4/24uE=;
 b=bGmUhuX5wWeM0NrAX6Mp9Zq2BZTAW69Q28xmNRZhFLyHxB8RuASboOljtxP8oAQe/U
 soc7nL/dRn5JLSvhpj4c4NAKIOPM926wTdHfY6kg2s3NlZR7YlJzOgJHw/qJ0IdmLhhZ
 mZFlvoA6h/UM/h2WrklJSmJ7Q3mHqA/dPAPmVJT0dLe2TWV3C9b8XuumKLnHeos3XNp6
 2y7l7AGHSrTcYAunZNF0xPZ7snMmlB2D5Eh91jGLC8q54UP3ncRYi4QkMsROWSgdayk9
 MS7DVOpFKsPsQ1mbXDcfb3o5AJVlS9b7eA4KUcBhO9kzqPJ4vvy01CP5fl5gTVt9SQcY
 e7kA==
X-Gm-Message-State: AOAM530SqBudzObnLOIIOa8n/Ljz7h4KMcvFQBJIE/h7lx8Lm0gjaOJT
 PcEnkal4TvfDY/G1woj9eQ==
X-Google-Smtp-Source: ABdhPJwN9Iri/QtKQz+h7hiiBCG1hg4kn8lg+yCYP0VL97uHevl4I27jl5SQWVaVsOJvaAHd6lKzKQ==
X-Received: by 2002:a54:4785:: with SMTP id o5mr1897126oic.96.1644440463320;
 Wed, 09 Feb 2022 13:01:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id 11sm7377197oar.18.2022.02.09.13.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 13:01:02 -0800 (PST)
Received: (nullmailer pid 902113 invoked by uid 1000);
 Wed, 09 Feb 2022 21:01:01 -0000
Date: Wed, 9 Feb 2022 15:01:01 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 4/6] ASoC: dt-bindings: samsung,smdk5250: convert to
 dtschema
Message-ID: <YgQrjY3Ri9Kar9lq@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-3-krzysztof.kozlowski@canonical.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jonathan Bakker <xc-racer2@live.ca>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Sat, 29 Jan 2022 13:24:28 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on SMDK5250 boards with Samsung Exynos SoC to
> DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
>  .../bindings/sound/samsung,smdk5250.yaml      | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
