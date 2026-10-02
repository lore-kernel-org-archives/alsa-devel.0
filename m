Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C89CA5FD4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:05:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89AD66028A;
	Fri,  2 Oct 2026 14:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89AD66028A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790942753;
	bh=3ppz+0+KC8RglXupDw5XvzdR0ItiGOGYf6l0j5c834k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ggwqwElrOiqHyQCowjieG55PL6h54Pt8raQf1bsoOpWFzYbXk00GCDmdYuCC4qrjh
	 HdRXaKbt+5uwNtwBTRELD3tSYihdjorMI7nqm2aboYtAN0KlvgEC/84WFfyGLxRHke
	 ovYe1KZHTUi78ZQ6gKvMlDn0+zHireULWUpNQjHI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2C08F805FD; Fri,  2 Oct 2026 14:05:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A47B8F80601;
	Fri,  2 Oct 2026 14:05:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50BC5F805BA; Fri,  2 Oct 2026 14:05:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790942712;
	b=DlnTJ4B00cHr9OOOEkjwb6ucDhloEnvRtrbx2FFc4KgvNJXfeSUq4gEQqpJ/mKMubZ6U
	 UPb/YgncPyoTKzsuTJQXPHvaW+76AVJuD2Ilivy39uEapV7LheencnbGTpdkw+6wzzFxC
	 gJIPCkgkmP3GOjRBFHQUeltWdFvlZlg9bei9EP9eNoMXhcnMPZz5mPxUSy2XaZMyI1Nlc
	 dZFhjARE6yTdeASOcoT/iK3sK9m/Ce1G9hHQslLcx5uH8CNb8bilo3BiE+pB32GklrJ7f
	 Bao3R3hsVZYkW1ih++fpqTMtLVAceyfbM3wjj2ztd5bSU8K49hElWMV2N5BFmphpajA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790942712;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=3ppz+0+KC8RglXupDw5XvzdR0ItiGOGYf6l0j5c834k=;
	b=pPCyK8B9WqeSISaIvqHAQx+xtMAEI2WXN8V+qV+fcw2lkRaCzSrVuQmV7OOC/N2m/gAs
	 M8lFVE9B37kINbSbcESYgmySEtVqU/wyLaP3OaRo4P0IcGrVnIl64VkDZrpmBJnswVGOP
	 E7DnU9o8jmufmzYwU/NAOmdLY8mbhE+wqguQELvGdA9LBcyxm5Qhsx5bNDDAdqYl3oUP4
	 wTOX54MqH5jpVSetBAN5SndbCMpZpP0TlPvHBYZH1V9KVrUDfWdKZHc7I85HCN6NMQzyc
	 ebrSOgfg+WEDdIIg16kZiS+Q+E5ySmxWGqXpd/XXY/eRbe06PwPXiClnQnI90KH3vrQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MDEfR6Ho;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CF19F800B0
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CF19F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MDEfR6Ho
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 004F860A70;
	Fri,  2 Oct 2026 12:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A324F1F000FF;
	Fri,  2 Oct 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942706;
	bh=gaSbE/diFRPGNNC+XPDwbrpG8w8gTuZ71z6p6AbQaPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MDEfR6HoIgDfSqOvtOjcUMW/x+U1N3y8VOGZNY5NF3Ixgri3nnd2ZaWAXqmymJ5+Y
	 v9kJ5SNSfWdz4g1WMgkNdicwmnixLaF0YKv27OzUBWKQaLDaSTIvEespcf2+8ElXsE
	 EYDdLvUxFIcDfzWLeq8J3Ep8V4uXLs3EMGP1R8btvTcYRHvtb2rIaYg1SIAzR5ZOEr
	 hJ32dHsh6qe60PUJ65NHAQWlX1nFTcPtX0JKm3dz9FyWFZ73ghQkieMPlx+5UxIeVn
	 mGxrbW3qFyw0ZKsC74jZATZZEg5PVTZ7ZK/fJRtxsElST5SZlxeLtfXkTNEW46hFaa
	 oxJeQzVXaQoYw==
Date: Fri, 2 Oct 2026 13:05:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc5
Message-ID: <68deab21-b10e-47d5-b0f3-f533c995a87e@sirena.org.uk>
References: <20261002115438.DD6341AC57CB@finisterre.sirena.org.uk>
 <877bk01fii.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d9K1qqkfkzkYn4k5"
Content-Disposition: inline
In-Reply-To: <877bk01fii.wl-tiwai@suse.de>
X-Cookie: Measure twice, cut once.
Message-ID-Hash: CDBMRETYGXHR3B72JHAGCULQYIOZDT74
X-Message-ID-Hash: CDBMRETYGXHR3B72JHAGCULQYIOZDT74
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CDBMRETYGXHR3B72JHAGCULQYIOZDT74/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--d9K1qqkfkzkYn4k5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 01:57:41PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > ASoC: Fixes for v7.4
>=20
> This is meant for a PR for 7.3-rc6?  Or really for 7.4?

v7.3, sorry - I thinkoed when I was typing stuff and fixed up the tag
name but not the subject.

--d9K1qqkfkzkYn4k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq/ne4ACgkQJNaLcl1U
h9CnpQf9EZ2p8fTtZL7ztr6ap3dqTdgl7Py6wi5vic8PC2FBXhy4mnbmTqlL9ftX
7bl+TyNCb2SFAY0L9fIoU3CgIQXhYSeUOnQIfgxv4t29NGXKz0Rs0EOJ1TNcoz4t
6jpIW0d+rtFv5Ert7pXxSh7zmLnzQOxM6QhGRo24DbWqEOKd/h/wfPp4B0J/uJ//
DcWv4glorolT/lmZ0b/FYyY9QBAg8dqcoigS6LOpTu3eYjsCRtYCSfOZNKc5s6g9
qF7ZZlNWIQfl1+Hjh+7PBLh0wW8AUCg5TlqVcgVp/IsIimv8BJq9onIE/THyasMg
cqzqLgHEtkX2gLH/CDg5jWminOamKA==
=UoQs
-----END PGP SIGNATURE-----

--d9K1qqkfkzkYn4k5--
