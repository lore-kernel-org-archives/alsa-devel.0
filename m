Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314CBC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:41:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD53160202;
	Tue, 30 Jun 2026 08:40:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD53160202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782801661;
	bh=tPzUUgKX5I6bopctVswm3qvHLGFdUqAjogaDEX43PGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XswQWPxK2hgwP/T3TEhdD5IRIx8Y9XNhet2a39rhsYovvVDpuYDUwrkLfvfUC8aRc
	 0kV5HZc91D3Qw2b8+szqPrrLWx9uIBlC1GCt3uxPlXyiXMM19IC+AUDp6ASniw5cMc
	 xjJ8jvxR7SZT+nOyxqNb3zqQJ+ucaoB+Vp8TorvI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 831F6F805FD; Tue, 30 Jun 2026 08:40:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C12C6F80601;
	Tue, 30 Jun 2026 08:40:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C397FF80587; Tue, 30 Jun 2026 08:40:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782801615;
	b=GEsHOv+xx4EJM4+q2+dT0UrnSCjgp6tKc8M6BPil4aZAbDXIij3nq6IMnbKJoHakz4sz
	 txcmfy2euu+qwzzzGKHz6L3eQRa03O6CeV8YyZ9PMfMEEteJqCw0bO3am2Q3gOf2U6bM7
	 SooPKNHBGJYWSvAtfQlKxu0Kjf4DDqafcRlCHnejizgn9vNkDc0oGjKus9+vQFU99Oa24
	 aLmv4+Lj/bdYK6kmlgmOEbA2sxOzABr4M9hEd0w4bL5mAWasBpzDImDoWyqt+EiDSJvqb
	 8r/jCEDkyeW+tX2lFpan6lsvbsAExcBarSrJjk7DXIk2NhQC4t5OzpyBsXHe+esImvA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782801615;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=tPzUUgKX5I6bopctVswm3qvHLGFdUqAjogaDEX43PGk=;
	b=pPo9np3xiAN56ECYsOXgOHcm3HpTgiqWuftbDSDFHmWeaVO7IwlFbm1bOue9CJaP5sLZ
	 RMWmH3jTAmgn/SUY1R1MHs7Oeadr6yCs/B/YbiWI3sZREq4fgDmJH8NFZXY+FzHtsnUbz
	 qm4IOl9NoirUzWUBAuao6ICFQXH5zoFNNj9wedAyVOX8QBp7Zw7Ase2VJJ6ieMLBe3CYU
	 0L5Bww9DaiWgFQEpE0neRyzgj0BKfIq6cn30XcMCKvX1NoAn2ao1xQgxO/1b/GxuWKNg8
	 9ISFfJpFtgxLg2z0o0tJoqKARQiVgRVQq/IURM117SOONItMyQueZCHkq0QkJyq6o3Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zo82KfFn;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91F67F80423
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 08:40:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91F67F80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zo82KfFn
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B16C60008;
	Tue, 30 Jun 2026 06:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387281F000E9;
	Tue, 30 Jun 2026 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782801612;
	bh=1zK/FCFxCZYzG1d3MdwSXsiqqSvH2UuFILULEPPXJy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zo82KfFnm91JHEO9rwac1k3/5D5cvqSQmCvj1Q4EebADzTxSiqpGE5nBAo3o2tFqJ
	 KlsBv8Fk38EmtJilevk3enjxTjq8fc+QIsiYDB7Wq0tFplDDKvyg7mq5CZos4/e/YT
	 +lNp5bEf4lUZGBzcvhb4VgHRhiLqFtLxOM6tvJ2UROdFvUEuRPPtm8puKfOyhv/Woc
	 tuti6clWePWEnPsoB8vJAb3bZjBXJSN0pLsQwPSiV8u+rIm9n3fSjx0rv83YE+MlC9
	 OHR8Rkufpt41k4PsiMXWPkjifxv1npflyHTKy9BGGikfnEv2vLUHU0BV+UqeSBpf/3
	 CtAzTa0sqA9rQ==
Date: Tue, 30 Jun 2026 08:40:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Message-ID: <20260630-amusing-striped-urchin-d49c93@quoll>
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630021510.821919-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: M4UPSD7FZZKXLINRMZHVS4O7VNH7O335
X-Message-ID-Hash: M4UPSD7FZZKXLINRMZHVS4O7VNH7O335
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M4UPSD7FZZKXLINRMZHVS4O7VNH7O335/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 30, 2026 at 10:15:09AM +0800, Neo Chang wrote:
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  firmware-name:
> +    items:
> +      - description: |

Drop |

> +          Left DSP core firmware.
> +          In PBTL mode, the Left firmware is ignored and only the Right is applied.
> +      - description: Right DSP core firmware.
> +
> +  nuvoton,pbtl-enable:
> +    type: boolean
> +    description: NAU83G60 supports PBTL mode for mono output.
> +
> +  nuvoton,dac-cur-enable:
> +    type: boolean
> +    description: |

Drop |

There is no formartting to preserve and I did not ask to introduce it
here. I commented in completely different place.

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

