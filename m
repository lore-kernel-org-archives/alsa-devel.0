Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8631CC27C53
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:33:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78BBBDFA;
	Wed, 12 Jun 2024 17:33:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78BBBDFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718206421;
	bh=A4LXxVy38n/hdJk7+HDkZy7E6cYBqwA9u3vwpbFPPpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tX2UmvRPlhpZM7I0l+uzVnZHy6T2MorjI6r+UKwaCsVwVALNSNfenfZnjG9wBQPzc
	 HN1iWR8CRMxb6ZL0hK2g4S/XQcy+N321SUq39itaw5QGf0V9UK75rhz0Hrg6VDJFuf
	 VFf88uIfgLqPdllEeMS5hPMOPKs69/impgrzLjvo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71FD6F805AB; Wed, 12 Jun 2024 17:33:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1588AF805A1;
	Wed, 12 Jun 2024 17:33:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15E14F8057A; Wed, 12 Jun 2024 17:33:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83EFEF8010C
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2024 17:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83EFEF8010C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q1dk2jb0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3AB99CE218B;
	Wed, 12 Jun 2024 15:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B0FC32786;
	Wed, 12 Jun 2024 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206368;
	bh=A4LXxVy38n/hdJk7+HDkZy7E6cYBqwA9u3vwpbFPPpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1dk2jb0rep78D4tnoiuqiiBrgVtN1bUOCYTIwfvuZ/b3q38BkVLLJ5MUFll4BYN4
	 DFUUEUezYt0Df2uShLAIVdPsleyPJJRzC0XkLqYbAW3wQHnvp4rL+zrU0TpyyjQtBe
	 N+ee/D0QPsI5VvieCA4hGr3aSjVy88FC5vtJ42lU45zFYLiIBOpT6Sf6OzAqE5CUe4
	 WPwI0kEt9/vo4Mn60rhgalqzG5vbZ/wh5ebbq987KmbwqOoktgO5k7UK9XAPZgtrjA
	 lo6XleH3JWS3aOxcj1yR/OzXsYsqaYQ4HIrvF1gra0iGOoMfQ83g5WzNZYjGQay83j
	 CLezwVyROkCmA==
Date: Wed, 12 Jun 2024 16:32:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI
 is hooked up
Message-ID: <Zmm_np5cIF0MSE9U@finisterre.sirena.org.uk>
References: <20240611145746.1454663-1-rf@opensource.cirrus.com>
 <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
 <36219997-397b-4a26-96ee-7527fb6eb024@opensource.cirrus.com>
 <Zml2FfjbO4Vgk0jy@finisterre.sirena.org.uk>
 <92f2d6c6-2d63-42eb-ae91-59a14831145a@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ws70HyzkY6K4LGiZ"
Content-Disposition: inline
In-Reply-To: <92f2d6c6-2d63-42eb-ae91-59a14831145a@opensource.cirrus.com>
X-Cookie: Your love life will be... interesting.
Message-ID-Hash: 5KTHKW5ONMS3O7INUG2KEU6JMINPHRSH
X-Message-ID-Hash: 5KTHKW5ONMS3O7INUG2KEU6JMINPHRSH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5KTHKW5ONMS3O7INUG2KEU6JMINPHRSH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ws70HyzkY6K4LGiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 11:42:15AM +0100, Richard Fitzgerald wrote:

> I can send a V2 of this patch with this long explanation of the
> background. I didn't put it all in V1 because it never occurred to me

Yes, please - it just needs to mention that due to the firmware we don't
have hardware defaults here.  I think it would probably be more robust
for the driver to just set all the documented registers rather than
hoping it's set all the important values and needing to keep adding to
that piecemeal.

> that defaulting the mixer sources would be controversial.

There's probably a reason you have all these use case specific
variations set in firmware...

--ws70HyzkY6K4LGiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpv50ACgkQJNaLcl1U
h9CtUwf+NBoXGau3/eYXKr81FuNxSnOhRdPBQp57iszrQ4weyqBab6t0wWKr5pUQ
AHAj4nwoFFaiehndPQaQol3kxvrrOn1f4vpk+n79F/eksHlXk6GOykyueklNlD99
Y2g+k2uETzBOHPTosZ99RQbLRj6aGVEWfAItaP5tAZw53ryiRcFrRTXlywlnverP
hS/uEt2Oi6SI+qdWg1BVx2+YPqbk/OnxucbLnyl90xOwa0CdZbbyIcD9rmIi0+c2
zS7t3m0NIHuiI5gz4vFChPQubxf/OSU2kwJ1O57WFySsXu0cKxI3kv2kBmURS+uS
A0UJPakozVyIIiJi2nw64Hl0IJDTcg==
=CNPA
-----END PGP SIGNATURE-----

--ws70HyzkY6K4LGiZ--
