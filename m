Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E530C04AA9
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Sep 2023 16:00:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35BF69F6;
	Wed, 20 Sep 2023 17:59:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35BF69F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695225646;
	bh=TgtnsvbGOUf8/0QiUmZytL37sBH2oYZX/bZUhckgbWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fa19N2M4TREbo7uHIXGmdIPqZhd9Lr3nG8ugXy40EIsgNAJHjXg+26ZwJ5T3/WMD4
	 DnLXwaFRapfS5BfNdWFyzyUVuPRcuHDkVtVuQv+g3kvBJ1xvXmMshVZNOlTTzcrP1E
	 2+TKOzl1o8Fon5UhBl0vxvcRabQ9w2peZFmdNAC4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4A41F8025A; Wed, 20 Sep 2023 17:59:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B830F8025A;
	Wed, 20 Sep 2023 17:59:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85D63F8025A; Wed, 20 Sep 2023 17:59:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE827F80125
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 17:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE827F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZJkPEMCB
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF4761D18;
	Wed, 20 Sep 2023 15:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E8C433C8;
	Wed, 20 Sep 2023 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695225578;
	bh=TgtnsvbGOUf8/0QiUmZytL37sBH2oYZX/bZUhckgbWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJkPEMCBo+sXlFkUNsfJxYxt0aDsH8bSEpxSVkhOlXV8YRypx58EO6CWrZiWsKb1M
	 FDDK6ykYVM6VWpu993IiZiF8hm8CrMlDczIeOuLFFqVbU1QNta1+1PLawVO5tlEdid
	 B10WocAKfwAbIkD3GggqrFQsJ79ofEPp+h8eNjStcr0U1ncEdM9XHTAwcu8wi+a23X
	 4NcyNZHzvgT2KtQk33pbRHMNVRK4qAsq7C2L3qIbvI4RIyeI402aF6vuSg2PE30b55
	 zQ9hd9WNZSDs7qD6KaXrh93CPnjJZkjfHKERT7BFjIcri9H4Yjrie3P04D/Ykha+0U
	 rEF/Zj6gdaI1A==
Date: Wed, 20 Sep 2023 16:59:33 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
	Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: pcm-test: Report cards declared in
 config but missing
Message-ID: <b1658cfc-74b6-44c5-9e2b-816772ff58a1@sirena.org.uk>
References: <20230919152702.100617-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TR7m/tl8KYNB3BtE"
Content-Disposition: inline
In-Reply-To: <20230919152702.100617-1-nfraprado@collabora.com>
X-Cookie: Even a hawk is an eagle among crows.
Message-ID-Hash: N7GG66IAEWDXH32TJ57NOVCKLJD67AMC
X-Message-ID-Hash: N7GG66IAEWDXH32TJ57NOVCKLJD67AMC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N7GG66IAEWDXH32TJ57NOVCKLJD67AMC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--TR7m/tl8KYNB3BtE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:26:21AM -0400, N=EDcolas F. R. A. Prado wrote:
> When parsing the configs, keep track of card configurations that match
> the current system but haven't matched any card, and report those as
> test failures as they represent that a card which was expected to be
> present on the system is missing. This allows the configuration files to
> not only be used to detect missing PCM devices (which is currently
> possible) but also that the soundcard hasn't been registered at all.

Reviewed-by: Mark Brown <broonie@kernel.org>

--TR7m/tl8KYNB3BtE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmULFuQACgkQJNaLcl1U
h9Ahigf/dKE+gXp9ZH4jZ1QZyixn2tKUPrKHFW0rcLc22QxUNfiy8PHk75LjKCXJ
o+rCl7qjgygLrfSiPNOsBbqeoW+v4G932AuYCGpMZKI2/u1oDTNg7NTnBcJTw4xz
fDYMOrZ+1z96gZHeOAZJa3C10hgkWMz72duAVMWb4b1S03kyRY7EboUzFc5bgqSi
SpnwJoQweI0DRjAsK4FoITvWctL4krn1l5eMOClIIA9CgHZKjORGeQD6ReIDZ16N
Dwkc6jRHnprFA4bWxcMCHzCAIY4MdP+EA6B2i7baLfwodjo1tRNRCUDXPXworCwP
e7QJf2nIQGkX9IvdZXSwXkwcZxgWMg==
=XtEC
-----END PGP SIGNATURE-----

--TR7m/tl8KYNB3BtE--
