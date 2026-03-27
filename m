Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A1C10F2862
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:53:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61ECB601FE;
	Fri, 27 Mar 2026 19:53:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61ECB601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774637597;
	bh=KgZQltZ3T51qJL40Die9qTtnRHJcoDyfzv7d2Ug+AT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o7G2CWQWNSUuXgGdmCHmpmpHRQdJd03V8LepiTVHYGmSTPDAK/q7vojaQxneoWZRh
	 VdhnAQSdZf/prF0t309k5MAoMdPXrc01kks88mN5ne4pcFp5zY3QcDPnXS91Nhvc56
	 cG6904lY9WfVIrembJ5yxJ8dm3/v2RKc61X1/6SE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1EB9F805F7; Fri, 27 Mar 2026 19:52:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 769F6F805F4;
	Fri, 27 Mar 2026 19:52:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B7C0F804F3; Fri, 27 Mar 2026 19:52:38 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1CCCBF8016D
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 19:52:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CCCBF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=m4HzLF+f
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED2176013E;
	Fri, 27 Mar 2026 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E51C19424;
	Fri, 27 Mar 2026 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774637555;
	bh=KgZQltZ3T51qJL40Die9qTtnRHJcoDyfzv7d2Ug+AT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4HzLF+furtQLvnj8zvX+evCnt1S61aYWdNDjNzdLKgNYDh7CxgedRx1XcyzrrG/T
	 JrQXrE9ClbzvangclhJYNVymnWR8ELz8jF/C7dR750TrUNQmZRrvbhY5Q/1dnGwUj/
	 M9uYdloFKlDKkx8I7iz2J+AXKU+hl5QrOewJomXxkkEJaQeOFwnbmMUK7DfxhBOZuz
	 moP33TvIu1hHRnpVV4UsXzBb0KCDsv07qxvLf4QEQQX4FfkjdjoEmVargQ1nPdioZk
	 5VGKpacpeNhuyZDNHW+xo+uxdhRXHxN0a9Cy//CGKvaDzEzZl3rJ2SUFbs665Hag/w
	 tDV/t2ldGpfjw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 34B971AC5847; Fri, 27 Mar 2026 18:52:33 +0000 (GMT)
Date: Fri, 27 Mar 2026 18:52:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rc5
Message-ID: <acbR8X6DbMaAhVj-@sirena.co.uk>
References: <20260327184954.2E1221AC5847@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zNivFVgAgFZfE+1Q"
Content-Disposition: inline
In-Reply-To: <20260327184954.2E1221AC5847@finisterre.sirena.org.uk>
X-Cookie: Identify your visitor.
Message-ID-Hash: HRYWLJU43BJBK2TYGR5DDBBVEL347KCH
X-Message-ID-Hash: HRYWLJU43BJBK2TYGR5DDBBVEL347KCH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HRYWLJU43BJBK2TYGR5DDBBVEL347KCH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--zNivFVgAgFZfE+1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 06:49:53PM +0000, Mark Brown wrote:
> The following changes since commit c369299895a591d96745d6492d4888259b004a=
9e:
>=20
>   Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/=
asoc-fix-v7.0-rc5

Sorry, my script got confused by me moving between machines.

--zNivFVgAgFZfE+1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnG0fAACgkQJNaLcl1U
h9AbWAf/bDsTR5ZOame1cPhGOGkfR4S9GYPBBAnxk7VhKG6PTi4tWX06nn8CC5km
+IHz01nqvaNqHDEQ3QDGGBCyTRZ41etzHSQFyixlyFPaiNRG3OqWU4kC2EIvzVjM
eB7fRhkC5ksbl0opxxrvcHILhrRUjjPfqvL3cO1recchhjt2qzEektw+Gcc3PwhV
Fp1bJCLQsGVBPhREBP1T4zOwLQiRhsL3W8G89iJpPSvmIQHGrkKt/p82orRJ/9T8
KT84fBxTJ/Q4Zm9STYnCzWIZbSWOVui7e6WRbcxMhK0wLxhfeXBm4XoHZNXTJxMv
eGp5B1sqrtoLPrG+tBpzho5/q3teTw==
=OzLz
-----END PGP SIGNATURE-----

--zNivFVgAgFZfE+1Q--
