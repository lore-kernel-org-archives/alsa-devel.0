Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BBAC4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 15:47:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6B33AEA;
	Wed, 29 Nov 2023 16:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6B33AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701272842;
	bh=GE/A8irx9ijSCPblQjbRbRok3+/ld8pEhAvHKMXvPNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KeGHoLp7i+QvLIc1b8x0t/R4p6xWd99JwcckQaIFVRSZtOarlLJCakdAhH3S3zn+5
	 cu1RCY0Y5juqQ+Zw8EZP/BtkqrTP+1RF59py7lopazL0uKM1VoUo4qr+KQ8h6lsBMH
	 +FFklyTHXaH83B3Ix0AXS4Fv7M6U43REdoCwsQ9U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA33CF805A0; Wed, 29 Nov 2023 16:46:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C66F6F80564;
	Wed, 29 Nov 2023 16:46:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5AF6F801D5; Wed, 29 Nov 2023 16:46:54 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA56FF80166
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 16:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA56FF80166
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-6ce2eaf7c2bso4117457a34.0
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Nov 2023 07:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272811; x=1701877611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ23N4x9xsyS+PdtjpIOJ1tiYnfSGNct1P34OTOLm2k=;
        b=otlFoGYYG0WpN7W0PwquS6mFc0PefGQ/GNcKli5pvkeDN38aL2o6ykTGWvixtPEVfV
         h8NRHeeaqIkIsdCLrb5OMF+iJzOOlSV5tFKlfZXGB/X/yKaJsETa3QBbTUFuqcPIGhGN
         Xpq/KnzQETBFQgK/JQAG4RrhaqeKgFAYsbG7SZTcFsQX+D94KvJBGpQlakQDru05Z+8x
         DZTMyahubClkDx/UwhZ+dNoSsu31y6y8BqLNSMrYqtvu6Y+4jK1YPpi946pp09h0+CKx
         jdGq8WA3n34CXcTgVR+02QVUZ5btmn8Tb+yePcoIVGKS9gWm70i26OYLLvj9FFFYf+Zn
         Fk2g==
X-Gm-Message-State: AOJu0YxT8wEseYwaCMwBBiTKsLHYUDUMY4RNAUGZ5A7PAGA5MZY430xC
	pte608ud14YAc+S87i+ruA==
X-Google-Smtp-Source: 
 AGHT+IH1cW5WeqpkTlob3Rn0FcoRYZoiNqB7GPItDNM4+VO90I/UqzXgHGRDuxBkDGTJ34CdR2GIPg==
X-Received: by 2002:a05:6830:34a9:b0:6d8:138a:dd8b with SMTP id
 c41-20020a05683034a900b006d8138add8bmr16934439otu.33.1701272810799;
        Wed, 29 Nov 2023 07:46:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 d22-20020a0568301b7600b006b87f593877sm2023303ote.37.2023.11.29.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:46:49 -0800 (PST)
Received: (nullmailer pid 2542152 invoked by uid 1000);
	Wed, 29 Nov 2023 15:46:48 -0000
Date: Wed, 29 Nov 2023 09:46:48 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650
 LPASS WSA
Message-ID: <170127280827.2542113.8003220554875038607.robh@kernel.org>
References: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
 <20231129113014.38837-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129113014.38837-4-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: 6RPCQIN76MV4W2AHPVJOLQR6RJR6GZQU
X-Message-ID-Hash: 6RPCQIN76MV4W2AHPVJOLQR6RJR6GZQU
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6RPCQIN76MV4W2AHPVJOLQR6RJR6GZQU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 29 Nov 2023 12:30:14 +0100, Krzysztof Kozlowski wrote:
> Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) WSA
> macro codec, which looks like compatible with earlier SM8550.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

