Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD36C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Dec 2021 21:16:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE4CD1FCB;
	Fri, 10 Dec 2021 22:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE4CD1FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639171001;
	bh=0fZqNImgM/m7nQZmSHJpLvAgLq7dYU0BfiqtoA1oa90=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QR0LvLnycOuHdOAmL7gg4SQT/OtIzMVBCZJpRHcwG37aSQFEvcS1j+HCzrJXzwKJs
	 SPevlq4ZeKwqcTMevOPCHj53Rz3mYT82I4up/9A3smO5vy32R4FK9n/N/ZcB7hFlEp
	 nyGQ1k5opSwBwnGu0NtHCS39i2cAkuDcUAjmOdv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EF21F804E6;
	Fri, 10 Dec 2021 22:15:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFA7DF804E5; Fri, 10 Dec 2021 22:15:49 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39280F804E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2021 22:15:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39280F804E5
Received: by mail-ot1-f45.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so10915110otl.3
 for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2021 13:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rz+f4jxcorJhG5xhkcaE/Z8zmcaXPwrM4bIXAQx1u7s=;
 b=jOY9Z74yIv9Vy52dl/WiHcHHKb2otsTHTRyoJIu2QTaxvbJLxaC8SFt60mutrkgYmG
 CnVacveKCsYg6ZdSqCD9yVo/H8LIcSUuCHgxIzVK2PAkWMp7T/jgiyCJ0wrCVsAxRUt0
 nwnZZ9jFNJcauCI94JBuit1Va73lO8sWv2uefRcBg1AkkK4NMVWy6rKvajS/wFdoiJi8
 pAS6nJNrMTL5j1QsYvi3qPjAX/+lFoogaPmqwefOeJZvYUklA2lo83aXPQImtPOMe+Hb
 Y+VpMX9uWxoQ3hHWy6cFGHaxJ7VjxazhlNHxQoPD13E9a2ND5I7DGZLCLzlW9/yBEPmG
 Jm4A==
X-Gm-Message-State: AOAM531cREUzS4iZUhi7ivMNTNra9PeYZBWAJWrlFe8JmE+PXHM1dAcQ
 LcT1/UHCVkM86PtMQ1IjOw==
X-Google-Smtp-Source: ABdhPJyF0GaaJsZV1wR3zOSFn48M6x1bOCOHkCw6T0wcpl8sQFfIcxANMa3TuO+iZUTD231D2SKtUA==
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr12956753oto.312.1639170940576; 
 Fri, 10 Dec 2021 13:15:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id o10sm718190oom.32.2021.12.10.13.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 13:15:39 -0800 (PST)
Received: (nullmailer pid 1911427 invoked by uid 1000);
 Fri, 10 Dec 2021 21:15:38 -0000
Date: Fri, 10 Dec 2021 15:15:38 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: pinctrl: qcom: Update lpass lpi file
 name to SoC specific
Message-ID: <YbPDesOMfpoiQFIa@robh.at.kernel.org>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638891339-21806-2-git-send-email-quic_srivasam@quicinc.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, agross@kernel.org, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 rohitkr@codeaurora.org, swboyd@chromium.org,
 Venkata Prasad Potturu <quic_potturu@quicinc.com>, judyhsiao@chromium.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
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

On Tue, 07 Dec 2021 21:05:35 +0530, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 ---------------------
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++++++++++++
>  2 files changed, 130 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
