Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D10EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 27 May 2022 07:43:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 873D816D6;
	Fri, 27 May 2022 09:42:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 873D816D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653637401;
	bh=0xvIV8iKpy7JaL9L1YBs9XRH416sKDOnCczXfNS5Vnw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hj0pqZiCvQoDMoclIksUMxGEgyo1BiN5cecGa52hwvANNizDutxxR4InT2t5yUr1E
	 tKTFJddh3R8Qj5b8elVbwlphCZnbB8J1hgn8bj7P3ySiKAiAV3qXqR7AGONzaX0dMJ
	 A8ty1HzBeZ7RtzgG8lzi8zumM9ZCph2Kssaa9fGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28E96F801D8;
	Fri, 27 May 2022 09:42:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08A8CF802DB; Fri, 27 May 2022 09:42:30 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A7FAF800D0
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2022 09:42:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A7FAF800D0
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1nuUc2-0002kv-2L; Fri, 27 May 2022 09:42:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1nuUc1-004pLM-Nd; Fri, 27 May 2022 09:42:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1nuUbz-00CQ8l-Ju; Fri, 27 May 2022 09:42:19 +0200
Date: Fri, 27 May 2022 09:42:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: lm49453: Drop no-op remove function
Message-ID: <20220527074216.h5nchtggs4tn6vak@pengutronix.de>
References: <20220526204016.1724630-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vmraiioxg3kgy4wn"
Content-Disposition: inline
In-Reply-To: <20220526204016.1724630-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
 M R Swami Reddy <mr.swami.reddy@ti.com>, kernel@pengutronix.de
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


--vmraiioxg3kgy4wn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

FTR: The two registered maintainers (M R Swami Reddy, Vishwas A
Deshpande) didn't get my patch. The TI mail server told me:

  vishwas.a.deshpande@ti.com
    host cluster5.us.messagelabs.com [67.219.247.195]
    SMTP error from remote mail server after RCPT TO:<vishwas.a.deshpande@t=
i.com>:
    550 Invalid recipient <vishwas.a.deshpande@ti.com> (#5.1.1)
  mr.swami.reddy@ti.com
    host cluster5.us.messagelabs.com [67.219.246.212]
    SMTP error from remote mail server after RCPT TO:<mr.swami.reddy@ti.com=
>:
    550 Invalid recipient <mr.swami.reddy@ti.com> (#5.1.1)

So if the only stopper to apply this patch is some feedback from one of
them: please reconsider :-)

What should happen to the maintainer entry?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vmraiioxg3kgy4wn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKQgNUACgkQwfwUeK3K
7AkUJAf+KsaECVGcDJqvX8S5RsLRHb7O8S9/C7pA1a0NHAxIdiKyNzcn4CFfvX8B
nAr790yWQl4+W8LWFIMVHqpIla+6vcj+0FWgpfJ+kKpJaZ4vASwcy/59HjjooUKF
VscO09jiqwA5tUXhQiJ9nYomafdBmomumSBezIkxZgLsZ8+8srq49V8oOwREh4IH
sKD/irDs0pvCJ7Psx3WFc0B5cHlPIS//aVUmPp5mA/h7n8TxuYa/i/M3hWKNrgpo
FqicYEk02qBoNTKYyOcIMPWNvxZDullmEf5m2CHR0gtq2HjyQgCegwgf8QZyXkum
598ync2btCEnSNJL6SNMYqwhSgVFsQ==
=WB+A
-----END PGP SIGNATURE-----

--vmraiioxg3kgy4wn--
