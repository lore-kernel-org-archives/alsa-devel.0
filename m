Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73BEC982E1
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:15:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21162601F2;
	Mon, 21 Sep 2026 12:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21162601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789985740;
	bh=Aqcq9aL88BNS0cECLzkTksUWHdYdimF8T4Db+anjypQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WTM4iZ/MJ+iAGfvjJ4tAkNsB58oI8yyYx1/+WwbVGpaCz437Rtxacvb8Yen0Mb8Fc
	 R1AXvAuiIWTglSNoD4PL7C6FyB0HjnNZI7KKeOxn8DB7PWcXgmOYnW38B5aT/Myxa0
	 w+Affyve0Y9+eFK28Z3iRJDvhN6ZhRKm4F7H4RSA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCE2FF805F8; Mon, 21 Sep 2026 12:15:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC3D4F80601;
	Mon, 21 Sep 2026 12:15:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 442ECF804F3; Mon, 21 Sep 2026 12:14:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789985697;
	b=YptlJiH6Ps3SVid/EFLTIdL4ziltftEFdq5heLog/TLwu7VpKW3khx0onj6HfXTXVio5
	 Y5k0zgrwTwtRtMlz5GYnzoXHSYmkz0yUyqXVrfEookqE8snH+T/Zb2RVHTooBtXZDYXx0
	 HC276/VSCGqdAr4kOO1f3t6IwYLpjhp5fHKkr2dW0vdzIT6oP9ZRYpNpMDHRrCeSszLXu
	 OycbS2BWOyBPsU8VU4pmukIiDTv7bux+nJWCkPOtQHi9Ewh3qwdy9KVAFg3DAhPPbSbVP
	 2eUf4GMfnExuJLsx+xN9fn24d5PqtmfTAKYeEQUbAC9AFuCHhJXADyyy87OYus4ASdw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789985697;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Aqcq9aL88BNS0cECLzkTksUWHdYdimF8T4Db+anjypQ=;
	b=pyLXOtVkQdWRuvwg9rvlPJ6JwRsMcPDAAvKTqW8XU8kTXOpjPu5s/KtiMZAmd6FgdfcL
	 VIBrvU6SG+gDKd3sEAzCKgtf3COO8vKl0yw79qbg3oZcwCJI2ToqY/802xA9FiqlgTRYe
	 cGfyH60HfYrJXj9Av9dD5BFhVkV8A3E4b24fu904iotUMt21/HDj/sJTcvjg+nF9UzP7T
	 6VXHK+qyzvoBtXBUw1UADV/GXnWBp6wtoxM02bA/LL3juyhpResMt0kc7jPDILr/JTFs4
	 SFnMQjgQha7he07njDnHnynXSDZ0lvAiMBOtgao8AWUX6mH3ZzbPEmxzj1L0MaDRJcg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j8BpV7B7;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BAA3F800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 12:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BAA3F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j8BpV7B7
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B299F600D1;
	Mon, 21 Sep 2026 10:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341BB1F000FF;
	Mon, 21 Sep 2026 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985693;
	bh=Aqcq9aL88BNS0cECLzkTksUWHdYdimF8T4Db+anjypQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j8BpV7B7EaLh0TRBdDEWhu1XlQA814ENsQgkEUZU6Fo4T6WiA/dznBTq+R1y00xn4
	 ljJFaQ656/qRmIpgMd6I0LfEq1Ho0m3pZdFh2QMWA7g15O7hqh4MRgaH7dRs/E36IZ
	 NpHcd8uOzpaJ1YJnUZ636VglI0i7TtWyjMUIsekqdyx7fcVIKTNgzinK4wd7VbTri3
	 cWvaMw0GlGmwKzZlEN9BaYHGegwDkCUTOdAR/QbH4zdAbEtJzcfph9Qugp/mi3h93r
	 tODcjhH/iRmFgA7nLDLBgWJeQa8LoTUkyCI9QXrXz/Pzx1vH7VjGpDXloLp9GK8hX3
	 gtCZ20wJFqxKQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 2DC201AC52F5; Mon, 21 Sep 2026 11:14:49 +0100 (BST)
Date: Mon, 21 Sep 2026 12:14:49 +0200
From: Mark Brown <broonie@kernel.org>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"pin-hao.huang@hp.com" <pin-hao.huang@hp.com>,
	"Syed.SabaKareem@amd.com" <Syed.SabaKareem@amd.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware
 download status check
Message-ID: <arEDmZ76qb3eLiwk@sirena.co.uk>
References: <20260921064053.932-1-baojun.xu@ti.com>
 <arDujlvvKixE6ifp@sirena.co.uk>
 <1c8da29a1fac4435a59783ab9fe7f68b@ti.com>
 <arD4k6hCZyqycYYW@sirena.co.uk>
 <4d1f121c8ac348dcbb16b554e4ed2b9c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nnf9EGSfCSnJfaGN"
Content-Disposition: inline
In-Reply-To: <4d1f121c8ac348dcbb16b554e4ed2b9c@ti.com>
X-Cookie: Too clever is dumb.
Message-ID-Hash: 6ZXDMAATEQ6YQBPK7H2K4R2OICNNKG7U
X-Message-ID-Hash: 6ZXDMAATEQ6YQBPK7H2K4R2OICNNKG7U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6ZXDMAATEQ6YQBPK7H2K4R2OICNNKG7U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Nnf9EGSfCSnJfaGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 10:08:54AM +0000, Xu, Baojun wrote:

> Previously, a local variable tracked the AMP reset state to determine if a
> firmware download was required. However, we observed that the AMP resets
> during SoundWire bus stop/start sequences, causing the variable to become
> stale. To improve stability, the driver now directly reads the register
> value instead of relying on the cached variable.

It should just need an assignment to set the download flag when you
decide to skip?

> This version has been verified to work correctly on the current platform.

Are you sure there are no users with other systems who might be broken
by skipping the download?

--Nnf9EGSfCSnJfaGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqxA5gACgkQJNaLcl1U
h9Ce+gf/Tk4xSnpcXTJeZWcbSj5JbxXk2JzDAwBUFxoiTU81EYI9M+1U8ZwMjKcE
Q+bohZFKf0g7MhxDTrLZMS5h8X5UeEwONHXf5nS+P6gEldpFol8rv3fY7pwKn6AD
NPV6+5w9gv98a17rIpXitX2odoC8/V6Cg4kEuVLqP5Wqbu96AbRVsk0/t7YfN9Cl
WpOHdRvfEVLF1I4qGvHZ2CdcmMPmV+m1PaHnMDI3wCzB+KGr99PGM0QYuz+ZQ8TI
ppbPKwc8MP7+r9BTbX/isjJf14MOOm5bZNNNFPQ2ElUfsHC8SmIEgOOHEQe6gZrU
seAHlha+5N5UQgDHcyZF+++pKGQU+Q==
=YwsF
-----END PGP SIGNATURE-----

--Nnf9EGSfCSnJfaGN--
