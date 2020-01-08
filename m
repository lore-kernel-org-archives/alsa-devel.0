Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B8C00523
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C1120848
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JFS8zYzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C1120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F8B217B7;
	Wed,  8 Jan 2020 04:46:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F8B217B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578455221;
	bh=9qXDI48lLTbmnETaqoukWwr0qchf329LcM0xYaOrfLA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JFS8zYzFfzB0InIYcSAQI3TWNjhs1x0pjzCUy0hdNNuk6c9WUxvCZEXYAE0YV+tuI
	 6VBjcZHnamNw4A5fRfq9bwaOFlMa4B24iklht9PT8bmb50nR7PiJ3Ee2Gtlg9YcSnT
	 Tsjmy/7mMH9dSqoQEtE5opEAj8PN3ivk9el7dTrE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D67CAF80116;
	Wed,  8 Jan 2020 04:46:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5AEEF80159; Wed,  8 Jan 2020 04:46:08 +0100 (CET)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1261DF8010B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 04:46:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1261DF8010B
Received: by mail-oi1-f194.google.com with SMTP id i1so1474349oie.8
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2020 19:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=r+pFes6TBL9qlt9DAArVbPYLSHaTdO8S1tCZhBCIPEc=;
 b=GAn8qtBS1QDh1mLMeuCCOcC0OLm+2NY33JLX2zizuFielvul373h+NJyI7ALXkzOER
 v3K841yVaiUKuDvlP9Xpq8BzFigU2arG/ru6AqhlSVi2Ei7ntdTiVft8B2Xyo8q1mO1H
 z2NkdEqCM6IyoFMSV2j8D0HLCwkArNkFivfxd7JTfgdkQmzpW03NPKO/4YQNEgYYZTOl
 ZlZ5XgHptAEq5HDSuzRaPdfb7r79PssFVDu0OhOlrgd3y9pH0GuLpK5T4xhRxbXzTxjM
 Qd917mrS51SJ55sap5nPmpcNeHbt6w4DkAA61XlntTwmPjuQZyXrMiCPZyEli8YMulwZ
 6oZQ==
X-Gm-Message-State: APjAAAXuqWeb+LrYSB/XrEHmue/EjUlJPiHWaJ/AVirl/ZLhTyLuaAxC
 H5ngB7IMzJwQshc0pwAl3RySY4c=
X-Google-Smtp-Source: APXvYqzfBsQJ0Rjp4ZUR7lCBXcKbWjiFVpiMdiwsdij0ttsB8b0FgBlroXy8lGFrAzjZMFFrL1N0lQ==
X-Received: by 2002:aca:48cd:: with SMTP id v196mr975241oia.102.1578455161479; 
 Tue, 07 Jan 2020 19:46:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p16sm642795otq.79.2020.01.07.19.46.00
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:00 -0800 (PST)
Received: from rob (uid 1000) (envelope-from rob@rob-hp-laptop) id 2219e3
 by rob-hp-laptop (DragonFly Mail Agent v0.11);
 Tue, 07 Jan 2020 21:45:59 -0600
Date: Tue, 7 Jan 2020 21:45:59 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Mack <daniel@zonque.org>
Message-ID: <20200108034559.GA27808@bogus>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209183511.3576038-3-daniel@zonque.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, broonie@kernel.org, linux-i2c@vger.kernel.org,
 pascal.huerst@gmail.com, lee.jones@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 02/10] dt-bindings: i2c: Add documentation
 for ad242x i2c controllers
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Dec 09, 2019 at 07:35:02PM +0100, Daniel Mack wrote:
> This device must be placed as a sub-device of an AD242x MFD node.
> =

> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/i2c/adi,ad242x-i2c.yaml          | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.=
yaml
> =

> diff --git a/Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml b/=
Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml
> new file mode 100644
> index 000000000000..ded92f8a791b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/i2c/adi,ad242x-i2c.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analog Devices AD242x I2C controller
> +
> +maintainers:
> +  - Daniel Mack <daniel@zonque.org>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +description: |
> +  This module is part of the AD242x MFD device. For more details and an =
example
> +  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad2428w-i2c
> +
> +  clock-frequency:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

Can drop as it already has a type.

> +    default: 100000
> +    enum: [100000, 400000]
> +    description: Specifies the I=B2C clock frequency in Hz.
> +
> +required:
> +  - compatible
> -- =

> 2.23.0
> =

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
