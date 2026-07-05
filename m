Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247BBC43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:17:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D29F960219;
	Sun,  5 Jul 2026 14:17:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D29F960219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783253853;
	bh=8vZcz6qAZD4uRcsZpPiAXNiCjuQZ+E/uDUWR8V0b/vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q7RkEB8HTsRcQuWmtILdHHYAdRf/p243zD5ih/AKFwH6N/KWY8klEHSmgz0A8x3P5
	 TAu7XJLN2Zn89YuAQNJ0vi7jcYWIIn5sQflee3KMq3e5EiRNDbZhZIf8ZL9Hk3eob7
	 UWRgDGP3G78hY4rxoT5yVHT5Mikgjthu2ur9L+lQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C244DF805B3; Sun,  5 Jul 2026 14:16:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6031CF80601;
	Sun,  5 Jul 2026 14:16:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FCA9F80526; Sun,  5 Jul 2026 14:16:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783253807;
	b=B5+M3vtYEu+fqfHMuNi/IaBTz3NN0hsY9BdEhy+LT3Z8fl/OdvjE473LOBMQ2/nmf2kI
	 8BEqVkWAd+03sWbgnpBTKRvqCZo3uzX/zmqmaDDLGmqJj758gPyqg6NbpHXmcIJQ8dTl4
	 x31m165e1muk3O7L+wuwXYpKHkFr1kC9u1i1d1QJLl48YcjeoXLciTUbCXcpE5kMR0Rhu
	 U+IwniTTU+O0Bkwwhb8YTM65QMxeDREV6bIcmHwUiBX78/QwgFWyv+yzM8bvjrq3TCp+5
	 pspTEPV+lWLEO7xyvEa2m0fs7xBc9ijD8WacAVXdoKL4P4M+ry1ZKlZ81/vEku8pekg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783253807;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=8vZcz6qAZD4uRcsZpPiAXNiCjuQZ+E/uDUWR8V0b/vM=;
	b=E9N5F13Q4HyrvxVGGHIWu9L/yEqCQt5o5ok7qGxjJ6EMJAtlNNcajIXEBIUKtyeaL1KY
	 ER0EqlN4EgT+huAAsFRGBblDEyi4Dd2zG287I7wi71+K7pAiYA+OM1B1ZG8GGuYevPc3l
	 phY+/of3D4EjUHFfF7svZ4MuzTZA5f0TYW5ZQB8laM4pIjWTA0Lq2pj6XLb+OouFj1LLe
	 S22tbi/COkCQWB81p1YLjp0Fshm83udPXpmFPFmImRJP1LGvUjSDcM3G48W6XY+YwRyb+
	 FSE8cCLqMJtewabnUyunMYKu2tpNMwA+dlP289OxUh6zg9NilG9kFEgZ/y1HlZ2H9Vw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DNIsErs4;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7E34FF8026D
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 14:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E34FF8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DNIsErs4
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 067986001A;
	Sun,  5 Jul 2026 12:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8171F000E9;
	Sun,  5 Jul 2026 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783253803;
	bh=wCXuoEM+zXYvIbDqg+uC7kK8f8ZsiBmBh0QdsgSA2J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DNIsErs4F0LN6jZPLj6sZNSWOdc333z7m5CeFrORtHp55ooIFCD0YHAhSd4B8MSlb
	 BnayAuHJaoxcaazU10maaDj0o/gDLiE0hSwdjnDeUUY4oWnVuFZ5WtLIyMfPkc5fxk
	 +Wgwfc28cWC6op2Exr2AYyEKqvZrE/p9zr144QU/3xP8J/eG7gyFd22t6dy1og5zQm
	 Kmw2vgG5C4AqgfQ2OA1Z/dadEymbg/QLizKhHyIPAMsh1s7gKrSHyo9xvholzYTtNi
	 AlDjMONZFslEyqF9huf4G/B2my4WDSyXrB+qwgA47Z78fMEb2vWn0ca5+Nriu1Qx+T
	 BGVzKyyzVH9OA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0D9901AC5AC6; Sun, 05 Jul 2026 13:16:41 +0100 (BST)
Date: Sun, 5 Jul 2026 13:16:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc1
Message-ID: <akpLKbPAdPnoGaww@sirena.co.uk>
References: <20260705115220.1C9801AC5AC6@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+ubnJuzOtu+Kl9I"
Content-Disposition: inline
In-Reply-To: <20260705115220.1C9801AC5AC6@finisterre.sirena.org.uk>
X-Cookie: Whatever became of eternal truth?
Message-ID-Hash: 2HMYAPQGROVI45VWOZ5FNSLHNZC7GYSW
X-Message-ID-Hash: 2HMYAPQGROVI45VWOZ5FNSLHNZC7GYSW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2HMYAPQGROVI45VWOZ5FNSLHNZC7GYSW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--W+ubnJuzOtu+Kl9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 12:52:19PM +0100, Mark Brown wrote:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e524917774=
82:
>=20
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/=
asoc-fix-v7.2-rc1

Sorry, this is a duplicate due to me using a different machine to sned
my SPI PR before the sound fixes landed with Linus.

--W+ubnJuzOtu+Kl9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpKSygACgkQJNaLcl1U
h9BMEQf4+7UFd8njlt/KUjSv5esd/KP3cYr1IvAJvXEIDU+2kglkv4ykI/nR656Y
1NImQWWQywZGh+dWCb3P1/g/v6ff/CHwsWjyIUJxHnSFZ7MnHUMhazGWCkgf7qhW
x+uaGt82AU5fJmV1pQL7i6wKEooPve2zydRTNXTQR0Xc147eO6ax0mIoM+DNSoFD
6Bp1zZyBpZt+DhL6166zncXve1UL1UxiFHZGUD6epIv1P02+dGcPFMfQRQlAeTIx
4KQvHJ9qKhFjh7ReCNU3otIE4gyztkaxAdZ242s8yHvWfgSwfbPq0qVcIpwsV9Pf
ppasO8Sd9wrO7W7aeysTiZVacF/v
=RHX/
-----END PGP SIGNATURE-----

--W+ubnJuzOtu+Kl9I--
