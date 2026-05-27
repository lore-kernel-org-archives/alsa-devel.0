Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8996FCD5BDE
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 09:16:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBD9160260;
	Wed, 27 May 2026 11:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBD9160260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779873383;
	bh=LJDhMjAyGdsNfusdw02XmBuKhGs98ar0VqkbMUPglo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ur6GFTrm43zjr0c7yMy+hzfQH3yE83O5a9u3NVhltkeJe3Z6Vh/KixJKlnbLtxnl7
	 AY9LRWPrtpP38wQq/iHLPdfdUYJcwn6HWKSwkUq4BxmLzG5DSWZzwboa7EuWndXto6
	 A04tSk3XWfAaPX4b9lR5FuGuT+Bj0+DHREOTx64A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BC17F805F3; Wed, 27 May 2026 11:15:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0021EF805F4;
	Wed, 27 May 2026 11:15:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0535F804FF; Wed, 27 May 2026 11:15:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1392CF80246
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 11:15:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1392CF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aaOGlgQL
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4450943246;
	Wed, 27 May 2026 09:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5580E1F00A3C;
	Wed, 27 May 2026 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873331;
	bh=Pyb7fuKdkRm7mLit3bJvr6ITAg9LyTkELoSIdbnZo6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaOGlgQLIoeqy700pGTESUWPe7Kl2nO5W6wz9IjU4SAZTLp0SIlFqEL/GNNwjceiY
	 /CjNIb01HlWUuaraM0v6GuwMxg1cOqaXyKvvLQ5f8qdXeHb7wsXllOmrVQ8RxKGI5K
	 2bdaVit0YIqKW8Crctva4g7T6J6bn6TIXYuxnVKbn9s9F/EK70meQah8t3bDJV28qb
	 LbusxtwXnbZqkviG8kQNlyinNH7a/sYepZX3IrAXmoBJdiKPN/hzlK0D2WjQkg9tAC
	 MmsSLOeTNBs+g1VikO07S3u8anQ2qi+5Ix9XrkiHV6b7+z1KZL9XdKPh5g0wQGQyFo
	 dIbiFqjWcOpgg==
Date: Wed, 27 May 2026 11:15:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Message-ID: <20260527-pink-cockatrice-of-expression-04b6e0@quoll>
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
 <20260526015826.440769-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526015826.440769-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: ZGLMAEV6DB3VE26LAMTD6TD5SZVKM6N4
X-Message-ID-Hash: ZGLMAEV6DB3VE26LAMTD6TD5SZVKM6N4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZGLMAEV6DB3VE26LAMTD6TD5SZVKM6N4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, May 26, 2026 at 09:58:25AM +0800, Neo Chang wrote:
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  nuvoton,dsp-bypass:
> +    type: boolean
> +    description:
> +      Forcibly disable/bypass DSP path.

Same questions as v1. Properties are not to control your probe() in the
driver, but to describe the hardware.

You have entire description or commit msg to convince that previously
questioned property is still reasonable in terms of DT.

OTOH, isn't lack of firmware binaries enough to deduce that DSP is not
going to be used?

> +
> +  nuvoton,pbtl-enable:
> +    type: boolean
> +    description:
> +      NAU83G60 supports PBTL mode for mono output.
> +
> +  nuvoton,dac-cur-enable:
> +    type: boolean
> +    description:
> +      Adjust DAC output current to match speaker impedance and prevent
> +      hardware damage. +3.2dB when present, 0dB by default.
> +
> +  firmware-name:
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Assign firmware filenames for left and right DSP cores.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        codec@1a {
> +            #sound-dai-cells = <0>;

Please follow DTS coding style.

Best regards,
Krzysztof

