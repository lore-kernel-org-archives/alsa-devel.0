Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E4C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 19:54:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32B6601FA
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 19:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B32B6601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25B831EE0;
	Thu, 29 Jul 2021 21:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25B831EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627588480;
	bh=the9VPxFqD+9/ugS0c9sVUvODmc6n6lJDaNBo6wHI0A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q2YnRQjz7FoG2/2ZiOKUD5WrQ+9LTNumyj38eL3Iy5Q9N4o2La+fAV9MK3jTxCwNW
	 02AkYK+qhHkbwSgubK0HDOvCO0OXtwEB6HQ1ixuybmfTZT/WIe0FysGaYf69DwfZlw
	 PVN5dibQLG8rNzn/3a4V+JHRxKNUFv5gih8pz1cQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF550F80258;
	Thu, 29 Jul 2021 21:53:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3416F8026C; Thu, 29 Jul 2021 21:53:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B075F800E9
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 21:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B075F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B0X1x7n4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06BC160F01;
 Thu, 29 Jul 2021 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627588421;
 bh=the9VPxFqD+9/ugS0c9sVUvODmc6n6lJDaNBo6wHI0A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B0X1x7n4+MMSGyGkCzZST5UV0ajYMP3qdfsRY0kR8cazyT3LPkUcgq8laARi4DqxK
 naQGkx44vZ0m+vVk+zKHzpH4V6DOy6iG8qT+haMbi6OaX/bUu2hthUDVS8V2H31puJ
 XF+KcYJME/eg6lbc+e8jL0j2EJCz44VRXf4uGex3+vaIWe38XcXIEpdKK50qR2jYNt
 YOq1CTFSy5T4QbgJfvR4zXie/3kkyqqsNvAfcFirbds8g0izxTTQb3/zh2d8+Yn9ie
 +FiYTzugizii6qsuXJ8tXrtjvfXnay5ro23oFWpjUSfeLPg1B1xwFC1Qzk1ZD3U9y8
 gzqlf2+kk+5vQ==
Date: Thu, 29 Jul 2021 20:53:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs42l42: Correct definition of ADC Volume
 control
Message-ID: <20210729195330.GW4670@sirena.org.uk>
References: <20210729170929.6589-1-rf@opensource.cirrus.com>
 <162758812271.3952.13208728919315614383.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H23uHpCUqgUcHMpK"
Content-Disposition: inline
In-Reply-To: <162758812271.3952.13208728919315614383.b4-ty@kernel.org>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


--H23uHpCUqgUcHMpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2021 at 08:49:21PM +0100, Mark Brown wrote:
> On Thu, 29 Jul 2021 18:09:27 +0100, Richard Fitzgerald wrote:
> > The ADC volume is a signed 8-bit number with range -97 to +12,
> > with -97 being mute. Use a SOC_SINGLE_S8_TLV() to define this
> > and fix the DECLARE_TLV_DB_SCALE() to have the correct start and
> > mute flag.
>=20
> Applied to
>=20
>    torvalds/linux.git master
>=20
> Thanks!

Ugh, sorry - the script is confused.  This is applied to the ASoC tree.

--H23uHpCUqgUcHMpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEDBzkACgkQJNaLcl1U
h9BrGAf+PY+yTDXgKEFsmCiaafH3h5AnC9tHm6iKn/8k2xAVmzlWXJ1BbFhRTI1G
MmuZC1AgDaTMb8YOPWfxfH1Wfmw3AuvU9oavT4ZQgRIF1Y792pLw7Xu0RFgmFYGK
r4W6b9U6yLXwt9Fkky9q90TGTqWRTryoY4ed4lMlAz26L62nl1aPm1h1KIFPfpq9
SwixS0xaUrmBHiY0I4fhCqVnbIJyjsGYjTjDiD4T6wD+vTpUCkU6g8xdrLaWUSey
u1tTBZrybaji/jZavDOs3jIbj6x/3Y9ngLa5bQtnDIYAyy0/3oiAv9iglQOvjv9q
M2jkPjxACZgea9gh3fwhrZWasxme/w==
=saqM
-----END PGP SIGNATURE-----

--H23uHpCUqgUcHMpK--
