Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F7C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:03:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E08D2601F7;
	Fri,  3 Jul 2026 20:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E08D2601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783101826;
	bh=T/5o4JJSPPY1HOjY33cpRvY4ZvNp8GJzsvZuwJsR430=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y/sjUFHSP8C20/CeRSUj0lRcW+MS7OiFr9iEg0sQad7xUufJFvDz99IP/W936cYPE
	 mN7C700JM/w+Ofu+3c7t0pB0CvindpnSUBHeLrUT10Zk1Nnx0E+9uG4OgXMz2OC1SQ
	 v5u4LpidbocjmkJmXMk5UpBYa0HU2O2iomWOgFEg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68932F805F8; Fri,  3 Jul 2026 20:03:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D56DBF80579;
	Fri,  3 Jul 2026 20:03:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3728F80579; Fri,  3 Jul 2026 20:03:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783101787;
	b=jRLYBC1V503/2vY+pIjnbT3OrdeUX5nNcPJisl6xE2n2eEbJ+3hUFhMqxT88PuA36U8k
	 0f5jn+v0bh/il0Rq757FRKzvuptzdvjMP/VhNvHBo7l5lMVkKtC4jIgQiCUlobV1Hm5QS
	 myQNWsS03pVbQaeYzx3YEWzUlQQ5RryqUnNFgHTXRzrNxsaKJBp4M0tKRqgCJL6RMzMFj
	 ibTU0ollIqS7zaN099avSwuxIjsJD7ctvVZztji9hrvwQKbkMb5pFGwHx2RsAPP66syOU
	 hyUDvvbv4ic4EEiszGHbKn/AffcKrrE+6iW4LZQ2tWy+Zba1VrZSWcFArtdKZoT02fQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783101787;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=T/5o4JJSPPY1HOjY33cpRvY4ZvNp8GJzsvZuwJsR430=;
	b=lPAZpBp8NrixQjw8a40BWy65LH4ByGnQ+VRA7mKjKWOXgJeeiOGbMIfoDKnituIHrLJq
	 RvLyH2Z4Ii1tVbUKcXdKYQoSzYw6aQ7SD1JyzdA7hgo500BhlHJPz3rcq6+zIXtHkqaSC
	 4hOTRRUyAj74wbFJMRkDGXJLG/SA2Qd3Q9dEjuCbgWU/B9vBbGaHvGeqRETUFnpnwYwgA
	 2NsxQRiicRGcY3Pl8fJqmZ0Zsd24I4fa8WAt7dskVQpF0RjMvTHOKx5tvP8gtkJgjSVSH
	 c74BA7fcteeQskPP9EhJuSWJq7zN2NB+++AYDEXE7xVTfIDlgGG22pLRqSRcMb1pA0Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bHXr5mcJ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D5D49F8027B;
	Fri,  3 Jul 2026 20:03:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5D49F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bHXr5mcJ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F7C060051;
	Fri,  3 Jul 2026 18:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6427F1F000E9;
	Fri,  3 Jul 2026 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783101782;
	bh=T/5o4JJSPPY1HOjY33cpRvY4ZvNp8GJzsvZuwJsR430=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bHXr5mcJxAmW70ggFh1D31ClrqSWO3dy7kEsQ2rc4Vpercy6toCyCHfu5i8jbX/GZ
	 HgwALQJXZ0FxZdEwkDTFeVzSgAO6PasTSImXm4BusW2N9YquMmhwtY2t3TimDr+fA1
	 rN6H0B4D06wQ916+kPLdvxTKKQ4vWrgZub0Arglcd3ZT2Qze23sIOILIPWFfYHrvwZ
	 uRz8YLHYL6N90rEvTsvvW0zpRWLewPWSNhj0Y9oiMfXJnLwji+sS+nwu6Qyb3ykkp0
	 J/U1C2G0u6oDxI6vBDbCcOZNPZQXEDM1KUXVwxyYW4Czpi3gylJQ4E7yp2LySVJVnM
	 B2zW0d4dOWNuA==
Date: Fri, 3 Jul 2026 19:02:56 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	mario.limonciello@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for
 ACP7x
Message-ID: <168ec38d-3db8-4e3a-b7d7-fffac654bed7@sirena.org.uk>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
 <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
 <68d6745f-8bfd-4b1e-b4f1-33190038566d@amd.com>
 <632c9729-3f64-41fd-b85d-18f4437a68df@sirena.org.uk>
 <04ffb72b-0027-492d-be0d-4b4178e21e1e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I2XHIjnu5yiSaqR/"
Content-Disposition: inline
In-Reply-To: <04ffb72b-0027-492d-be0d-4b4178e21e1e@amd.com>
X-Cookie: Another megabytes the dust.
Message-ID-Hash: ZUAD4O75PVXAEJD2QG4LIIES5UI7PO43
X-Message-ID-Hash: ZUAD4O75PVXAEJD2QG4LIIES5UI7PO43
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZUAD4O75PVXAEJD2QG4LIIES5UI7PO43/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--I2XHIjnu5yiSaqR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2026 at 11:21:21PM +0530, Mukunda,Vijendar wrote:

> We can drop IRQF_SHARED flag, if that is preferred. Please let us know.

It's fine, it just wasn't clear that this had been considered.

--I2XHIjnu5yiSaqR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpH+U8ACgkQJNaLcl1U
h9AQ7wgAhBjKPb3yCLyVvni34snV6a4xy8dhEHg3aes2svch8qBjnZBK90gIeDZl
ke/d6M66cd7T1kz1Kui4FkNfoUYwQqGsIifXpu7Eag4CNVf5i3DT2Jl7oV8Nl3x7
llLMLa5yCySX5PAP29Py2155XXnqr7jtzbhkXbwwkvGs3vJz0Q4ZH3J45+GIwNmK
VABqD/j3D++MVNE7pI6Uo4KFUN7g5jYJ4q9tKLCDzEXUDvpzNxncfTV1SHtb73l8
Wu88/2JzfkX5wXVj3+VtMnKVkPnA9wYwPdmDhCi8BvzYM4Myw1mmPclbZb+k+NSN
JD5jkULRHfKWjhonc+P4HAh9OmBEhg==
=WfaS
-----END PGP SIGNATURE-----

--I2XHIjnu5yiSaqR/--
