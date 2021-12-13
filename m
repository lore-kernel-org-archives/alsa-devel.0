Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5080FC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 20:24:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0804818B6;
	Mon, 13 Dec 2021 21:23:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0804818B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639427054;
	bh=rxPVBhPh5tlNhjWaqPc7a+jGRRfr7wdTzWh+EjkcTjE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XVKO0xXY8bxQKudnB2GD+ggTKXjdcPLj/41IbPp6Uvpgvcw1oc1M45DsuJakVVH1k
	 OMRYUUZZe7rhEXqbfVnsw3n1yvDm5gLIEpW501kLvslYIFV4j7H7f22YJhdiPh3M5y
	 /ZW4C012+l00Fib+xnmYuGgad30qjq/5D0DdkPwE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93BA3F80161;
	Mon, 13 Dec 2021 21:23:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBE14F8025D; Mon, 13 Dec 2021 21:23:22 +0100 (CET)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3CBCF80229
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 21:23:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3CBCF80229
Received: by mail-oi1-f180.google.com with SMTP id t23so24737465oiw.3
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 12:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KOzRGDuzgHP+LKpjr5HbH419deyjCZOrF7CtcnAeppM=;
 b=vQlHdo9W5Hvz3shUcNOBC39cDUNgEdXVQcO5TZiRBbkxOfc9Gb9Rp9kMDvcpmByoEv
 cYJlIhPoPOxYrt7ydlkw+5gehSclP2QnrutIApIgcBf25KH2WftqwYz28rwMsfVZS2L8
 XdLfALCri4B9/lZxbmdQkNmn7AdDbpDZJOGvGVZh1hH+53SCk0W/iDv+T/yQR/+fX2V5
 X5lql+RIgheP5GYb3BSKXT0oyBc5eBk/oZkmXXsoLJIKgxmOfOAa2/UpIN75eFPnRI9C
 TCwNli8mrZTWVVOyrsXl/OF2BnbIPyykA1w8S6Sc0CT5pGfLNvyN1w4cPUK7CBZxlWOe
 f1Zw==
X-Gm-Message-State: AOAM531NgyOI3VPl+PgCtILMZISQjL0/7m4sKIM+fWCjGesqUOzCqrOq
 B12YB03v9BrvgsGZhEoDNw==
X-Google-Smtp-Source: ABdhPJzUCaYQtXFGkfNZQS0VLaUxGOxkTq0hqkKHtdFQi05ubJ4+LZvxzTMd7+QA9zDhE98yynU/rA==
X-Received: by 2002:a05:6808:5c1:: with SMTP id
 d1mr29655537oij.141.1639426994075; 
 Mon, 13 Dec 2021 12:23:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id e4sm1421252oiy.12.2021.12.13.12.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 12:23:13 -0800 (PST)
Received: (nullmailer pid 1508142 invoked by uid 1000);
 Mon, 13 Dec 2021 20:23:11 -0000
Date: Mon, 13 Dec 2021 14:23:11 -0600
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 3/5] ASoC: dt-bindings: qcom: apq8016-sbc: Move to
 qcom,sm8250 DT schema
Message-ID: <YberrygvFWcGtV7L@robh.at.kernel.org>
References: <20211202145505.58852-1-stephan@gerhold.net>
 <20211202145505.58852-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202145505.58852-4-stephan@gerhold.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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

On Thu, 02 Dec 2021 15:55:03 +0100, Stephan Gerhold wrote:
> All the Qualcomm sound card drivers use the same common device tree
> parsing code, so the allowed device tree nodes are almost the same
> for all of them. Convert the qcom,apq8016-sbc-sndcard documentation
> to a DT schema by adding it to the existing qcom,sm8250 schema.
> 
> The only speciality of qcom,apq8016-sbc-sndcard is that it has memory
> resources for setting up an I/O mux. This can be handled using
> a conditional if statement that only requires it for the apq8016-sbc
> compatible.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Note: There will be a dtbs_check warning caused by this, because the
> recommended naming for nodes is different in this DT schema (-dai-link
> suffix). I will address this in a separate patch if this series is
> accepted, simply by changing apq8016-sbc.dts to the example added
> in this patch. The driver itself accepts any naming for those nodes.
> ---
>  .../bindings/sound/qcom,apq8016-sbc.txt       | 96 -------------------
>  .../bindings/sound/qcom,sm8250.yaml           | 83 +++++++++++++++-
>  2 files changed, 81 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
