Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D57C10DCE
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:46:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D0B2070A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ejrd8dDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D0B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99CC886;
	Mon, 23 Mar 2020 20:45:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99CC886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584992758;
	bh=zCAtNtjRoPXx6JmeMN5UgZhqCNa1x6VPSrcDikr0X04=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ejrd8dDdRQ8pxHb8iMrpQ0nKW+0P/5mD9ZpUHfH5H/s0Q9tc3EOg+03n2BjQW5wOS
	 ZfDJZrbiozo/HSl5gAuFzR+L6demOfkD9lBaJ25yt/IIpSxaU28mizcgTM9wwlX0Lp
	 6BrsCAIN2VuzalOKra5G3mXDgrQBjDftaaK3UD+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BE94F80095;
	Mon, 23 Mar 2020 20:45:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0012F80158; Mon, 23 Mar 2020 20:45:06 +0100 (CET)
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07063F80095
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 20:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07063F80095
Received: by mail-io1-f66.google.com with SMTP id v3so15600191iot.11
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r9i5Yy99e3CgW0P8gaLcjQIhjCX66478/XRcWS3+S84=;
 b=Smnby2kyjG7chNbEG/GJs5CwktqpLuxp+exGuu+mqFCfUw7kV3fq98Wzq7hX10QAAJ
 wraTjHm48sWqQzzOz5Qg6rVerjKzTO8Sehrh7sqgzM4TWtSpkFT2CczDdOl3CO+uqwuq
 Xe2BPpEHTpF3I7UJB9psS/qrX5MoRfbroQmDvVPrvi536RtjZM+0jXTCNCAV9Bz6PDj8
 g6sD6C+syelWM68Y2i0jikwDAl7/mSsJnn73Lv99BRXnF+AeKD71LIHnnxR9LEcDKzAz
 6SJf4hcwnX6ZnKm15JAywR7gXsM8YdDagB67nFXRvel6rU+rFNjsuh0GEarkiovweSkp
 s8TQ==
X-Gm-Message-State: ANhLgQ2vq0mrRUxre8hLsPyU3wI+1+CaLMav+DEgdOZOWqEQn/8X4sAx
 dnrCtB2vyACNX/Vyo4tWYA==
X-Google-Smtp-Source: ADFU+vsAzTXBZGUBrZAQ1lAg1LZa7C8Eb/zL/ybcePG+EQHsuJFpa2ORV2x7aE10Xrh+Imf8iDK5Eg==
X-Received: by 2002:a05:6602:cf:: with SMTP id
 z15mr20497163ioe.13.1584992701381; 
 Mon, 23 Mar 2020 12:45:01 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id o23sm5554448ild.33.2020.03.23.12.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 12:45:00 -0700 (PDT)
Received: (nullmailer pid 21498 invoked by uid 1000);
 Mon, 23 Mar 2020 19:44:59 -0000
Date: Mon, 23 Mar 2020 13:44:59 -0600
From: Rob Herring <robh@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/6] dt-bindings: sound: Convert jz4740-i2s doc to YAML
Message-ID: <20200323194459.GA21444@bogus>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, od@zcrc.me,
 Zhou Yanjie <zhouyanjie@wanyeetech.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>, Mark Brown <broonie@kernel.org>
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

On Fri,  6 Mar 2020 23:29:26 +0100, Paul Cercueil wrote:
> Convert the textual binding documentation for the AIC (AC97/I2S
> Controller) of Ingenic SoCs to a YAML schema, and add the new compatible
> strings in the process.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/sound/ingenic,aic.yaml           | 92 +++++++++++++++++++
>  .../bindings/sound/ingenic,jz4740-i2s.txt     | 23 -----
>  2 files changed, 92 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ingenic,aic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
