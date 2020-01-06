Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980EC2D0D1
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:07:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167A42075A
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CPKkLIma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167A42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0E0A17E0;
	Mon,  6 Jan 2020 11:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0E0A17E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578305216;
	bh=m++5ZKWWXxid2SnWpz1gWsX1wV2tFg7korqBQxUxT6M=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPKkLIma5xNu55OL3r6C/1koK6ynlKMFBSEa+WsNGe6va5RT8QQVjHXwXzNugGTaU
	 ZY8WHIoVa2Vf8s/Jgdw68qUTiSxhJspm1IY4ObHaDP1B41FBxCYArB88z6mhSkOEOH
	 hQupFPMUhtkqA1VpYZHo93Ony/ANzSC++GxmBH8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42E73F80149;
	Mon,  6 Jan 2020 11:06:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50E88F80159; Mon,  6 Jan 2020 11:06:05 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa1.perex.cz (Postfix) with ESMTP id 6562BF8010D
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 11:06:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6562BF8010D
Received: from localhost (p54B338AC.dip0.t-ipconnect.de [84.179.56.172])
 by pokefinder.org (Postfix) with ESMTPSA id 8DC052C0686;
 Mon,  6 Jan 2020 11:06:01 +0100 (CET)
Date: Mon, 6 Jan 2020 11:05:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Message-ID: <20200106100558.GA4831@kunai>
References: <20200106045833.1725-1-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] treewide: remove redundent IS_ERR() before
 error code check
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
Content-Type: multipart/mixed; boundary="===============3005379144708951088=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3005379144708951088==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 01:58:33PM +0900, Masahiro Yamada wrote:
> 'PTR_ERR(p) =3D=3D -E*' is a stronger condition than IS_ERR(p).
> Hence, IS_ERR(p) is unneeded.
>=20
> The semantic patch that generates this commit is as follows:
>=20
> // <smpl>
> @@
> expression ptr;
> constant error_code;
> @@
> -IS_ERR(ptr) && (PTR_ERR(ptr) =3D=3D - error_code)
> +PTR_ERR(ptr) =3D=3D - error_code
> // </smpl>
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

For drivers/i2c:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks!


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4TBoIACgkQFA3kzBSg
KbYycQ/9HHMMaJuiDZs2ZZyg9Szbt/uDs6lfGNwX2WQjjgoo0FHwIISx26fwUSS0
sfKb1VukurwS3gKvijHI2Tgo+f8Vb5W76AfDl7l2Pt+/1Fc3udj81ejuq6hrwDtX
8lb3i4K7U7mReQW1CuGDL2a15XNeUCNSocbEz9r/fSMSCcO7vtYFQdJ1PRCiO40n
Z9RU/AGK5/6Dm8H6JaPvBbkL4cSaKu0fWTLYwZfm5lUqpj8ERaGKdlz4W/DEy5nw
/FLsLSoRRKpkrWFzohHUjEplvrX5Xv7//Pl4GHVxH25rPhKgXL7M4bkJUrAOG8Ap
zRni09tOZTNrB2zkt3dFgDSUXwPHJOM0KLrVyFeze3ZtA/8rDaDxbr7a0lK0Jgi6
X3+CMoirCftC9W2ub9a9h/IOhLqzFzVoWNN3QsHr4XxLYmE1EvhoIYbCRs3JpVrV
cgbYECZxZElbp6K6u7sEsETPvGjvHi4gzXBZUwxYpdZyWaUsV+XIzxqQyeQIqkFF
Yp6Cjmd/cjgLLUMwxL2QaopFPm+Ul+f5AojzQbMP6ScKbrjYfKn8S60q4fwrShk1
yDlNFlQgdSrn1Dt1PfGllfjLz1bcQ/tsZsmP/ulyPE0Ph9Mv5ixDhEse7mZmOVjm
8khnVJiGQcIi1CMl8mR8uDU6319aQvxcYWlG84KlF7nXsigrRqA=
=e1Dd
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--===============3005379144708951088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3005379144708951088==--
