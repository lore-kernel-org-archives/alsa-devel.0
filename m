Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6384EE6457
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 11:07:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FCDF820;
	Fri, 15 Sep 2023 13:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FCDF820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694776036;
	bh=hOyiTxdftFAjmpAlocJ9lFxzTFRptiSSvs7eM0255YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dTITdv4WgJ8u/9+wqO2k7Gz7mUruaznqDYBWTGo/4hBqlI207qK7zBuhVsO67eVLM
	 ofN6SEeVwPFqTLD+UpYTdPRHOtL4RfOOhjscIHMbA07hcKeaExUECZVlpGlkgmBhKG
	 IZS4n/On/lDB8IR+KTt7UFxgHaIYuyvGahM3vnVU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA596F8047D; Fri, 15 Sep 2023 13:05:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24EB4F80425;
	Fri, 15 Sep 2023 13:05:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 800D0F80425; Fri, 15 Sep 2023 13:05:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA1E7F801F5
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 13:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA1E7F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WpDsJsuw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6167461EE3;
	Fri, 15 Sep 2023 11:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47547C433C8;
	Fri, 15 Sep 2023 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694775933;
	bh=hOyiTxdftFAjmpAlocJ9lFxzTFRptiSSvs7eM0255YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpDsJsuw/XYb/kdsFriqTellUdxp3bv3hoVp+QKf5Zpd8MhP0Gs9q8g0/SNyC4oSI
	 As8VAsqgLMD6cOuFT6sTDAOZ3oXGRMxIEoHxhnSUvvRmqg0/WML6mljnfDFQhkqDL5
	 yZFxquEeaZDlA8oinuSE2akhgUhcCDZDSP5aSXL+c4XwciNfqVqekVgovMX4sfRRhx
	 zgRlwHnnDr8lfFn9IpPKhxPn8RuYby5Kw94sDqy1xI8iSHxducXC1Wn0DS0zJ3bq+d
	 EuOqmeCiZp5VyB0kqNE8kjNZcAgL7lolHLaZlVUC6MoDWNzGCRA3dKY1lVAH8zcwi0
	 zAyT/8woJ3GJw==
Date: Fri, 15 Sep 2023 12:05:28 +0100
From: Mark Brown <broonie@kernel.org>
To: John Watts <contact@jookia.org>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Message-ID: <5af3315a-7d28-456d-ae36-9984bc8a36e0@sirena.org.uk>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-4-contact@jookia.org>
 <20230914145234.GA1275176-robh@kernel.org>
 <ZQPuJXcmHABQFaQl@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvWBAkIAAADLULEo"
Content-Disposition: inline
In-Reply-To: <ZQPuJXcmHABQFaQl@titan>
X-Cookie: Gravity brings me down.
Message-ID-Hash: QNNOETSGCX3DPAWJI2FHQLVFRNTBR3JG
X-Message-ID-Hash: QNNOETSGCX3DPAWJI2FHQLVFRNTBR3JG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QNNOETSGCX3DPAWJI2FHQLVFRNTBR3JG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--fvWBAkIAAADLULEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:39:49PM +1000, John Watts wrote:
> On Thu, Sep 14, 2023 at 09:52:34AM -0500, Rob Herring wrote:
> > What's the default if the property is not present?
>=20
> 0. Should I specify it here?

Yes.

--fvWBAkIAAADLULEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUEOncACgkQJNaLcl1U
h9Alnwf9EPsqr1HyoMSzQWvu19hw6Elkc/4CZFN7c83HmYYYCw9czGwXkWmepk/7
pdGCA6F7elZgl4NSe5uVT9oufbHDplEwq5p7PCW4kK+V5q0THsxxNXfG9QvWb+LV
xbHHM2IBeAUR1Vb9Ah7aauT0Ub+ZzQxwSRcbmq5Vue3Q7OiVEc5PNPt+PVonR9uU
/kl6+rj7bQGjTPZBPODjqPNTzuKq0ZiW2fNBIS1BRj/rOGqzdmufuXPNmbRL3RLF
U8BdngqaatpTb/MDsqYBrJlcruyd2ohW/Wzmo7KVkSbHYRZn5xssz2w5hKW4L0Ds
kvORxQle7O2YX/3zfrfRDhp0GQL5rQ==
=rfmv
-----END PGP SIGNATURE-----

--fvWBAkIAAADLULEo--
