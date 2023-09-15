Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0314EE6457
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 12:27:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1339950;
	Fri, 15 Sep 2023 14:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1339950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694780850;
	bh=JOeaiOvA9aSzfqtb72DtC8F5kZInpmUOpbcL9asatYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JjGtW+q/BOrP02WDJq0UYBBQ7vDE4rWB6e+y6c8Z13mcBt8hmjlJOjqCbmSRrf+B8
	 YZ40/daC48azl9atTpsDC6nmgs29XSPTQIM5RksCMLBhlbW4Oubg4Rrj9BWwVPJOeL
	 jWg2Om5yeBUoPJVf0sXk5GzDVej+UfHyvPv6Y59o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 568CBF8047D; Fri, 15 Sep 2023 14:26:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 152B4F80425;
	Fri, 15 Sep 2023 14:26:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74CB2F80425; Fri, 15 Sep 2023 14:26:16 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C858F80141
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 14:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C858F80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lqsAO6gf
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4360EB82DDE;
	Fri, 15 Sep 2023 12:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C7C433C8;
	Fri, 15 Sep 2023 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694780772;
	bh=JOeaiOvA9aSzfqtb72DtC8F5kZInpmUOpbcL9asatYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqsAO6gfiPtIyCZa6PvfTrsBBx8PbvTyahGSVVl5JCl68zD/er9oQ5a1hf9IfFfnu
	 sQtcx+14SO2pE1jJhLZmlqDM8fcWLaSaPFqbqlqBk1nkCLKU6kJePXDSRk5De4cW//
	 zEJGITFYLVuM9LLOhNUb2phka7l8RsUko8Dh2vNwb6yO0h0q96/3qMpAAamAqC7Ya6
	 V4JJhMHFT0YHF/F6g10zOyvXFZJ888T/ixbJ6r7LPwLW9aanT1CTrxSbRUC658437F
	 MNM7ND6wf/IVaidLRNfEtCs5D0mw3kFCCH198OD2YRGmRq7L3P2cGMiEnwbM03BLp+
	 8MNl5kLPYclDA==
Date: Fri, 15 Sep 2023 13:26:06 +0100
From: Mark Brown <broonie@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 42/42] ASoC: cirrus: edb93xx: Delete driver
Message-ID: <63fd4212-6544-4fa3-b10b-f7f38137b06c@sirena.org.uk>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-42-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WBj+u/ilrjOP7tNM"
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-42-a1d779dcec10@maquefel.me>
X-Cookie: Gravity brings me down.
Message-ID-Hash: 3TBXGFB73KOTG66O2CQIAE2BHVSFTXAZ
X-Message-ID-Hash: 3TBXGFB73KOTG66O2CQIAE2BHVSFTXAZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TBXGFB73KOTG66O2CQIAE2BHVSFTXAZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--WBj+u/ilrjOP7tNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:11:24AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> Can be replaced with "simple-audio-card" for the rates up to 50kHz, refer
> to commit "ARM: dts: ep93xx: Add EDB9302 DT".

Please use audio-graph-card2 for new systems, it's a more flexible
replacement.

--WBj+u/ilrjOP7tNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUETV0ACgkQJNaLcl1U
h9DUgwf9GWnPbx+GEF+jTZxt9NpWNVd7+WyyyAyfFMpRrGXjysCtrKkWTDFQ/uJ9
e2UK5xCHpf0WVNmGDG0WRvlgzlI5POCCE9H+YkIPBBsGQZtnxmj57PLRQpv1DYlL
YUuCITGE67RgEMwQHRu6XJh9gW5PY9deRRaKWW6+kWFNiED72G12gOB1/obftnUh
A7EowQO3vQrAGDG4dic9OvUbZ66ihwd+t9BDtWa17rmo/0lZ3eahi6hu2pCegArr
Avi5x/S2zdW2Bns7BbwxFcaYfuhX3psY9cszsw43tGWs9ZZNQIRltCi/KGONgl4H
6lDc29Bhf+aYxXDaKsch4Bq6oAxDcA==
=hBHf
-----END PGP SIGNATURE-----

--WBj+u/ilrjOP7tNM--
