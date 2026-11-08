Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B9606A321
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=MZ0LzbKC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3jZ7sEZ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B9B4601E2;
	Sun,  8 Nov 2026 18:06:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B9B4601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794157600;
	bh=OBtzH8SdKX6PFWDQWi8/2OLkMnONA7NSL81PIjNaI1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MZ0LzbKCYJKV2PX38HmJ4cWNr7TsNeWpUn/1z0hCrhrZk9h7hdFqhEK0nnQ4/Y7F0
	 SJKkwoaRge58adhxWlmkYp0jgdhYryQZrpar322XvRjjSlnIDcB8vL2FdwQH31UzK+
	 CYJTW4aKRN2T/msD0bPijvJE/C3/qnrt8e0NI+bA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDBF1F80602; Sun,  8 Nov 2026 18:06:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E8BAF805F0;
	Sun,  8 Nov 2026 18:06:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4D44F80538; Sun,  8 Nov 2026 18:05:58 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794157558;
	b=jAbMoqeohI7Q00DDlgopHe3P6dl8HHq0e36OJE8LJU3Rl0/2Gu2Ks6eeN8ui+1HitVQP
	 GkIPFgBMAmlae/gVMimuN/XCgdclUkmXLGtQv4opp4TGUzEKvkjebL6VUrRpJFUdbtqoa
	 kPTRiOseSSS37t73hxBDSLEYH7zKEaHo5vqr0KFGywD903tLsv1VwMz+5OkiS5sCHDy2j
	 Z4p6slQJr2dTyEojnMtW7qgMCC4SiTJ+sA5xuYipVkUWc1KfqQqdRPHSj6ValmdpdR7A/
	 g17DmlhdfyfOs6N4ZfB83jXMQTc/f/Tkka1xUsbPj6Dg/g08cwLfLpEcV1v6huM1puA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794157558;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=OBtzH8SdKX6PFWDQWi8/2OLkMnONA7NSL81PIjNaI1Y=;
	b=lhjw1dw9LgREoI1xPUGkMZIODR0xsdguv1ljVIUfFBjAueqcX+DKE/+94cGkPgUJBeBC
	 g8jsQHKi98rrpfD8Rp+xapX4P9ve5wZAp5ws0MEnXQrj81CC17/rFfYEQ2mj6mItThsTz
	 VqRoP9ellA/yyphgatZC0L4lb0Z6vIEvXh3TOzFOpKCgPeIuM0D431ROW3mOU6kKa+Otu
	 eGHuVypw5MKVx0iP7gASC5yf2pcZwL3LwaeJ6wyzveT8Wo7P6b0H4YBakUKchbnZCzySM
	 hN0nLmftl+jdqWYRKxszz+/uDy1IANPbuLgybVwrFFlS+fDJcM/0NDYHKIhJFNz/dVg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O3jZ7sEZ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 076E4F80124
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 18:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 076E4F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O3jZ7sEZ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3754C6114D;
	Sun,  8 Nov 2026 17:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0F41F0089F;
	Sun,  8 Nov 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794157553;
	bh=OBtzH8SdKX6PFWDQWi8/2OLkMnONA7NSL81PIjNaI1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3jZ7sEZY8NENOgN+VZdm/lQ4jhwTTwtfjuuN5HxKPvwulp+skS5l6fD9lvL2B8LV
	 b1sfbfezrodHV0KljFrB8w2qNFFAbRl4ll6QDMZHpJ6sgOp5bNKiQpxzZ1PbmyQqLm
	 WAHTUc/KsjHTdEqzxiB/EYKrGJsFGO0249UhytJ/2eomMsS9dJ8w/Flqb3cvWFXig4
	 LwoSXfHD1GogM3gYQjc/LXjJkJ0YRhWPKd6atvUSpMgZfi3hAp4ELEoSbab3d/vB6l
	 mC1BlHNiBGnEWGexewRKqbOxTJmRSxr4BmjOF54cYzS0OhPZnwEJJU0i6y469NeWke
	 Gixdg56uMF9kA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 537062D0D762; Sun, 08 Nov 2026 17:05:51 +0000 (GMT)
Date: Sun, 8 Nov 2026 17:05:51 +0000
From: Mark Brown <broonie@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: twl6040: cancel jack-detect work on component
 remove
Message-ID: <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
References: <20261107142006.3711973-1-hj351016@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvlDbwXVb7DopO/R"
Content-Disposition: inline
In-Reply-To: <20261107142006.3711973-1-hj351016@gmail.com>
X-Cookie: Whoever dies with the most toys wins.
Message-ID-Hash: M5KI3ZZFV5COHYWPF6KENHLADIMGFRQ3
X-Message-ID-Hash: M5KI3ZZFV5COHYWPF6KENHLADIMGFRQ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M5KI3ZZFV5COHYWPF6KENHLADIMGFRQ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


--cvlDbwXVb7DopO/R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 11:20:06PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> twl6040_remove() frees the plug IRQ but does not drain the delayed
> jack-detect work that the IRQ arms, so the work can run after the
> component and its devm-allocated private data have been freed.

This doesn't apply against current code, please check and resend.

--cvlDbwXVb7DopO/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavCr6gAKCRAv73Ows9A4
ieajAP9y90FSW9womqL3t5vBzMwzESBB386z8EDUJEqr/uWZqAD/RZbBwKsuUiKH
1UqkeGeROrCAgK7yEPt6JOoDjb/64Qw=
=RQY6
-----END PGP SIGNATURE-----

--cvlDbwXVb7DopO/R--
