Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A345C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:16:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A973C20814
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCmbWcMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A973C20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC24D17B4;
	Thu, 28 May 2020 16:15:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC24D17B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590675410;
	bh=5rkdDhvLnr0HQbP4/kDxx+h7aXgJ7zet0owDXLHQxJc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCmbWcMjlUiZGsbYZ5G1FkBcK1WD6WOp2x4adw/n1wZmyI90+WsSC/dTut1Z1FB7Y
	 2PIcHDXdqldf7D0d6rxFsNDwkRAtf4OlmwB72Tz9vE9avO9ZuJ6cCjr6/MfGNdwHC+
	 z6zstHO/bg4KWIzC9KdW3D+oyW+yTE5jOgDOQo1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 772F7F8014A;
	Thu, 28 May 2020 16:15:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBF31F80150; Thu, 28 May 2020 16:15:57 +0200 (CEST)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7825FF800E4
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 16:15:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7825FF800E4
Received: by mail-il1-f193.google.com with SMTP id v11so283864ilh.1
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 07:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Je+Wciu3uBC2CRy874Nn2/ScwzmE+3jA16l+4SU5qIk=;
 b=biqxxNtlUU3AlDoVWir3Fcb/gD532aPIhHEHuokpMlnkt2Kj/gP2INrP6GX92y2JzW
 st1qnaCIagBgS1q0XL1T8HFTb5AN+5sEzRbGyH44KI0y61bE07AySvGgEJrUze3hKZKM
 fEoN1seUfZ4WuefXg+pkJQB7NcfdIApJart7U3dvqzsWqxTT75urSYx06gmiZOKyCdmw
 vaJOYdj0u+5GSZ6b92JgvPdU4SMTndv4tHlLO1UbAVCZmu+oQQ2JMMA6fKMYMVKccARb
 Q6BbymQkPZzHIk/ItwU+EN4Bc9quZ1UWQtTSUy4oeM5bNNKZ1AdjGXRYmCcKdI7b6t3B
 Wz7Q==
X-Gm-Message-State: AOAM5307GX7As2eZN8rVaqnZOR6Yy/a86lS2ETzy/SOk+dL3W1Y34GV0
 A9Rv8sFkdLieas+2aC8/lw==
X-Google-Smtp-Source: ABdhPJxqgYgQsTnkwnSdGoqz/4f0E7HlZ7jvhwSGKnRTHkVRl/yC0BQTNyjlTd0+HmAG45bgvBjFLA==
X-Received: by 2002:a92:8c0d:: with SMTP id o13mr2892315ild.117.1590675344761; 
 Thu, 28 May 2020 07:15:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id q6sm3419232ill.59.2020.05.28.07.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:15:43 -0700 (PDT)
Received: (nullmailer pid 4186889 invoked by uid 1000);
 Thu, 28 May 2020 14:15:42 -0000
Date: Thu, 28 May 2020 08:15:42 -0600
From: Rob Herring <robh@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Message-ID: <20200528141542.GA4186430@bogus>
References: <20200528103755.17381-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528103755.17381-1-steves.lee@maximintegrated.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
 steves.lee.maxim@gmail.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org
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

On Thu, 28 May 2020 19:37:55 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/sound/maxim,max98390.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 22, column 97
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/sound/maxim,max98390.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/sound/maxim,max98390.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1299651

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

