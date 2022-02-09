Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B732C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Feb 2022 20:59:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45821182F;
	Wed,  9 Feb 2022 21:58:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45821182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644440354;
	bh=3gaGMZVmhxO1CHZH8oNweoq+w3e1mBCk/S2mkHwIzf0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sE0nMT7OlclZ18KG5fm+mhy4B9knE0p907FHDb4MruASaUtZ3GAx0osZLY3+rk/C8
	 tglgT8vqc7D2k/epxEgl24WUQ17XULCaEv7to26LuzG5To1oHJs/AEshQHA/BfBxmP
	 H/XlSxGCtXouytpfqilVoZlGOnHFKxTnTOAwAR0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D37AFF8014B;
	Wed,  9 Feb 2022 21:58:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3165F800A7; Wed,  9 Feb 2022 21:58:18 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A6EDF800A7
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 21:58:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A6EDF800A7
Received: by mail-oi1-f181.google.com with SMTP id 4so3795719oil.11
 for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2022 12:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yJbJ1YJncw7GR81NBwWGi/0xmX4tLs/aU6JSWmE8Y50=;
 b=aNr5fry+Nlvg405cMfbv20vkjA7XVIlpmYC+X2ze4IJ2vUn2GUy+AzuiVhktxk7aTS
 EUTCOtXhpMWRrXE5DHkL+8gJoenSw4gycdOw/pDwDn+vylkAmFvREhJ8pNQD9Zj67Foc
 MTeGcWGL4r2o0pJGPc4AJw4O13Ta5ldOea2bTbp+vEUzUU46OF1E2Jn5tDIxp0dU02Xg
 Ic2VL/8+JycJtaOSDd6u/7I9ZQlgQ/1aGCvteJZnZA82PhnHKP9S0nWO4kkwVlKT2WsJ
 4Zdp3g7kFYW2NIPUb105dCI7LoASD/OpSKejpSIosF/RPoRnL261g4201EAALo6VsJEK
 ovfw==
X-Gm-Message-State: AOAM533JzHISgOvpdSpaHpYT66JFfzAP0FN5Q6Bhx7+au6WI+izCpstU
 6ixfnvk9MreX1KmiGkp/jQ==
X-Google-Smtp-Source: ABdhPJy4whN1YYgUQxomCEjxG6vJxuxOYFro1PwIbxbRZKFts+Ytkv8xvy29NkqgrVlSMEwIWA1KFQ==
X-Received: by 2002:aca:1001:: with SMTP id 1mr1865078oiq.82.1644440290551;
 Wed, 09 Feb 2022 12:58:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id 4sm7390761oon.21.2022.02.09.12.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 12:58:09 -0800 (PST)
Received: (nullmailer pid 897131 invoked by uid 1000);
 Wed, 09 Feb 2022 20:58:09 -0000
Date: Wed, 9 Feb 2022 14:58:09 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/6] ASoC: dt-bindings: samsung,aries-wm8994: require
 sound-dai property
Message-ID: <YgQq4fFnNUU/NL1z@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122357.45545-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122357.45545-2-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 13:23:52 +0100, Krzysztof Kozlowski wrote:
> The cpu and codec nodes must provide sound-dai property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
