Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:22:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51462073E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gd5my8S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51462073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43C5715E5;
	Tue, 14 Jul 2020 04:22:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43C5715E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594693372;
	bh=G0iEwjdw5aEJ62RiyfLc6luWUQJ1iS+i8d65qsjwg8Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gd5my8S19oJ/uvRKFkWQ8/cPpI2GZskP77yqzdz6RPXqCqkH/b6ZJw8URsSeWQHpK
	 bjwfyWJf8DMOaUQ8tJUHLw+Wfop2NsjvA2FJa5lCGyHiUKWJHbFaBRSP+0ssnSdp0g
	 /qJ5TItlUgdLqJ1oGOWaNe4L2SIFnXv+/8m9Lm/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A2CFF8016F;
	Tue, 14 Jul 2020 04:22:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4B81F8019B; Tue, 14 Jul 2020 04:21:58 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6FEFF80113
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 04:21:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6FEFF80113
Received: by mail-il1-f194.google.com with SMTP id p15so5363391ilh.13
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 19:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V3FbKAVk6JJr3uR3Bza87ijOzpykZ/ht1Tqwf65b3KI=;
 b=LuB+ytRo9Cf6fPCPjcbIFdoDm22DwmsqnMtYLf4gU21t9zRghzVmdwNYSjsUep36ki
 T/KmzlrILgh733wtEvCmELIvT8135V+iFpxuG6rSU+rz63vRTiKXiEAilYbyhvonAsQR
 Ou4ArrCPZjDLbDXfLHZW5xa7+Ifb9KsDXR0svdSme84EGhUNZ3UnOnqzyFxO+MM1yIsN
 2dId7R4GnMUbYcXaDeV/LldNTrJCtaaoIiHQd0lsWXnkaV8Pos+i0BXwBXzxydtc+lj9
 xbCBNMAKNQ2pxP+onHcQtZWh0/FVK1StKGaIxECqwQP9AT826Gckp/dkdg6hzYRzgLTH
 OwGg==
X-Gm-Message-State: AOAM533weEKGlb+tIB5wzTyuk1Vj49WUTgD1ThCRmqORh+Ked0IQ8AZP
 nCkH0menZnk175QSaOdDBw==
X-Google-Smtp-Source: ABdhPJzNWhuGWWKx+6Cf5B07q0XeaVK35FXAFTq+PO3QiZ3qQJW25KSE03/NCtBcUoJnPLSKpkgQsg==
X-Received: by 2002:a92:5ecf:: with SMTP id f76mr2561312ilg.281.1594693310705; 
 Mon, 13 Jul 2020 19:21:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id w5sm9143558ilm.46.2020.07.13.19.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 19:21:50 -0700 (PDT)
Received: (nullmailer pid 1150001 invoked by uid 1000);
 Tue, 14 Jul 2020 02:21:48 -0000
Date: Mon, 13 Jul 2020 20:21:48 -0600
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier AIO audio system
 to json-schema
Message-ID: <20200714022148.GA1149971@bogus>
References: <20200623113915.791386-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623113915.791386-1-yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org, - <alsa-devel@alsa-project.org>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 23 Jun 2020 20:39:15 +0900, Masahiro Yamada wrote:
> Convert the UniPhier AIO audio system binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add schema for subnode 'port'
> 
>  .../sound/socionext,uniphier-aio.yaml         | 81 +++++++++++++++++++
>  .../bindings/sound/uniphier,aio.txt           | 45 -----------
>  2 files changed, 81 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
