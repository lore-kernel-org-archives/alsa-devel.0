Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F7C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Sep 2022 14:55:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EF8517EC;
	Tue, 13 Sep 2022 16:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EF8517EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663080905;
	bh=hc7p+GZAl48h1EzpWA5sdgv5XqJICZKh4e7uquFhD8o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OryS6eK/Dv97T9hHwKOeiwwP5dHVFy42qCSCC9WKprVMcwOrjgxP/1HZmrLEIoFab
	 xllquIZaFHeK0WWXvq0TR63/mQ/a1cI0445lIrTJ2AU5P6aoAZfV55MjhMQuM0gFfD
	 Fj/11SmEreTLM6bDVd6WJAuUL+y19yPMozZkqft8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A53ECF80538;
	Tue, 13 Sep 2022 16:54:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7428CF80538; Tue, 13 Sep 2022 16:54:10 +0200 (CEST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B11FF8008E
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2022 16:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B11FF8008E
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-127d10b4f19so32718872fac.9
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2022 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=YjuyOX0vuflNgkEmb8EuJtzXMVxJF9AgUE3KWZmCdSc=;
 b=tOr2U2+EM013tzu7UwexzKDxW1T/6U9+0/Qp3eQttvzGD+F0AJluTlPpo5+F8RM0EB
 AWg1ZmuyyQTlSFq+IWzrXh5IIsIbsjGC3ld9J3COudZRpJVdinrXRU7PgqVrmWq4Y5zQ
 SV06rkraqCrqdMqwLECD7ncU/EpuAPLM32B9UHhue9kykUV7EOsKPv2lF1xf43+fP8H/
 +qYhyOlMd5JboLYvtoUj/A/titjo/1c4gR2280iyevNUdc6au8Wc6hJUBSNEw0p6FNwi
 IWdpX8JrDElNv21jQLWF6SMq5SVlAo+6F8zO10VHPWZJeXsxlg8gySBlFDfkGucWLiPA
 eLFw==
X-Gm-Message-State: ACgBeo08cFdK2Jvwacu9DucO0Xkm7jzASO/DtFNjo/F475aLPdvI0gEI
 tpRiVzBHlHoLDhHamn/Tgg==
X-Google-Smtp-Source: AA6agR7LTlwKvsObOgPAOhlG9PGJU7XKt7gp8lgROdkzXmSWSVY5D0f6yfV4NXUehkSSAGuO5FL3UQ==
X-Received: by 2002:a05:6808:201b:b0:34f:80a8:6a2a with SMTP id
 q27-20020a056808201b00b0034f80a86a2amr1715116oiw.121.1663080842592; 
 Tue, 13 Sep 2022 07:54:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 bj8-20020a056808198800b0034fc91dbd7bsm1880962oib.58.2022.09.13.07.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Sep 2022 07:54:02 -0700 (PDT)
Received: (nullmailer pid 3658520 invoked by uid 1000);
 Tue, 13 Sep 2022 14:54:01 -0000
Date: Tue, 13 Sep 2022 09:54:01 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 14/15] ASoC: dt-bindings: qcom,q6apm-dai: adjust
 indentation in example
Message-ID: <20220913145401.GA3658488-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-15-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>
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

On Sat, 10 Sep 2022 11:14:27 +0200, Krzysztof Kozlowski wrote:
> Cleanup the example DTS by fixing indentation to 4-spaces and adding
> blank lines for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/sound/qcom,q6apm-dai.yaml   | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
