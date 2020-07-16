Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4ABC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:45:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A85120787
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q0zP3+1i";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nySDF0r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A85120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A59DA825;
	Thu, 16 Jul 2020 22:44:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A59DA825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594932314;
	bh=H2ahd7sqNR8XM2KPpWX+Y/Oo26bkjK3QWhQa8VHjuB4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0zP3+1i4MOE09CxyambyBR3w0a9adY9AlIF/5IU3rO1+h4HdjGJS/OcPPySajoYA
	 GMbgU0AVpGW0AInB4yQ3AEdx5vp4AnrsxqjoSMGCCQCu9tGv2SORMKXtjQfj+R134l
	 hEjMZYP9uvD46zIByX7byDYcabloMANtzWysvuR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47C2CF8014E;
	Thu, 16 Jul 2020 22:44:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C386F801EC; Thu, 16 Jul 2020 22:44:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29B28F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 22:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29B28F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nySDF0r5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE2EB20787;
 Thu, 16 Jul 2020 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594932254;
 bh=H2ahd7sqNR8XM2KPpWX+Y/Oo26bkjK3QWhQa8VHjuB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nySDF0r5o90PyGkGNOvxdO+Co0SwlM9Tnk6eiFx/cqO690tiZRIwgS1qsFjWydLNE
 T8t6MRdXfu4fw1GHzbYI0AZzO3FnNmuf9tmFmnc9+c0JQpUXQuKBi73LlIZ1TqN2NU
 f2olHBr+aEPcYpo+1x7lS3Umcc7ZGwDCyr4HK5YM=
Date: Thu, 16 Jul 2020 21:44:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v3 07/21] ASoC: atmel: merge .digital_mute() into
 .mute_stream()
Message-ID: <20200716204403.GA10651@sirena.org.uk>
References: <87h7uhxxk6.wl-kuninori.morimoto.gx@renesas.com>
 <877dvdxxi8.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <877dvdxxi8.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: You humans are all alike.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 10:56:15AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> snd_soc_dai_digital_mute() is internally using both
> mute_stream() (1) or digital_mute() (2), but the difference between
> these 2 are only handling direction.

At least this patch needs a rebase against current code, possibly others.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8QvBMACgkQJNaLcl1U
h9A1owf/UuKoUhsDVGK5s1zW2rqWrwUwbxxPbfb0YNudCEWCDJ1i7reUdz1184mf
LHmS47drEP3KYR+wWloAzq6u0Zbno8xObaJ6oXeRFBRfdGkkkLHTvhLmO8fse1kZ
ELWuCAQiBbFk5UnGSUz09SinVRW/ItYqYT6upRMjmGpouv6o+OwsjilcdYFN8pI5
67urP1yBFwunQ8mtab8wT6S+X7m6uJfFT9qwqggD6IwtQJqoCzvMa3YL1RSAL4vf
k6CGo7/DxEnYci/pcpYLzVgNKGOT0/xUgXkoKjTzVOfcL1lLPOg5VorS7R+Iq1eF
Y3tzy5yFuILInIAGjrZVi7b571S42A==
=Kgwx
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
