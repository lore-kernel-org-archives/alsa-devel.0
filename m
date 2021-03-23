Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B38C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 19:16:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34EA6191D
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 19:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34EA6191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B39B1679;
	Tue, 23 Mar 2021 20:15:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B39B1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616526986;
	bh=vz1/BwgKsE4QbkxEXRmEGYxQ6lPFuYc202DcZfmWPD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SvXOQBzoEZWCBhSJC1YX2c0l2CqQXZaRPQac1uYzDI3ptW1p+ptoHZJnehPZ7DyXp
	 NVgmVtz/4C21Q0UVy+kP7V++pMCaEFRAx9UQ724K/KdY3alnvqlgT3QPXqSDugEDjj
	 +hWlUZ40J5A8bxHq+Y54RFg+52yb0+d1DQna+G+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96FE0F80268;
	Tue, 23 Mar 2021 20:15:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00E84F80279; Tue, 23 Mar 2021 20:15:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C11FDF80257
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 20:15:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C11FDF80257
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rQFSHnit"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04E1D619CC
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616526923;
 bh=vz1/BwgKsE4QbkxEXRmEGYxQ6lPFuYc202DcZfmWPD8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rQFSHnitQ6+kpGJZuvHSKEGBHFXMX+wwPTFR7qY5UowNPpwAoZNZEy1w0auxbFQV6
 Waok3+0GibjFa/ysyW3jB6MjhXPl33LPeK2B19lgGhljJFV8L75EYoe+cxy68shxb4
 D+LtRkf8M3g7UN18j2Gh8Ae5N0nIpDlNjN6X3bQaNRtzJiuMIHoz6VMLIxzDUwVNsu
 Vx+Dmphj3hlUYjc1I9wtyKZ4JnEcJWm65DDMSFvKbDX/Gfszc6YR30Aglh8ABw2BnY
 Iny/3S32BZFCHZt8nDApWM8V0aMvTFQjp1AQP2rMWwQ0+9joX8xOvYgpye+oCzHfSu
 2U6gRYJZKMWxw==
Received: by mail-ed1-f53.google.com with SMTP id x21so24760690eds.4
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 12:15:22 -0700 (PDT)
X-Gm-Message-State: AOAM533RHEMtPxERP+7TvmqX7N7DKvZv0JS7a6GDaC03elrcRzaty1IY
 l54g1oJ8EHYziAcYx7cZxrJlUvCl+Q0Pwsl3Dw==
X-Google-Smtp-Source: ABdhPJyQUqDZQDlvFKjPPDtTkz4sNMlGLVxwHNqzDZOmCnzfXNGTmq/LBSdLt5mLoL79k61b8WRMes6qPDOkgy4P01Y=
X-Received: by 2002:a05:6402:2d0:: with SMTP id
 b16mr6214654edx.194.1616526921538; 
 Tue, 23 Mar 2021 12:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210323163634.877511-1-robh@kernel.org>
 <20210323163634.877511-2-robh@kernel.org>
In-Reply-To: <20210323163634.877511-2-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Mar 2021 13:15:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLFj3tUUeEeKoZx=P3AHE4Tu1TzuA-tqK4+qD=4J6c=8Q@mail.gmail.com>
Message-ID: <CAL_JsqLFj3tUUeEeKoZx=P3AHE4Tu1TzuA-tqK4+qD=4J6c=8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: Move port/ports properties out of
 audio-graph-port.yaml
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sameer Pujar <spujar@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lubomir Rintel <lkundrak@v3.sk>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra <linux-tegra@vger.kernel.org>
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

On Tue, Mar 23, 2021 at 10:36 AM Rob Herring <robh@kernel.org> wrote:
>
> Users of the audio-graph-port schema need to define how many ports
> and what each port is, so they need to define 'ports' and/or 'port'
> anyways. Let's drop 'ports' and 'port' from the schema and adjust users
> to reference audio-graph-port.yaml from a port property.
>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Sameer Pujar <spujar@nvidia.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> index 31f3e51974bb..e568d6c7dddd 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> @@ -17,9 +17,6 @@ maintainers:
>    - Jon Hunter <jonathanh@nvidia.com>
>    - Sameer Pujar <spujar@nvidia.com>
>
> -allOf:
> -  - $ref: audio-graph-port.yaml#
> -
>  properties:
>    $nodename:
>      pattern: "^ahub@[0-9a-f]*$"
> @@ -60,12 +57,18 @@ properties:
>    ranges: true
>
>    ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
>      description: |
>        Contains list of ACIF (Audio CIF) port nodes for AHUB (Audio Hub).
>        These are connected to ACIF interfaces of AHUB clients. Thus the
>        number of port nodes depend on the number of clients that AHUB may
>        have depending on the SoC revision.
>
> +    patternProperties:
> +      '^port@[0-9]':
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -77,7 +80,7 @@ required:
>    - "#size-cells"
>    - ranges
>
> -unevaluatedProperties: false
> +additionalProperties: false

Adding this results in schema errors in the example, so a prerequisite
patch is needed.

Rob
