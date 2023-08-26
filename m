Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDEDC83F13
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Aug 2023 11:26:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1076844;
	Sat, 26 Aug 2023 13:25:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1076844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693049161;
	bh=QdP+KA+OdSz2el0jN6VlJTmMNAtuZc+l4F1UYz654CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qhNtrX7ebhZcPHTe97vCIWeTu6lUkRK0WFfEzIGFE5KVQvZ/hzYwNsFppKgf5wmc+
	 u+6q+wtoDf207kOWGnLvtKiRIyR+kiwKxILWAxaSbm8TOZGePTfhmuf0U67eK/3kch
	 X4cEJfWrv73y5J1pOh9f+qnVuZQcWn4Z3b7OnZRY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D451F80158; Sat, 26 Aug 2023 13:24:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24013F80158;
	Sat, 26 Aug 2023 13:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2645AF80158; Sat, 26 Aug 2023 13:24:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BF2AF800AE
	for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2023 13:24:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BF2AF800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J0ijANXe
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 09A0E626BB;
	Sat, 26 Aug 2023 11:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22145C433C8;
	Sat, 26 Aug 2023 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693049069;
	bh=QdP+KA+OdSz2el0jN6VlJTmMNAtuZc+l4F1UYz654CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0ijANXefTHurOLYmJpqDvU8r5HHVuFdLEWraAEV3UZ+9FWt9LtL7TZvy+z55xe9R
	 JvLJ/rRb6wLKsPE4ZRjxngR0P0LYYCNhdnaqVeABk1txbkMuyC2gL8wbkCmwxSvd4H
	 qe6J0yuGF2GPGXCoCQ7KWynKmivydUNzgGtRN7tizJwXX9F/1/J4RDcSz8Fl5yfoIw
	 W33nOfKm2K3rTaCHndAfLQwxLvB5qioy+GdJfykwhieW6qDCl3bpOTfzWM6FCKqyQC
	 gFLoLTbMDmOui3IR13b3Dy2V7y9iZY+dH1mRnohWKdUEpiJ4zjn3kZaRPPOtEI4Qg0
	 r/DicrG0kpLXQ==
Date: Sat, 26 Aug 2023 12:24:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Marian Postevca <posteuca@mutex.one>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
Message-ID: <ZOng6WCjECi/Ula2@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
 <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
 <87y1hypz1y.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IUEZvB6woga6BL6m"
Content-Disposition: inline
In-Reply-To: <87y1hypz1y.fsf@mutex.one>
X-Cookie: Give him an evasive answer.
Message-ID-Hash: DZC7I7PEXEBJ2AIWNY6L3DWTH3WRX3G5
X-Message-ID-Hash: DZC7I7PEXEBJ2AIWNY6L3DWTH3WRX3G5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DZC7I7PEXEBJ2AIWNY6L3DWTH3WRX3G5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--IUEZvB6woga6BL6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 26, 2023 at 12:55:21AM +0300, Marian Postevca wrote:

> I removed S32_LE from the CODEC to test if it works and it
> seems it does work with acp-is2-sp. Format S16_LE is chosen by
> both components and sound can be heard. I guess this patch is
> not really needed.

If the device supports it it's a good change, it was just the bit about
it being a fix that I was querying.

--IUEZvB6woga6BL6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTp4OYACgkQJNaLcl1U
h9Ah3Af8CtxEAOV0PQfZ8TfnRojuQe8q+J5avd9VjbolE481OMphKYrHdYzIN2aj
cko3Q0fCBxxdBoy85SDCbyMvj3w6SBEm5pIZUBi3kc820kaQAlqCZjmygGwg0TSv
guCbcmiCMxvnh53p30VwdbEVTjOlhrbvzsT9v++lXSze4kAbmNdwI+Tj1/avteCT
xoXfoCuHFD/bQP2mJ2gPeRM8Iysr6Hl5ROjAqrCtxoHB8uHcPEmWwR7lKD9NqStH
lVsbiQwaKrE4RJvPgYyiwz5bk/Y+pDIfM4fhrDXZzFqUNIfGszwQBU3HVykNYTnz
ywdSsljt7KzCG4VswVWUl7jDnFUgrg==
=x02n
-----END PGP SIGNATURE-----

--IUEZvB6woga6BL6m--
