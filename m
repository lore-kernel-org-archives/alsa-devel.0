Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F2CD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:05:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DA57601AE;
	Tue,  9 Jun 2026 09:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DA57601AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780988748;
	bh=iypVwKQAl1d161PJuCJiQZ8cL2LK++n+cytP17W2zIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hnleeof3jP1DjLeW1PXz0sIJk1c5GZFzfX1/dfRNaXuuPiG13LdgwWuYDNN2g6h1y
	 Dldfxf3VikpeUb0s67kkZQVLLPtSLFJzTwzy7d5rzv8yimdWUBpOiV06xZuUyFlmJH
	 Qwd2m27MSW7m895l0HfOS6vOZ4PWR8bXasKwfxy0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 817EAF805F6; Tue,  9 Jun 2026 09:05:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03E02F805F5;
	Tue,  9 Jun 2026 09:05:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F30DFF80496; Tue,  9 Jun 2026 09:05:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780988699;
	b=jY8+RBOkUoZx1ALsL/frMZ4FxldrM6RA3UZlOFFm2QVKbk0ZiynUa6iBA3W9GBZrGnAW
	 j6dk2Sqg5wetPL9PwHrYkUqv+UPMEvSIIzGw/ChhdbIA1lKJuYPMndmE/eS+W+KX7JCyB
	 JsrzKJxGP1/s2HzjBoGrTxjs7/WVOUeQj2JJrnRLnTvZqKjQ+jUIKbELFy6XE6U2/9xXH
	 vTA91IbCKo3JWmNomgB6XiRM2VRUlrZQ2XiNEXIVCbs0tD0qkoCqYizh4uitQr0UtZmER
	 WxQvSVEjxD6+fvjhzpFW6soCEBoWwATZL3949f0qsVZRqOyQuh2nZBJqKumFuFXW4xA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780988699;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=iypVwKQAl1d161PJuCJiQZ8cL2LK++n+cytP17W2zIo=;
	b=BiYBb8wSH7p7EvkQ9GLO+oHZG6Pn1yRhElx57/bDpRkoiUBfFN8dUTh/kFxxmNs4ip7z
	 U8Q/bJc/vrxOkgIepR+boIoqesh/lkxIEu/rPgBcDEtSe8b+y95u6Z30adY8sHE5hx6tM
	 lAWABPmo8zWkajyI9z8BrNrVWoUtkAlHhO62jArLxHnU2o73VZxJpuq9ykq+r/bUx6h02
	 yuhvB9v0eoznXcuGU1KhPEHql7q7lTOAPPmUY6W85cPtDUDjqQOP6mGGKKJIWdEFD8EGs
	 rdHs7O2biOdY7qs/GXrfcbvOWUamfleQ26eiU+wdi/LLg/I38TVGS6Etis00DY9feBw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GRRqhosw;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7B813F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 09:04:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B813F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GRRqhosw
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B7E1600AE;
	Tue,  9 Jun 2026 07:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFA91F00893;
	Tue,  9 Jun 2026 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780988695;
	bh=DJUmtmPwmSVMMnBBfyUFcLIcI7msLFbvO5LL8BmNMbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRRqhoswSTG0xi9C9hO+ZQDQEUXOX0KkrQjj3zbJ0PJx8gynRHUTiyLPkJECOqRAA
	 +NUQnxNOAq2C7oah1yPdbxBkOt6u7adUrc7J7Se3Ikt5GvxeKGKAieIFFIXs1fgCE+
	 Q79od3Dh+sgXJzhlbjx1HagOR7c3c7vpsReBYcuZk6NM4hbyO/0XtiYKL3PrHFeKOo
	 yZCRCO6scD57PAVc2SvsZ168j4YOvAXHH63pwtLnmlz0T/E6djeZK1uSFpXVx91GdW
	 T2ugzuukhNzO9FGFSpQbUW8t0t3QcH8VTwSIdju6e9dC0Ks8WfqJrsZ0StnVGu4TeW
	 VEcz1p/lRhNSA==
Date: Tue, 9 Jun 2026 09:04:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Message-ID: <20260609-hysterical-rhino-of-resistance-d7e1da@quoll>
References: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
 <20260609024128.585938-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609024128.585938-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: 3BOZ4OGA3T35TLXT3G3YAYDWSO4EOHET
X-Message-ID-Hash: 3BOZ4OGA3T35TLXT3G3YAYDWSO4EOHET
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3BOZ4OGA3T35TLXT3G3YAYDWSO4EOHET/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 09, 2026 at 10:41:27AM +0800, Neo Chang wrote:
> Add device tree bindings documentation for the Nuvoton NAU83G60
> audio amplifier.
> 
> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
> ---
> Changes in v4:
> - Refine the `firmware-name` description to clarify the loading order
>  (Left then Right) and the PBTL mode behavior.
> - Remove the "dsp bypass" option description.
> - Update the example node to follow devicetree coding styles.
> 
> Changes in v3:
> - Remove colon to resolve YAML build warnings.
> - Fix 'firmware-name' property definition to comply with binding schemas
> 
> Changes in v2:
> - Dropped the word "driver" from the description.
> - Removed runtime/software configuration properties:
>   nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
>   nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
> - Added missing "nuvoton,dac-cur-enable" property for static speaker impedance matching.
> - Removed unnecessary '|' formatting from single-line descriptions.
> - Fixed typo in firmware-name property.
> ---
>  .../bindings/sound/nuvoton,nau8360.yaml       | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
> new file mode 100644
> index 000000000000..2d19aedf1419
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NAU83G60 Stereo Class-D Amplifier with DSP
> +
> +description:
> +  Stereo Class-D Amplifier with DSP and I/V-sense.
> +  This device supports I2C.
> +
> +maintainers:
> +  - Neo Chang <YLCHANG2@nuvoton.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nau8360
> +
> +  reg:
> +    maxItems: 1
> +    description:

You want |

Or this could be just enum of addresses, no need to copy paste address
decoding from datasheet.

> +      The I2C address of the device. The address is determined by the external
> +      hardware configuration of GPIO1 and GPIO2 pins.
> +       - 0x1a (GPIO2=Low, GPIO1=Low)
> +       - 0x1b (GPIO2=Low, GPIO1=High)
> +       - 0x4a (GPIO2=High, GPIO1=Low)
> +       - 0x4b (GPIO2=High, GPIO1=High)
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  firmware-name:
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Assign firmware filenames for Left and Right DSP cores.
> +      The first firmware is for the Left channel,
> +      and the second is for the Right channel.

Drop all above and just list the items with description

> +      In PBTL mode, the Left firmware is ignored and only the Right is applied.

Combining also this.

items:
 - description: ...
 - description: ...


Best regards,
Krzysztof

