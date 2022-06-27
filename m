Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241C3CCA47F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 13:24:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD0321698;
	Mon, 27 Jun 2022 15:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD0321698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656336292;
	bh=JZtRNbKRSnXdu8246O2Zh/waviRpngCjFGfB/SCDurY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEym9X9IKNl+SphWCvWPflLmIthLQCWIbUj+Pul1f063oZ8mUBk/1F5AjD+2MGww6
	 sKhPPZ6jkM58NNxsMlNw4T1QkbTV+p4ul+oIqA28ZT37SiKzC/p+SnXMzqwzrrqdRU
	 avacV7J56vtL2yOgbMHWhVi0rVg2e4WoHKwoP1H4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C633F80128;
	Mon, 27 Jun 2022 15:24:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 164CDF800E9; Mon, 27 Jun 2022 15:24:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7618F800E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 15:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7618F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bbqUrPAE"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A189061305;
 Mon, 27 Jun 2022 13:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CD8C3411D;
 Mon, 27 Jun 2022 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656336236;
 bh=JZtRNbKRSnXdu8246O2Zh/waviRpngCjFGfB/SCDurY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bbqUrPAEaRX4jCY/G58o+pwL3e/9rYcVhyI1P3ILSMZ3/CkdKwmnzm3h+WEPALZUx
 Eu3bC72hxJQriy5R+dhxh8IWfypvQD0Q1ZKOEBAPrxHn73DOjizUlpWTPla1zCVBGA
 JHW3YQeb5OBdlGUmdnwIchPuT/J99TYqVtSPopAJhtM3N5ukAV84RTfsFN7bqlP4qD
 LQLCqYMxTyD+NhXcAuFtgN9N4tdjECsm0hp1zfJUMLiPzDW8hJYBtqY84Yf1YVUJ+d
 9atYA3I5GeC3bHg33kVUz55fIPm6CSbeW7CZdwfUQNF63sS0bsepSmF9qdA/vRIcgg
 PVJr3eZSMxpsA==
Date: Mon, 27 Jun 2022 14:23:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-ID: <YrmvZonpB5GhLGbG@sirena.org.uk>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="apPYr//3R46wZGJT"
Content-Disposition: inline
In-Reply-To: <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
X-Cookie: Your supervisor is thinking about you.
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, jrdr.linux@gmail.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--apPYr//3R46wZGJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2022 at 02:11:13PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 13:45, Mark Brown wrote:
> > On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:

> > 0b491c7c1b2555ef08285fd49a8567f2f9f34ff8 - if you can't find something
> > search for the subject, people often get things wrong.

> Finding it by subject does not solve problem with Fixes tag, that it
> might be pointing to incorrect commit (e.g. rebased).

Sure, but that's an incorrect SHA rather than not being able to find the
commit which is what you said.

> >> This way you would get build coverage... because it seems the build was
> >> missing in your case.

> > That coverage has apparently also been missing in -next for several
> > weeks.

> Eh, it seems defconfigs for this old platform do not select sound, so we
> rely on randconfig. :(

It's not even turning up in an allmodconfig?

--apPYr//3R46wZGJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK5r2YACgkQJNaLcl1U
h9AIiQf+J4cKSrpie5fzCfZatw/Ms70JQ8wIwrUTA2mYCajSa1hWQYOaJjUniiwU
syfJFKnG1f4/rEmA7jppNanOYh2kfp8XlkZMsoIENwVV6gYeGbA8kLMKgMOxJJ5o
FUEnOYWyFMkkinvcLtcCY99r9R/DKcp+ixgSLsgMFKrgUNPARfTD5pXL/DFnr4mw
1YTLGIGvTCuxspMXzqkNDWBMH3XmdBan+akJ0tZoqvOIKB9XDvXmmKoPeV1r7I8D
TwGsPvsCSpmVuNeFuPYKiBK638ylmFMzojREXfKM96ha4K9QBa+Eo+euEGJX+n/4
GxD/EvRCuId+N5NjJCf6TVfLHoUNQA==
=W0Bl
-----END PGP SIGNATURE-----

--apPYr//3R46wZGJT--
