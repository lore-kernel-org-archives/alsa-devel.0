Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4BFCD8CAC
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:34:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24380601CC;
	Tue,  9 Jun 2026 09:33:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24380601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780990438;
	bh=lnRXYauZivJZYZKKpwfjuvGMGi/Kptw0SsII1kh49V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jek+rn47dw/vJX6D94CGuOgWIRSQPmfsy37f7PN7tDH8u1g1Ldadr0D7GHa3KV16p
	 o7GEM9Itv+6QhytDkiAomEDNidkXaGgtP+x1BrQVs1NowRil+OtvDnN3cxcOLQOZBW
	 H5Vp57LSf0plI4lwLgGniWhbd9WSH3eMEfVhUVc4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0F80F80600; Tue,  9 Jun 2026 09:33:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CD34F805FE;
	Tue,  9 Jun 2026 09:33:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17418F80496; Tue,  9 Jun 2026 09:33:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780990391;
	b=rSJeuzI6owFqr5t+AateN+ye2F7yRafBxjwu4ybqkJ6uSqBv0xJHDXoDfapgG0zq/V4L
	 N7+wzpjsJfECEDjIo0Ux/QMkrZPuq3Ipi2e4OFApk5fCmoMxoSt3OSOy98FjbBeShbkoq
	 IR5E7y+otJ1llh9GJuboY/G7fb5qfavaxRdo8BgSTLLDoxcXDq6je1lqIKH3jkQLrCwd3
	 wkx8hLeEciKxgGB0+zz6IRZKNPi58FvkIEMlVJov5YQOnia8djA3YBT6ueU8eTYIxRCSk
	 NS91aDpIK7R5V41t7FT16ESlJNfS40cjkT780Yjp3feQOZghGpSroBXG2bcTah4pdkA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780990391;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=lnRXYauZivJZYZKKpwfjuvGMGi/Kptw0SsII1kh49V0=;
	b=NK1Z+J9aDLdUS7hKe4l6IpELO2ovHq0MYjqvMQfLcJwIBRPGG3THea8EcdcNWTLlS9xg
	 aRBvOz89ILO8/+PvEPUDQ6fuAZLzeSt/hzMyvQusT4BMLswsK4BhvJWT2s++18N6d50Qt
	 WMyQ8En8PzJXQAXpBnnI8uRuIHlXs7Xkk3I3s3KcB7no319Q2MrJ4py95u+b4qZG4FPSE
	 IdE2uk2UjTthAwmeJxOJ6icyLyEi317DgI9ZZh9udi5q4BnWkkvkVuqv3Mtp3nUoPImA6
	 VsOjUkBlBf94eKw4RZPwyyxC73TV5ACiWOpzLBpCjpk2rh5aOc4dVb0stj4GLCVxrbw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Ji+SRwM/";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 96522F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 09:33:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96522F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ji+SRwM/
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D166601E1;
	Tue,  9 Jun 2026 07:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC71F00893;
	Tue,  9 Jun 2026 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990388;
	bh=JUkrHSIawlDovwdqb3YkhtzZRBnNrrGbpK99tAgrPQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ji+SRwM/0W6UFN993aF/K3YBxh9rvTZzYPqcLYo+BFw05SL7Cqnz7UXbU54wQCRBc
	 JyQABtGt5j/QmoXRmrkFbvNkGG9Eede9p3ed1pLnotpdBhoQcGKK91iDAgWptfiQZm
	 Ir1ZZEsWrXjHTZ3E0pnBXaX6oJJOSmBG3vikl4S+zv9gdX6OjaIs6QjBKgLVxxnyqD
	 waKW0ar14+Aop9VVpAosMn3YkiO39bGg2tbjtTAVl2LYxcWnL2C2UmPbpHlALFJ8dY
	 vXV62glI12p4GxKu1QNxlEFTyl2o4lViEnyyuPW7dUXVGoFH3913Ssn4zqJ+oTrYh0
	 ASwlrE33Ucr3Q==
Date: Tue, 9 Jun 2026 09:33:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
	devicetree@vger.kernel.org, tiwai@suse.com, robh@kernel.org,
 krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Message-ID: <20260609-vociferous-thick-lyrebird-d53eda@quoll>
References: <20260609030623.17404-1-zhangyi@everest-semi.com>
 <20260609030623.17404-8-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609030623.17404-8-zhangyi@everest-semi.com>
Message-ID-Hash: TQS5U2BOB3KFN3BO2JYNE2I4BQTZWTPM
X-Message-ID-Hash: TQS5U2BOB3KFN3BO2JYNE2I4BQTZWTPM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TQS5U2BOB3KFN3BO2JYNE2I4BQTZWTPM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 09, 2026 at 11:06:23AM +0800, Zhang Yi wrote:
> Add members related to HPF and mclk_source

Please organize the patch documenting the ABI (DT bindings)
before the patch using that ABI.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

> 
> Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
> ---
>  .../bindings/sound/everest,es8389.yaml        | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/everest,es8389.yaml b/Documentation/devicetree/bindings/sound/everest,es8389.yaml
> index 75ce0bc48..be92014c0 100644
> --- a/Documentation/devicetree/bindings/sound/everest,es8389.yaml
> +++ b/Documentation/devicetree/bindings/sound/everest,es8389.yaml
> @@ -38,6 +38,27 @@ properties:
>      description:
>        Interface power supply.
>  
> +  everest,mclk-from-sclk:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that SCLK is used as the internal clock.

And what happens with mclk in such case? Is it still wired?

> +
> +  everest,hpfl:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      the HPF value of ADCL.

Is HPF value in dB? If so, use proper unit suffix and proper units.

> +    minimum: 0x00
> +    maximum: 0x0f
> +    default: 0x0a
> +
> +  everest,hpfr:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      the HPF value of ADCR.
> +    minimum: 0x00
> +    maximum: 0x0f
> +    default: 0x0a
> +
>  required:
>    - compatible
>    - reg
> @@ -58,5 +79,7 @@ examples:
>          #sound-dai-cells = <0>;
>          vddd-supply = <&vdd3v3>;
>          vdda-supply = <&vdd3v3>;
> +        everest,hpfl = [0a];

<0xa>? What did you want to say here?

Best regards,
Krzysztof

