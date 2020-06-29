Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E8C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B2B206C3
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z4A0Heqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B2B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AD1C846;
	Tue, 30 Jun 2020 00:00:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AD1C846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593468105;
	bh=ksD8/YhOmPyxDpDhDWAW8V+BdGDwMP3O1CnBq8iX7BA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z4A0Heqih5nnR+rdIWxUMOXAktKPx8eiB/BxRKv4LsS1ZZ9aIegudxfXCChAcwK9l
	 ZqumRLGtpBYYlAbBO+aHrw317TJf1RHd2IIVERQWvfj+9AOCuLg+m7q9lXFy9C2nrR
	 9plIamZ6dm3jAxnC9nIq4RoZb6FhoX2NZh29o8xk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CA3AF80096;
	Tue, 30 Jun 2020 00:00:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68463F80217; Tue, 30 Jun 2020 00:00:51 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11CF9F800EA
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 00:00:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11CF9F800EA
Received: by mail-il1-f194.google.com with SMTP id s21so754847ilk.5
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 15:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XibhlPkg3VOTmV4eLtvatFLe5OTKIBnR1/3S5Ja9w/I=;
 b=UkAEpCHXyMQPo0u4VBcA8rqfMz860kew9MKgjMUJ1cMLFX07hPZOy7LqwZ+xOW5jDe
 XdOr5PTNJWuu4CXL6MXHG+h8G1b5boOyqK1CXC4n8QN9bjr+MGe+HVvIGVOkYEg8+lXQ
 hBg4zx+aHxuZ4V7xbMirahn1QBe+/Awtfm8zOioNj7rNsqdStwfDLq4CLC+1Cfc6YYCU
 LV97NK2LcC4nNeDpX3oXT9bX8Jix6EQcNMkw26Xtwm+zKIUjdN3psDZHB6p0wF0PC5MR
 948wqBtTeShrAhfthbeSvJAM7QhA2Ru7PMqlhUGxjtoEB5htXuED1G35u6mlI0uFh9UI
 MoYw==
X-Gm-Message-State: AOAM532LdxTueZ4UZqjZ+piHzL6FCxLriRUawWMoeL1uNywe9y9U623x
 ipcr45zDhXHZa+0Le/zp9w==
X-Google-Smtp-Source: ABdhPJw/3aWE5XK3CTeLWAvSAH1gjgTz2xAun9mWY7bxA0/ul+apY1Zq5c7rq/5DZCJLxWdy1hNz4Q==
X-Received: by 2002:a05:6e02:e43:: with SMTP id
 l3mr17582767ilk.11.1593468043226; 
 Mon, 29 Jun 2020 15:00:43 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
 by smtp.gmail.com with ESMTPSA id s190sm674589ilc.28.2020.06.29.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 15:00:42 -0700 (PDT)
Received: (nullmailer pid 3011558 invoked by uid 1000);
 Mon, 29 Jun 2020 22:00:40 -0000
Date: Mon, 29 Jun 2020 16:00:40 -0600
From: Rob Herring <robh@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH 1/2] dt-bindings: sound: convert rk3328 codec binding to
 yaml
Message-ID: <20200629220040.GA3011219@bogus>
References: <20200623124734.1736470-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623124734.1736470-1-katsuhiro@katsuster.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Tue, 23 Jun 2020 21:47:33 +0900, Katsuhiro Suzuki wrote:
> Just convert Rockchip rk3328 audio codec binding to DT schema.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../bindings/sound/rockchip,rk3328-codec.txt  | 28 ---------
>  .../bindings/sound/rockchip,rk3328-codec.yaml | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.example.dts:22.26-27 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1315234

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

