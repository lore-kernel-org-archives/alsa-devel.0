Return-Path: <SRS0=G//A=2O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104BC2D0CF
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:33:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3AD2071E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ifRmc37J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVIP/PkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3AD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDB011689;
	Tue, 24 Dec 2019 08:32:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDB011689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577172808;
	bh=beR41KK6eJk7lLQstiYGN9pXltftTBwsoZaNIXxQxNI=;
	h=In-Reply-To:References:From:To:Date:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifRmc37Jx7FkkDH+626Xz0UvFpjwlr9R2zoc4Js2TrniXz/rl9H7yMctMAfMy3Q+s
	 z2nSml6O9lHegOIYtfdyIOJEOPx2ltb04mpISS6JWoPiGB9cG70qGM+oW+vgWTUEkq
	 Lxfncp/P+wNHRtt+gVxIAQLY/swAu6dcuqY7Nvd8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40FCFF80136;
	Tue, 24 Dec 2019 08:32:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED114F80138; Tue, 24 Dec 2019 08:32:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEFC7F800AD
 for <alsa-devel@alsa-project.org>; Tue, 24 Dec 2019 08:32:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEFC7F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PVIP/PkU"
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68302206B7;
 Tue, 24 Dec 2019 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577172748;
 bh=e5Lx3fav9aHPYbQQLVJ8r8urYsQzhkPfNR/pW89IEzY=;
 h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
 b=PVIP/PkURFqmzZPXEhTK+7hdJGt4rFx3a65T+psJM2DkPh6q9hIHwk44H8ZMbvFrd
 pBnyZt15MphKr7xhE8x8Noymtxtox9Hpdrn1GpNvhEaUa/tp8paBn2AgzuMahysl3k
 4FuRhM56J6bhoOXik71QYxVB7Hce3NCHpFVY4YvM=
MIME-Version: 1.0
In-Reply-To: <20191209183511.3576038-6-daniel@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-6-daniel@zonque.org>
From: Stephen Boyd <sboyd@kernel.org>
To: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date: Mon, 23 Dec 2019 23:32:27 -0800
Message-Id: <20191224073228.68302206B7@mail.kernel.org>
Cc: lars@metafoo.de, mturquette@baylibre.com, robh+dt@kernel.org,
 broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org,
 Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH 04/10] dt-bindings: clock: Add
	documentation for AD242x clock providers
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

Quoting Daniel Mack (2019-12-09 10:35:05)
> diff --git a/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
> new file mode 100644
> index 000000000000..f434b3e4928e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/adi,ad242x-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analog Devices AD242x clock provider
> +
> +maintainers:
> +  - Daniel Mack <daniel@zonque.org>
> +
> +description: |
> +  This module is part of the AD242x MFD device. For more details and an example
> +  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.

I think we usually leave off Documentation/devicetree/ from paths when
they're inside the bindings directory.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad2428w-clk
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Array of two strings to use as names for the generated output clocks
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> \ No newline at end of file

Why no newline at end of file? Is there an example?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
