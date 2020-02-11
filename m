Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C392C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:47:38 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8658820842
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YYclV5VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D51A94E;
	Tue, 11 Feb 2020 12:46:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D51A94E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581421655;
	bh=Nue+EcO3tJCT6XU2ZHnsMqRb3As4MADS4F7Lget1Hpo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYclV5VLIAzjWw2rNXcTs4Ejnmd5wsYr4y2SqZmShiK85I2hF+yyiFxPA9ZBJLDjP
	 rwcH4cS3pngRUOcZT3biz6lHBFfjfb/YblDnwjawGz41KEYkqsrfLrnVikZOh8p4UB
	 Gtp29QKyAe9q9uGx4PybIqeBTTaWuQELyX2QE9As=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6996CF8013E;
	Tue, 11 Feb 2020 12:46:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04EC8F80145; Tue, 11 Feb 2020 12:46:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 397ABF8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 12:46:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 397ABF8013D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333C9FEC;
 Tue, 11 Feb 2020 03:46:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4053F6CF;
 Tue, 11 Feb 2020 03:46:39 -0800 (PST)
Date: Tue, 11 Feb 2020 11:46:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Message-ID: <20200211114638.GD4543@sirena.org.uk>
References: <718b2de2f61a4fa1ad8099a55d11c6fc@realtek.com>
MIME-Version: 1.0
In-Reply-To: <718b2de2f61a4fa1ad8099a55d11c6fc@realtek.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, =?utf-8?B?6Zmz5pi25b+X?= <kenny_chen@realtek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 Mingjane Hsieh <mingjane_hsieh@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1015: fix typo for bypass boost
	control
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
Content-Type: multipart/mixed; boundary="===============1734535376390175800=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1734535376390175800==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 10:18:11AM +0000, Jack Yu wrote:
> Fix typo for "Bypass Boost" control.
>=20
> Signed-off-by: Jack Yu <jack.yu@realtek.com>

This doesn't apply against current code, please check and resend.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ClB0ACgkQJNaLcl1U
h9Aohgf+II2R6ZOya2D6QhZ7BkuMiuEnjX27ZFhae8iKLepqWhUBhFTAlu8aUPZH
M0jwLuqZVOrvuzAWPO7VeWDCnGpxVkkv7aWbG4/W4TodPPwU60fKmiS89em1rvmW
bFeE2b6Gbs1MYZgUH9/vRhX4IZ9+UwrEqEBQ8gGjqL2DxQlkZiwx/tBGF0vdk9uo
QlR73kNIFLwu4TAxhC6pbeyd35CsTgfVMTGEq0ZdzTCOj+gkmNJcBbgyaTphKU2k
fCu2w6jGqmmLiLKqmDFyJxm8EHHWQ6LcRCBWahe87esuHzw/92kM7nyVfpwdZYeL
WNRY/x/dO015XlxHhFzxUIyt/j9fqA==
=RMmN
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

--===============1734535376390175800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1734535376390175800==--
