Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D085CD98D2
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:43:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02588601F1;
	Tue, 16 Jun 2026 22:43:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02588601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781642608;
	bh=ygPWgmGT/DXIysqOUmGAPtnBbZKpWfVLvXELvkW55io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VTdpFxWXKnEyz1H+00Q++CRkkJIkV20INw1FwwKmZ3ld9wN7VZh/G9MH7N0Ojfos/
	 P0PtKeXIk+P37KuIbaq3UJvwSmb5OaQXRovVF3OGkagDgV5dSG5blMwPJmfSmTE90a
	 LC22PFLHOLnqH8Uuz+9QhTz9iT4okvkQoG/keoMQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BC93F80600; Tue, 16 Jun 2026 22:42:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2EAFF805F9;
	Tue, 16 Jun 2026 22:42:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD186F80495; Tue, 16 Jun 2026 22:42:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781642565;
	b=B/NPSTsIIVnFvwIbJnbjHxXxiQVFG1eJJiOrfT9tycxAaMTKePCN2pOewT++lF5XoDBV
	 BRyGE+oKIC3WzcbNiO0kAufkkNkmPvf+8Ve4s6eyUvorbjBynBFBXRmOBCfA6z6Q5oaMv
	 OmFo7I+dh+8F181kXgyjZzNX45HYPMC3SIAqM5YuIw5LYXLCJ7gAcMNmsNK+0grFoQ0rJ
	 czUjtU3kWkVPw9sEa+iocNw0qgPpp6RNMycLPTFbF0vy4lzMzbZ9WlJgZWfQhDxb7nV6K
	 DTcZ9vsYPTGag9xVPc2kDnh7SGSS2MXTdVeE+D7VT+Pc5UvdqTBnMJsVorWnt2Ka84g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781642565;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ygPWgmGT/DXIysqOUmGAPtnBbZKpWfVLvXELvkW55io=;
	b=jQWyMWFkjurpiB4aqu7whHULrG2wLcXvYredEhPoaxrhLlWkBihXuWmH8B6t9TvmE8u8
	 RT0gzWTaIFg54TLcPjoRvF0mWQEg05PiaxhT3YZ0kyPYy4wvxNyze+uQWmSXFYrxX4bhO
	 TJiUfGFx8FwNu+MIc3glpr5oWq5jKeDFGGwUht7Curr5/FDrhpvjPlNPCXrxGtUbpr5Cq
	 fIgYIVdPI4N+FrBq095i3C9ZVBpbQfIKzWeFWpXj1jF9+9C69QRLVukOZvK6DOBanJOml
	 BgTcc/AfJAzf5piL0RIItbtNWh3kGhG5jGPCKODhp4HaVkXjUZi4TCAYeMz28U0vJOA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="FLUG/R8e";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18502F800C1
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 22:42:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18502F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FLUG/R8e
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CDE91600AB;
	Tue, 16 Jun 2026 20:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5BF1F000E9;
	Tue, 16 Jun 2026 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781642561;
	bh=ygPWgmGT/DXIysqOUmGAPtnBbZKpWfVLvXELvkW55io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLUG/R8evecQCjucbG941E3ewfExhz5x/R5hoGOuQ7x/91PWkK3uXWjHCttQqxjSp
	 nCjvMR734NRYf3Reow8ObYKytmjGtZs9vLARET7FipLY4eqOOy7G8axzmMScXFU/R2
	 Y5aJx7Kmky0/Kaq8Os2sbfUAp/j/1qksdIRYPintdNo8NtkfEN+TGJEz30LYjMvHHp
	 e4NsPIDGeuTy1l1nV3yNIA+AByTZ7zqvwPXK8JQhA4yWRuw5idQTL+j5Q0trFsZplf
	 74iyVkQ1Vkik1ctRfLVCh/QaiXhsX5uXP5ONi+pgJw1p988mkMPVlLFhfSd51Y90ne
	 vmYGgQ4Y2SjoA==
Date: Tue, 16 Jun 2026 21:42:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Shinhyung Kang <s47.kang@samsung.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: soc-compress: fix use-after-free in
 soc_compr_trigger_fe() during BE list traversal
Message-ID: <3dd42c1f-6205-4e56-97f5-9baa61b2bba9@sirena.org.uk>
References: 
 <CGME20260604065510epcas2p4867ac51f94ba7385d72849b573b44976@epcas2p4.samsung.com>
 <000e01dcf3ef$15d69530$4183bf90$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnSX+Bv/oCMTCGgD"
Content-Disposition: inline
In-Reply-To: <000e01dcf3ef$15d69530$4183bf90$@samsung.com>
X-Cookie: Password:
Message-ID-Hash: T7Q5PUR33MHVP7WSAI2QEZ4TH4CLYDOQ
X-Message-ID-Hash: T7Q5PUR33MHVP7WSAI2QEZ4TH4CLYDOQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T7Q5PUR33MHVP7WSAI2QEZ4TH4CLYDOQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--hnSX+Bv/oCMTCGgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 03:55:10PM +0900, Shinhyung Kang wrote:
> The DPCM compress trigger path traverses the FE's BE client list in
> dpcm_be_dai_trigger() without holding card->pcm_mutex, while
> dpcm_be_disconnect() can concurrently remove and free entries from
> that same list under pcm_mutex protection.

This patch seems to be mangled somehow:

Applying: ASoC: soc-compress: fix use-after-free in soc_compr_trigger_fe() during BE list traversal
Patch failed at 0001 ASoC: soc-compress: fix use-after-free in soc_compr_trigger_fe() during BE list traversal
error: corrupt patch at line 10
error: could not build fake ancestor

--hnSX+Bv/oCMTCGgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxtT0ACgkQJNaLcl1U
h9DsPgf9Ga0EY0r/n84dp3DTEE3Z/CrfoZR60DHm7m/ZqS2ZibbqdzNH/4jp4Klv
FRJtZ8mZz71FnMZHRVApomnj/7VPubEQwxMWmhlIwhFvHeUsc9IiutIUMKVnH3K9
m7rWSxrwfLgl2q+1NuNO1exOlzD77u2Nrx3dW5Ew6npKTk2RNdEDI69tOQFaeUhQ
xPB70HYKJWb3p6mTFs52P0QhiGilnN0y8PY5y+EjzQJkq1NCvrDzV+Kg0uYBaRbE
XJKGRRVGRE7q4rB8HLlvTuqHWpdRM5gX+LIGqIQHIEJJx3bPUhTqQEZhlxX8EH/2
lMCACgBWe8xRD3qPBHonz+CmhmCWRQ==
=WkBK
-----END PGP SIGNATURE-----

--hnSX+Bv/oCMTCGgD--
