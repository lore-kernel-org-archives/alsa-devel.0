Return-Path: <SRS0=Eq0+=FZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB51C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 22:35:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EADC22BF3
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 22:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EADC22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F41421703;
	Mon, 21 Dec 2020 23:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F41421703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608590123;
	bh=n3KjFUapaly9UL4O1EOPJT9qXVgiDBKI5T6rsobTMMU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VZQqLyoXCCm3gelREL4p9e/PezL2T0ghc9JhtGXvjayCwPe53Yp5L1R9czvWgCpLl
	 /ToX/Q6s4Zhr/bEECR/ysGCGUge8txlQiDhiZkhKdjvlO+Gl5W8N/4YDVTpOnYyejd
	 mS7AnzbZifWdNsW2yicISX+JtcRIVwvk6xNKpJfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8359FF80168;
	Mon, 21 Dec 2020 23:34:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F024F801D5; Mon, 21 Dec 2020 23:34:27 +0100 (CET)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20FB0F80116
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2020 23:34:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20FB0F80116
Received: by mail-oo1-f45.google.com with SMTP id n127so2550302ooa.13
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2020 14:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nwkmxUnyc+70jBLqAzr5iSoKUZYnqKhXG4oOa7bmAVY=;
 b=tXKo3ua/X3lCqDskE3oyidSFOhfr0nMtcCKbPce3C0y7gvEdWr/B8nFihy7op5RJrE
 bZiMZVbVip8P7ilHiMiw0GWXhrHKMtkPOdK0eco6sh51hK84MBYts/fJQf3UyveAXN/W
 8zz2N6sn7Rt6jcTSOBN8XZcNcujdTpIoeBigoBcMR1HVP18eJuokvuXplfUH4YHcjgkN
 QENxB9Y6RcEBb39HazVwjSEI5aTDWkZAzaegt9XEjp/gOpilc8PDCBovtSjWrb/9NT7z
 1KljTPQWneQTu+Zb+4XqE0dwF9sTni9CucZiU5fc/iRbDIRuZ5rPQF3WIolWxbma4Fyi
 KMRQ==
X-Gm-Message-State: AOAM533Lsz0+ttQ3Cs+xWVhqyYJ4QnBE/dtkVRXJA1H4Dvw8qY1p1et6
 wCijTY5K1HJ3DQhUwx7Hbw==
X-Google-Smtp-Source: ABdhPJzZe4HjIcXZYX6IiGv6NVNfbHgWdbvac2UXEoc2OdCwz2tKMLWGBTFtRKX8zgTcFXnio+DJ+Q==
X-Received: by 2002:a05:6820:503:: with SMTP id
 m3mr13135986ooj.83.1608590057671; 
 Mon, 21 Dec 2020 14:34:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id p18sm3916482ood.48.2020.12.21.14.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 14:34:16 -0800 (PST)
Received: (nullmailer pid 693960 invoked by uid 1000);
 Mon, 21 Dec 2020 22:34:13 -0000
Date: Mon, 21 Dec 2020 15:34:13 -0700
From: Rob Herring <robh@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/6] ASoC: audio-graph-card: Add plls and sysclks DT
 bindings
Message-ID: <20201221223413.GA693000@robh.at.kernel.org>
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
 <20201217154142.24301-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217154142.24301-3-rf@opensource.cirrus.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, nsaenzjulienne@suse.de
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

On Thu, Dec 17, 2020 at 03:41:38PM +0000, Richard Fitzgerald wrote:
> The audio-graph-card driver has bindings for configuring the clocking
> for DAIs within a component, but is missing bindings for setting
> up the PLLs and sysclks of the component.
> 
> This patch adds the two new bindings 'plls' and 'sysclks' so that the
> audio-graph-driver can fully configure the component clocking.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/audio-graph-card.txt       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)

This is a schema now in master.

> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> index d5f6919a2d69..30405e64cfbb 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> @@ -32,6 +32,40 @@ Required properties:
>  Optional properties:
>  - pa-gpios: GPIO used to control external amplifier.
>  
> +- plls: A list of component pll settings. There are 4 cells per PLL setting:
> +	- phandle to the node of the codec or cpu component,
> +	- component PLL id,
> +	- component clock source id,
> +	- frequency (in Hz) of the PLL output clock.
> +
> +	The PLL id and clock source id are specific to the particular component
> +	so see the relevant component driver for the ids. Typically the
> +	clock source id indicates the pin the source clock is connected to.
> +
> +	The same phandle can appear in multiple entries so that several plls
> +	can be set in the same component.
> +
> +- plls-clocks: A list of clock names giving the source clock for each setting
> +	in the plls property.
> +
> +- sysclks: A list of component sysclk settings.  There are 4 cells per sysclk
> +	setting:
> +	- phandle to the node of the codec or cpu component,
> +	- component sysclk id,
> +	- component clock source id,
> +	- direction of the clock: 0 if the clock is an input to the component,
> +	  1 if it is an output.
> +
> +	The sysclk id and clock source id are specific to the particular
> +	component so see the relevant component driver for the ids. Typically
> +	the clock source id indicates the pin the source clock is connected to.
> +
> +	The same phandle can appear in multiple entries so that several sysclks
> +	can be set in the same component.
> +
> +- sysclks-clocks: A list of clock names giving the source clock for each setting
> +	in the sysclks property.
> +
>  -----------------------
>  Example: Single DAI case
>  -----------------------
> @@ -335,3 +369,41 @@ Example: Multi DAI with DPCM
>  			};
>  		};
>  	};
> +
> +-----------------------
> +Example: Set component sysclks and PLLs
> +-----------------------
> +
> +	sound {
> +		compatible = "audio-graph-card";
> +
> +		clocks = <&audioclk>, <&pll1>;
> +		clock-names = "audioclk", "pll1";
> +
> +		plls = <&cs47l15 MADERA_FLL1_REFCLK MADERA_FLL_SRC_MCLK1 98304000>;
> +		plls-clocks = "audioclk";
> +
> +		sysclks = <&cs47l15 MADERA_CLK_SYSCLK_1 MADERA_CLK_SRC_FLL1 0>;
> +		sysclks-clocks = "pll1";
> +
> +		dais = <&cpu_i2s_port>;
> +
> +		pll1: pll1 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <98304000>;
> +		};
> +	};
> +
> +	cs47l15: codec@0 {
> +		...
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cs47l15_aif1_port: port@0 {
> +				reg = <0>;
> +				cs47l15_aif1: endpoint {
> +					remote-endpoint = <&cpu_i2s_endpoint>;
> +				};
> +			};
> +	};
> -- 
> 2.20.1
> 
