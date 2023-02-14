Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA35AC05027
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 17:54:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E60FF886;
	Tue, 14 Feb 2023 18:53:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E60FF886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676397259;
	bh=Zeo8UXVInS7xrfeXu4q8HAWOdIVPkWxnAA1bvkL3OQA=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=B9Y/tN68+AWTsg7NLvtXnDEvURCYumNcHbiHMgmwRkaRk00Dd124pEhaKtjOmC1GN
	 DKHixginphln1ddB2RVNZS+SEc/yJf5WbKmvCP9zfeWQZ1ccyVMbBpzVmbwwyQU1EZ
	 Yxi3A+wzKEzicAcd5UWQBXFt2R10/mY2WsaI3/TY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB1ABF801C0;
	Tue, 14 Feb 2023 18:53:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26BB2F801C0; Tue, 14 Feb 2023 18:53:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DF9BF800B6
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 18:52:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DF9BF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SREMqWDz
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1436CB81E97;
	Tue, 14 Feb 2023 17:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDF7C433EF;
	Tue, 14 Feb 2023 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676397171;
	bh=Zeo8UXVInS7xrfeXu4q8HAWOdIVPkWxnAA1bvkL3OQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SREMqWDzKOxX6+lJ9Ovd6n1U+xgLFm8KxVVcwBv+gfPSQZb8JMeiHTzrrEBFzuWsb
	 Hynegxp4tUaZG/wz0Rnshbaed9pup5Z7LWZ2DrAiDgO9KWZmoycd/kPfxJdzVbIJC3
	 i9dPKkaMCo/4yUo4gNjwdJDiQbLYjznpkLsovV2UworTO6W0+LoCmmVmmQNV7WHHkz
	 UeaRYxSOH7qEke3JsbXHZ+Y67GbZOHttsCrRjQisYM1Iu2PJzd+hpWQj/FDc5q23hT
	 5XGuLGqDwnjBZjC+8Wx+2zMEJuKifBVgvuIcPGEKA53/uKjEXLVwQfY67UHJmiwIBz
	 eS7sykb/LyRVA==
Date: Tue, 14 Feb 2023 17:52:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: renesas,rsnd.yaml: add R-Car
 Gen4 support
Message-ID: <Y+vKcGic3sC7+3I/@sirena.org.uk>
References: <87ttzq8ga4.wl-kuninori.morimoto.gx@renesas.com>
 <87sffa8g99.wl-kuninori.morimoto.gx@renesas.com>
 <9aa09940-91cf-32ba-34f4-a57c9e9965bc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5nTrF0kECEthPNCz"
Content-Disposition: inline
In-Reply-To: <9aa09940-91cf-32ba-34f4-a57c9e9965bc@linaro.org>
X-Cookie: Serving suggestion.
Message-ID-Hash: FDUESI7QZABEYPGR3TMY6A32A7S5LS2W
X-Message-ID-Hash: FDUESI7QZABEYPGR3TMY6A32A7S5LS2W
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Rob Herring <robh@kernel.org>, Linux-DT <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FDUESI7QZABEYPGR3TMY6A32A7S5LS2W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--5nTrF0kECEthPNCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2023 at 09:58:15AM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2023 03:13, Kuninori Morimoto wrote:

> >    clock-names:
> >      description: List of necessary clock names.
> > -    minItems: 1
> > -    maxItems: 31

> Not much of an improvement here. We asked to keep the constraints here.
> I gave you the reference how it should look like. Why did you decide to
> do it differently than what I linked?

Krzysztof, please take more time to explain what issues you're
seeing, what you want people to do and why.  I'm having a hard
time identifying what the issue is here - AFAICT when you talk
about the example you linked you're referring to:

  https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57

which as far as I can tell looks like what Morimoto-san is trying
to accomplish here.  I can't tell what the issue you're raising
is, let alone if it's something important or just a stylistic
nit.

--5nTrF0kECEthPNCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPrymMACgkQJNaLcl1U
h9A+Qwf+LKrLSI8QSlSdFzWPGZ9mTjWdiSl4gRMe+G25PrnwyX3F7+Ef1AJlb8oo
SpuW44cGteAL4d9a2mQ286jYRkTHUwb4E2cxI/CH8in9arTTX2yAr3zjfJyclUZK
8sb6dx6bjTVuDtFlw2O+Ngqop01RII2syp7js/XTgd+NPW6EUOQS9ayfK716Ro2K
ZgXRZHQoX0iY+W8/7u1dxsJJ2wMwy1/6lnMDI6UYSlsNATKjVQnbG5Jrw6eIpB8J
r0XOVpw26qzfLrRmRWClYEYiBWCFX7ywvamtm2HEIsTeYkGPKXlcFAYielX55F1U
eulvhcB/jaXzOWq97yhakI9YOUhLgg==
=4rgB
-----END PGP SIGNATURE-----

--5nTrF0kECEthPNCz--
