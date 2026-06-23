Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070FDCDB46F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:53:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 441D7601F8;
	Tue, 23 Jun 2026 15:53:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 441D7601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782222816;
	bh=Kj//iDxKKNGO94PRmrPCeZ5WGPHLaxTbenqid1zUkb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OEfr9+56ZEpfTIA9yEEOWJyMIlsKCYnmGB61yayGIQ8o50xnuYBn8dkIWHDxeL9Gr
	 v3hWqIuZe4iamG8I7C1FqaIBLSuRQ93QbOTRbiishh4Ano2nJtdKx2Qtrwq5VY0QSi
	 ikpJi8hNCNo3rLmi6F4QWcCytmMkumHb6vJjtFw4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4976F805FD; Tue, 23 Jun 2026 15:53:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CAD3CF805F6;
	Tue, 23 Jun 2026 15:53:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0149AF80579; Tue, 23 Jun 2026 15:52:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782222774;
	b=LsSJ8ZtU87yeEp6GmfJvDkzSS8DLMN3rujX4x0ufC1fuDpCQAwIt8k+1doQE/xj8Kjm0
	 f3ZYd4SAy+rLiLYeKbhaVdyX9tb+TBYYXwIwElHepFJKCGxuEVoVmUpsa0acwIY5nWbiE
	 QgQ1ZEj8j9VFDjF5VgapQ38mCRpL/Hvk/T4rqHYSMbUjI8bQlB8zUJUAxIoGUdUgw9JuI
	 3VyZZkEfASe/LTEJF6k8Llv3fyoWtTLBZ3P3XSMKv7oSpWze/MKz5Ytibjd/WpbTD2B+9
	 Jlz2CIJV7RARratjtZ9r3ELHhb/SB970FG68qbP8uwxaaOlMY6oRKUafPGkXDtTGgkA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782222774;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Kj//iDxKKNGO94PRmrPCeZ5WGPHLaxTbenqid1zUkb0=;
	b=KZS9zg/slphQYZV8mWIdhacdH0Dn2JHO/QB30vzVSVaLi2lbvU9RLTlDokLg8aB4jC/W
	 kTUHX0uUVdGhmfq6PmMp6uZJTlp0APiygEQf8pj6y89HYIsBeKaHkmXF048cbTJwNtdrR
	 rtG9wSYKFlVzvH5g3CWACOKKiRh1oE7tB4scIyrfOnjgEfLCyBOQ9v+kr/1uAkEFSWS+F
	 QPSOWsdjXzSDc8kgMSvtQw2wb88N1bGrV8v6k7bjy5XmFd1zJVRVi5IQ8cS+2gt6KcLwu
	 bBDFtDOiqkas2XkLGNTcr60aUx/oY6dAbPjVRH/Oxz0itj+stAB4BlX7aB+CuQFJWjw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jPnaLSnk;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 077A9F8045D
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2026 15:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 077A9F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jPnaLSnk
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81DB060120;
	Tue, 23 Jun 2026 13:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6843D1F000E9;
	Tue, 23 Jun 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782222770;
	bh=lGI0sZSXc8SvaXMLzfHNSmXWIA9aqB34bjuUUBKTQIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPnaLSnkotWRjHSMTpGwUsWe7jHIkowUlZmCrPEhOXdxtI+5EM6OPJEvKG9KcSXe6
	 1DiQoUAP3wTZJ0Of6B/h09Q8f0Bb+5qU3m7Ja+OdL8pyIcGQJ1J5UvtAemddFuyRSq
	 qA7IZlVgwF+TYQdotrEQIea9O8TzzAN78poGnDS3hIrVBSSok2OWlFeh/QfYTm3gfV
	 IUYurPzg3Yap4OvxngQ/FSlSBrrsT5ETZcjEwzdW+XzoUXjWc0zkAn8iDQJVuSKPIJ
	 NPpx8ezYf7tF0fVyL3jUUfiYXJ0lEqBItECudah6aXUHFdMaMcYU4PdDXc5CU+ryuv
	 cYB715rO95dtw==
Date: Tue, 23 Jun 2026 14:52:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Shinhyung Kang <s47.kang@samsung.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de
Subject: Re: [PATCH v2] ASoC: soc-compress: fix UAF in soc_compr_trigger_fe()
Message-ID: <fc79d89a-472a-4ead-a581-8571acbe4c08@sirena.org.uk>
References: 
 <CGME20260623113157epcas2p24944f3b44efb5b5c771d502148ad8e23@epcas2p2.samsung.com>
 <086101dd0303$e6702f80$b3508e80$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+zNHt22wbYKBZ8D"
Content-Disposition: inline
In-Reply-To: <086101dd0303$e6702f80$b3508e80$@samsung.com>
X-Cookie: To love is good, love being difficult.
Message-ID-Hash: 7WGG7R3CHM5LYF3JTYXUQIWKMZTLIOZL
X-Message-ID-Hash: 7WGG7R3CHM5LYF3JTYXUQIWKMZTLIOZL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WGG7R3CHM5LYF3JTYXUQIWKMZTLIOZL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--x+zNHt22wbYKBZ8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026 at 08:31:57PM +0900, Shinhyung Kang wrote:

> ---
> Changes in v2:
>    - Reworded commit message for clarity.
>    - Resend due to mail client corruption in v1.
>    - No functional changes.

This still doesn't apply against current code:

Applying: ASoC: soc-compress: fix UAF in soc_compr_trigger_fe()
Patch failed at 0001 ASoC: soc-compress: fix UAF in soc_compr_trigger_fe()
error: corrupt patch at line 19
error: could not build fake ancestor

--x+zNHt22wbYKBZ8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo6j60ACgkQJNaLcl1U
h9BAfgf/WYF3HMLTwd+A4P2+OK0qWRl1aY/6hJFO6nxZlDX5nJ+D+6dgR10HaOt5
l5ygU7P/YVqbOBNleOt/enqDyiZvYE7lrh+BARv6WjAUFcgVRgbY0sFCzRL0+P6Z
KqjpnYZRhzarTzTGLCDAOY7NZSUu4IUhmLKm7ThONuMjj0p0fBmr7LYu3/1xNmKp
fCYgNpMsw7EtPimr7Zyvi9fWNNq1+BTvl1oORCkfUMynuDRYXq2oK8BaNdt7fJxG
zgTu/M8QD7lCs4oVCQc3e3RF80WzRjMCDs4nM6LIXkndcQjV+F6cuqwZo76/VDCP
8g3yJYpbWdzoBC8KWehU4zb1XNqLVg==
=CMls
-----END PGP SIGNATURE-----

--x+zNHt22wbYKBZ8D--
