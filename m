Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80168C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 21:10:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AE220663
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 21:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yer3tMpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AE220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BBFC1797;
	Thu, 28 May 2020 23:09:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BBFC1797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590700227;
	bh=8duFg10Z/WnUMgpUUomO+Cr+4XIVEyIf3Ff41CJuD3M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yer3tMpAzanlpcnQsRvR4s/D4wPVRi4An3v8rH/DttEqoN1B1kvolrorhoIJniTj6
	 ksKQ21kfUUsWCgZWBV5CRF2on8OWNwx7nw+0cmFDfl93UnHda0DScSNVvbRTNKaFDe
	 nEyNdP/sE+8FY3Pp4QV5CzhJ7wNCwbducDTwhRU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4E86F80107;
	Thu, 28 May 2020 23:09:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30505F80150; Thu, 28 May 2020 23:09:35 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C14DF80107
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 23:09:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C14DF80107
Received: by mail-io1-f68.google.com with SMTP id d5so3504ios.9
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 14:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KmIOS5+GLvB/B5GJpxQI/Z/o0HmmZcFrKSOs+Nw0Guc=;
 b=fh+AMVcR3Z6LZvIGiKM2Ws7+bp2FpvtnVImRbGbvpBkxQoj8Xb/5g5Hxn/fsiQW/hP
 dHwit3442PuA82MNo0mQAzsbbbI7+M3pRUpThaOzEqN9p7XuA5o561tnHiHTNQb8c81D
 SZ24hvBSGfcQjB4H8Fm/ewa6j2dk5wODzZLgriMVsfpjf32jaPCXWWNrgY2PnrriCyY/
 inLoh8OCc+t5rH93FyF2LzV5yAIhXyXrJyRBOPsymx53aDW1jtse7SbZbC1Nh+pKHGjK
 PENvg2+6QoAe2FXLJfspUhWnoA4QVcRaBT8Btkf+1P9Oqm1HgUr9TY/ROTVK/w+Jgkat
 xe+A==
X-Gm-Message-State: AOAM531KjER3Z8gIUkXjt27loLeU8rINfeil7uR3O4mUhzkcgDaggDNC
 aQF1HJgZ++ErWfPrGDiELA==
X-Google-Smtp-Source: ABdhPJwgg174nsCuH+GseZ1yw5yXHdsR4u58wuHIZZnGe+eA2BMeqn5nERsGpQqZuBRBeAM1t6iL9w==
X-Received: by 2002:a5d:8045:: with SMTP id b5mr3914065ior.16.1590700166890;
 Thu, 28 May 2020 14:09:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id s2sm3650740ilj.29.2020.05.28.14.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:09:26 -0700 (PDT)
Received: (nullmailer pid 688065 invoked by uid 1000);
 Thu, 28 May 2020 21:09:25 -0000
Date: Thu, 28 May 2020 15:09:25 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: fsi: Add missing properties to DT bindings
Message-ID: <20200528210925.GA687765@bogus>
References: <20200519075858.27869-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519075858.27869-1-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
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

On Tue, 19 May 2020 09:58:58 +0200, Geert Uytterhoeven wrote:
> make dtbs_check:
> 
>     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: sound@fe1f0000: '#sound-dai-cells', 'clocks', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fix this by documenting the missing properties.
> Update the example to match reality.
> While at it, improve the document title, and comment the various
> compatible values with the corresponding SoC names.
> 
> Fixes: 7f464532b05dadc8 ("dt-bindings: Add missing 'additionalProperties: false'")
> Fixes: 2f52475bac7e1572 ("ASoC: fsi: switch to yaml base Documentation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> For a clean "make dtbs_check", this depends on "ARM: dts: sh73a0: Add
> missing clocks to sound node"
> (http://lore.kernel.org/r/20200519075525.24742-1-geert+renesas@glider.be).
> ---
>  .../bindings/sound/renesas,fsi.yaml           | 29 +++++++++++++++----
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 

Applied, thanks!
