Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5BC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:17:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6320A206A2
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dx2j7jKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6320A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B301816A5;
	Wed, 22 Jan 2020 17:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B301816A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579709871;
	bh=hYPBvrWbwQp+qlZHR06/WSbUG5AiIaM9YXDgqntAtys=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dx2j7jKGEPwT8w7les9QtPTPXUsnXAmQhR4kKM8QeW3LjghIyJtszgIUvEIjnNFUg
	 O0hijMuHDOoI0fbU7b47ANgWcLRSpS+md8J8p2fi/qgyNew0szAFfPrGdwd89B2v0d
	 S2StXxisyyVDflAW46mtKWluXyl5fa1E+4auq6jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23AC2F8007E;
	Wed, 22 Jan 2020 17:17:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2030CF80229; Wed, 22 Jan 2020 17:16:59 +0100 (CET)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B12CF8007E
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 17:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B12CF8007E
Received: by mail-oi1-f196.google.com with SMTP id c16so6592687oic.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 08:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bCC1zL+bogHN+rvx2h4DBHY3FQpA25WkiSVB3OHN7QI=;
 b=iUpexIsm1mA6P0ACwV70+7YeNGKCJrIXi34ryOjU39uy34vwRnoNBezat7TJBul++n
 lCOQDlu8y0MkG0lgQCrPuLrCmgmJAaXLRdt7lrtbOvql66/+cVRkhVFotTWHZx3OQFyQ
 jrDu3DeF3Fmi55p8BUdRFJUR+9KNTz+X1XXb3qeP4Kv358/jjmmPkSYkdaH/c2DnzGta
 SavL5CQKVVumUY3p07C6ft/d1mchOM3xWhO+jF9wmKy+HXL9EX/ZEwdljLrMu9jSxFHc
 by2WHHBpwQZD69ZiGSlnwDrn+2aIyKymlhUiR4kV4bPlJqFMeYysT7Fl6vTodi9r/6pP
 n/+g==
X-Gm-Message-State: APjAAAXybPOgHhrcfWh+Dtf7LkDW5kFyb578RuktUMQfZyVp4vxmhxet
 ci47/4QP4iOt21j1dV8a+w==
X-Google-Smtp-Source: APXvYqzJLf4ha9VMs8gUwksdHQoOLiYqJXljySLI5noCnRg3vlHKhEjuUKcqoyYlRmCl/CuSuO5PMQ==
X-Received: by 2002:a05:6808:53:: with SMTP id
 v19mr7638184oic.18.1579709814275; 
 Wed, 22 Jan 2020 08:16:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 69sm14826246oth.17.2020.01.22.08.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 08:16:53 -0800 (PST)
Received: (nullmailer pid 29608 invoked by uid 1000);
 Wed, 22 Jan 2020 16:16:53 -0000
Date: Wed, 22 Jan 2020 10:16:53 -0600
From: Rob Herring <robh@kernel.org>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Message-ID: <20200122161653.GA28469@bogus>
References: <20200118092315.10384-1-charles-antoine.couret@essensium.com>
 <20200118092315.10384-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200118092315.10384-2-charles-antoine.couret@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: tas5756m: Add DT binding document
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sat, Jan 18, 2020 at 10:23:15AM +0100, Charles-Antoine Couret wrote:
> Document the bindings for the tas5756m driver.

Also, checkpatch.pl reports your S-o-b is missing.

> ---
>  .../devicetree/bindings/sound/tas5756m.txt    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas5756m.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas5756m.txt b/Documentation/devicetree/bindings/sound/tas5756m.txt
> new file mode 100644
> index 000000000000..293eaf20d008
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas5756m.txt
> @@ -0,0 +1,25 @@
> +TAS5756M audio CODEC
> +
> +Required properties:
> +
> +  - compatible: should be one of the following:
> +    - "ti,tas5756m"
> +    - "ti,tas5754m"
> +  - reg: the I2C address of the device for I2C.
> +
> +Optional properties:
> +
> +  - mute-gpio : GPIO wired to the mute pin.
> +  - hybridflow : an integer between 1 and 9 to select the HybridFlow program.
> +      if not supplied default DSP program is used.
> +
> +Example:
> +
> +	tas5756m: tas5756m@4c {
> +		compatible = "ti,tas5756m";
> +		reg = <0x4c>;
> +		#sound-dai-cells = <0>;
> +
> +		hybridflow = <6>;
> +		mute-gpio = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +	};
> -- 
> 2.24.1
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
