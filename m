Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B9C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:34:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA28D64F04
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA28D64F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C38B1694;
	Thu, 18 Mar 2021 14:33:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C38B1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616074481;
	bh=nFgSQpCRtLTmhJpifU3qZm2Z/GsWGU32nCk9QrUFdCY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pGMNRHd2pYZGR1C2FA73of6S18to1wG4W0t9ke/0eftSi8I2pllpGwzLloG6VC2w0
	 fT4/8bgzmv4M5uDU9b9o7wxUe3M3hBfd7JdJsiVBH88Jb2vLJR5a6Y+C3H2/AOLv5N
	 58yJZawXuEdMGbGXKy9VhAMuBLadTPoJQ0ELnkf8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCFBEF80163;
	Thu, 18 Mar 2021 14:33:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E730F80165; Thu, 18 Mar 2021 14:33:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EEBBF800E0
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 14:33:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EEBBF800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tRI2Ef90"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D9C64F11;
 Thu, 18 Mar 2021 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616074420;
 bh=nFgSQpCRtLTmhJpifU3qZm2Z/GsWGU32nCk9QrUFdCY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tRI2Ef90QsHosHq+cXSCbP0L9mycP8eLcgOWENqQh1DlG4wYbkwn7TOdSO81Qad4U
 zdaWNKYKca+tKJnyczBf2xFeSImd2yr+GIOaZsCwecjiH9nWk985OCW6czzIOrjAiQ
 +FcQWyhKfpZKCxVkY0CHr91ef2PI5VHc4tz3Q61I49sw7BCy5+GPJwXCprw7gVnQTg
 K6H9Xrm+kJcvZfzbQcVv9DYgIkinJ/zWLS+s5jqbfMr7Yjw0AbsGx8eSftw9P5d58g
 a2tFx/bU1xLu3y9ib4yAdGHJZMelrEiATrX9f1KemU8DpcMkzw5o46KR1z5MtWTLH3
 LQKPZt/eStwUg==
Date: Thu, 18 Mar 2021 13:33:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] docs: devicetree: bindings: sound:  Fix a typo in the
 file rt5682.txt
Message-ID: <20210318133304.GJ5469@sirena.org.uk>
References: <20210313231850.17278-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
Content-Disposition: inline
In-Reply-To: <20210313231850.17278-1-unixbhaskar@gmail.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 rdunlap@infradead.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 04:48:50AM +0530, Bhaskar Chowdhury wrote:
>=20
> s/drving/driving/

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTVrAACgkQJNaLcl1U
h9Cgmgf+IbGACYGGTkglCPJzmSj1yzZML+qzfH4MR5sA/axTY99X2WsqqCW8C/4N
1sTt1bBKPc7rR8CsntH5Y9rPHeNEXrlKSO/WSms35gAr9wIT9SMGU937MmzTJ+1n
8+YGSaTwIVvVPiOoRTWFOrUk2turdcWDqO0x8X3rhhJ3LHX5RXydKFhlkPGGfZ4c
ESA1YN6IZkD7uCsOlDdWpYPw0IHd4WKmWifm3UOazdVpK7HEQjj/ZRK+Vvxx7GI6
HLGqBbPU6ff3H8f7ZE06oPDRaJ7TuUjD3yt8zy+pPg4vQvJBxf2z10bYqzKf/Qtj
6dNELgYPsUfIF4yQBHGL5i0TZ7zzkA==
=is46
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--
