Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51112C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:27:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC8324676
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ocs375Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC8324676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2EFF166B;
	Wed, 18 Dec 2019 17:26:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2EFF166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576686457;
	bh=+hxa0CRFJDp8TIBMPFNna38Ryv3qH93BxkFj8XnDYWk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ocs375Jg4+6cG4RjbSdzalKZN6WXdwGQdcXTg5pNhX7pd0WiqB5WcCBCnuG5neLd9
	 omzYisVYmAHqV/fm7+KAM1qpvwtJ18ePH2Dz+rHKO4goZd1JDC8CThD9w4f/zsU3mK
	 e9jThKZNdxsynCVcTuvzT9+zQejKQovo2LznsUPg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50EB2F80279;
	Wed, 18 Dec 2019 17:24:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76FE5F8027B; Wed, 18 Dec 2019 17:24:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D13EBF80278
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 17:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D13EBF80278
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACAAC31B;
 Wed, 18 Dec 2019 08:24:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2934F3F85C;
 Wed, 18 Dec 2019 08:24:24 -0800 (PST)
Date: Wed, 18 Dec 2019 16:24:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20191218162422.GG3219@sirena.org.uk>
References: <CGME20191128152110epcas3p2b205b4b55f6d8bfac42fcb8faaade93c@epcas3p2.samsung.com>
 <20191128151908.180871-1-tzungbi@google.com>
 <8aceb9ec-aa6e-1fa4-cee9-e22084c141e8@samsung.com>
 <CA+Px+wXPa_cwdZUQfCx4jAhhj4Q9b7bNABUGazLKOJ7U5ae-mA@mail.gmail.com>
 <20191218132620.GE3219@sirena.org.uk>
 <f6453e48-cd95-6471-8945-4cc0ab3d04d9@samsung.com>
MIME-Version: 1.0
In-Reply-To: <f6453e48-cd95-6471-8945-4cc0ab3d04d9@samsung.com>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, Takashi Iwai <tiwai@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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
Content-Type: multipart/mixed; boundary="===============8941421874702308507=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8941421874702308507==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 03:48:14PM +0100, Marek Szyprowski wrote:
> On 18.12.2019 14:26, Mark Brown wrote:

> >> - snd_card_new( ) succeed in snd_soc_bind_card( ), so that userspace
> >> can see the control

> > This feels like snd_card_new() is being overly enthusiastic here, I'd
> > expect that we might have other problems elsewhere with that.  I'd not
> > expect userspace to see things until snd_card_register() since between
> > _new() and that we're in the process of building the card up.  Given
> > this we *will* need to handle partially constructed cards after all,
> > unless we change the ALSA core.  Takashi?
>=20
> I'm not sure if this is an issue about partially registered card. Here=20
> is the boot log:
>=20
> https://paste.debian.net/1121543/

> This oops happens when udev tries to do its job. The card is earlier=20
> fully registered and advertised by alsa:

> [=A0=A0=A0 3.501198] ALSA device list:
> [=A0=A0=A0 3.501300]=A0=A0 #0: Odroid-U3

That's not what the analysis I was replying to said :(

This log makes no sense to me, if this is the same card that was
registered and announced earlier what caused it to become unregistered
so that we are registering it now?

> If there are any useful logs for tracking this issue, let me know how to
> enable them, so I will provide more logs.

It'd be good to understand this unregistration/probe deferral for a
start...  when did the card get unregistered and why?

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36UrUACgkQJNaLcl1U
h9AdvQf/d6VYqwcgXnuFMs3zAieeQ+JuTqPm7FiB6AbcjqPAmL/PxvH+MArujCqk
WkeMBpwfCZpkhXspVR/yKG8maniKAmoV38Z/cBmcGv+aQrGmEuDzmLeidngPPr1H
DmyG9uZ3T1bz+zqnGmGid2lPN54VeEGgsdiO/u1Fh1EUHZ0Vej5UA9UPmtTWxzrN
lSp/mQE9ZJiqr8YhZtkUaRm2EU7tosw3RUnq2CjYg2faor9yZRFFa83+rSpojhCT
0I3DhUvxHw0QRo6bGMvR1RaGE+oeGHGVTtXO/BJk4r/IXOUXNC6ilVKQVamLnUbV
O6IFY/Q0mtgGEANxTjS/4F7HiO9piQ==
=BA/X
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--

--===============8941421874702308507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8941421874702308507==--
