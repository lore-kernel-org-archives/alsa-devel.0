Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44465C5475B
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:13:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAA77741;
	Fri,  8 Mar 2024 15:13:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAA77741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709907197;
	bh=E2jQGhctqhdTeyf9K9GCx+OjkomQmjygegGT1CBBREQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nVjKWU1CO3tqyyKFv4WkRd8aCRKTsvL//rxKd1wolyMnANDHTFiZjgPlHR5Zw3LHX
	 qz+H3KSwCr99WXZ2hBMI1eF46W9vHw4snM8JzEVvnk50UZgvqjg1ZnqIxSjWqOuxfM
	 +h+aJkRPYr2WzmvCtwIHAyU0Xty6hwWZpY2OKZ0I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7B94F8057A; Fri,  8 Mar 2024 15:12:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03AE7F805AA;
	Fri,  8 Mar 2024 15:12:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70A8EF8024E; Fri,  8 Mar 2024 15:12:40 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A58FF80088
	for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2024 15:12:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A58FF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GI24qi44
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 37639CE25A6;
	Fri,  8 Mar 2024 14:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B52C43390;
	Fri,  8 Mar 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709907153;
	bh=E2jQGhctqhdTeyf9K9GCx+OjkomQmjygegGT1CBBREQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GI24qi44A/VKrjHaZyry5snyO4/S802K7VYlZx5PFgC7N79guUAXhow08Urp7MUAK
	 ByE8lXVWDynmqBRDBgcg/wTmFHls89Nsbatq/i9pifile8ZwwfDSBJdF4Bf55YE9fh
	 EuHcsPsvO5TzB/cmJW04FgYGCJ85bffDyTvDmR5H6HxfDE2lO5aD2uwg1AvenRILIy
	 wnUEEKlLysKL06eTY27BGRD2qLD2eTxah7JGI80+QvEnlQ3AlxMAcjRJhnUVgmJwHg
	 GR05l60AYWnmAW1L0gztoN+bUZtf1y9dniOxOk1/GPl33MMBTUXX3bqEGBNI5SdXRt
	 01DmTSJSzzDGA==
Date: Fri, 8 Mar 2024 14:12:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, hdegoede@redhat.com, lenb@kernel.org, rafael@kernel.org,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs35l56: Add support for CS35L54 and CS35L57
Message-ID: <275d4e66-dc76-47cc-9681-e60b218a8cc7@sirena.org.uk>
References: <20240308135900.603192-1-rf@opensource.cirrus.com>
 <20240308135900.603192-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UB2zcriJOOZ1VYZ+"
Content-Disposition: inline
In-Reply-To: <20240308135900.603192-2-rf@opensource.cirrus.com>
X-Cookie: Isn't this my STOP?!
Message-ID-Hash: QHTRS5Y5GW62FLMLRWPX5O62WDSC5X72
X-Message-ID-Hash: QHTRS5Y5GW62FLMLRWPX5O62WDSC5X72
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QHTRS5Y5GW62FLMLRWPX5O62WDSC5X72/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--UB2zcriJOOZ1VYZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 01:58:58PM +0000, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> The CS35L54 and CS35L57 are Boosted Smart Amplifiers. The CS35L54 has
> I2C/SPI control and I2S/TDM audio. The CS35L57 also has SoundWire
> control and audio.

Acked-by: Mark Brown <broonie@kernel.org>

--UB2zcriJOOZ1VYZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXrHMoACgkQJNaLcl1U
h9BJNgf/col+eBURywhfhU3h5mWvgk9QsAP/3Q91Vw+e7Gs1iqslPA8VMZ8hEEpl
ju6worO4W2byKRApwSBWq9otMb6RHqliZPejYB+CYMjEmd4dGMYN9a23NXDGE/Kh
0naRleJyq2sT3icE9dkxYav2I3wGKlekSgnyKeO214cm91kdfA3YrOn1ahna6Wrq
dZQagOFwx7/Vg33BBzOvMpbaVMtAQTcTcnk4QhaLQbOJG4tezTQHXKis2hnHDOsI
ah1fvI3VC6nUIZDGEIZPb/Hmi3+gyiWrPyH2jmj3wUg2bacHPHJHYCxjIt6AOFKx
H44hhHYLhLuzmJXgiVshJBxdsAwHbQ==
=kY3n
-----END PGP SIGNATURE-----

--UB2zcriJOOZ1VYZ+--
