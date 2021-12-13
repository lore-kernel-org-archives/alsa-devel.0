Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D17C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 20:37:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46CA618E3;
	Mon, 13 Dec 2021 21:36:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46CA618E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639427818;
	bh=gS/RNApcC4BZZks6Xl3YIoFGXyInKgTQ24NDsEKE8uQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IIkIE3iAB6rslZt+rnaceuX6paBELRFmaPzKUcO2BvnixygmhUsrt6hN1GtT4886v
	 5rCkkNpsYNZkeqJ4sXxW+Sg/8uT7wweeB13Ba2dKmUEiZe4dnxgZfZGbW3VNaznCJe
	 2oVZRKkzAV1J+aO/FjhaEeEaj2x/l5mZCAaWptcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9B6CF8027C;
	Mon, 13 Dec 2021 21:35:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C83C3F802E8; Mon, 13 Dec 2021 21:35:51 +0100 (CET)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87F35F80161
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 21:35:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87F35F80161
Received: by mail-oi1-f173.google.com with SMTP id s139so24659424oie.13
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 12:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AxSFGAofOwMIAYDCCLSObSduTWGbW1+gxYdw/nwgbn8=;
 b=Rbfis15aqKCEAZP9M6OtVTeV6FOjfjnGGMHbd/k6rapl2YQz1rDkvExPllvEGqW59F
 PkugM8CCNW9Cc4VTc5WJ9hXZCAnYilMKoM+i0lKEWylpBUH9yfxqruAE1Aqfo9jDisn5
 l9KXPJRsW6SkVFkltQzMbWQEQ/N7naIdCNA4EBoxV/N+hQiLDhrSLsGcNYhX/ErInXLx
 6TXm4Rwx7DASO2OoS+nIO/RAZD7wDKTC8wtLifRKyLjRezw9LI2lXwEM/miuZmHL6X3M
 TqoHNWO7u4+wQkC5uCL44tafuvf7kCQPvYIE/J69cbC2aSzZ34EbNFN3XILPP9XomfUc
 M16g==
X-Gm-Message-State: AOAM5336fs0IRL21qqf3xAVtKwfFGfsOY5TS44oaRUu7G/c2CChkcDZY
 w7x8AAMxn/AVxnc7H6VrwA==
X-Google-Smtp-Source: ABdhPJw7qa4AuHZj7EbN/+1qNf7EXChlDMQ/Ktbo40SMyKH7L4Hvz/la/8EklTYV0aHyX/NY6RRJLA==
X-Received: by 2002:a05:6808:1311:: with SMTP id
 y17mr843858oiv.32.1639427743733; 
 Mon, 13 Dec 2021 12:35:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id a16sm2338828otj.79.2021.12.13.12.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 12:35:43 -0800 (PST)
Received: (nullmailer pid 1526832 invoked by uid 1000);
 Mon, 13 Dec 2021 20:35:42 -0000
Date: Mon, 13 Dec 2021 14:35:42 -0600
From: Rob Herring <robh@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: Rename tlv320aic31xx-micbias as
 tlv320aic31xx
Message-ID: <YbeunvMNmyDxGrLb@robh.at.kernel.org>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <20211203134930.128703-2-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203134930.128703-2-ariel.dalessandro@collabora.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, tony@atomide.com, shengjiu.wang@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, nicoleotsuka@gmail.com,
 linux-omap@vger.kernel.org, broonie@kernel.org, bcousson@baylibre.com,
 michael@amarulasolutions.com, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, 03 Dec 2021 10:49:27 -0300, Ariel D'Alessandro wrote:
> Let's use a more generic name, so other definitions for tlv320aic31xx
> can be included.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic31xx.txt          | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts                     | 2 +-
>  include/dt-bindings/sound/tlv320aic31xx-micbias.h        | 9 ---------
>  include/dt-bindings/sound/tlv320aic31xx.h                | 9 +++++++++
>  sound/soc/codecs/tlv320aic31xx.c                         | 2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)
>  delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
>  create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h
> 

Acked-by: Rob Herring <robh@kernel.org>
