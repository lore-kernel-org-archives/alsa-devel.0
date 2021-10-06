Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B983C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:24:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566E061184
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 566E061184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D061483E;
	Wed,  6 Oct 2021 13:23:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D061483E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633519457;
	bh=wB67VZx3yGCPIQjp2L0jvOYpehd4wPRSmO+cXM/zjtE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyhgqM03FuZ+HX487VQZ9baeDbwK6wZg7+Qw9/4VkfFhS6Jlm3pOKa3mIvmh4zcAD
	 0HtolBxOmXCvCDc0u4ErsKCD5RwP2qDZqd78y9uqneH723zsEIfhd2/43+DnK7xbvi
	 AM3lMFGC1I22tumqsOCh2lbfj1KwkPSM6ZxBxpkc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60FE4F80229;
	Wed,  6 Oct 2021 13:23:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E13AF80240; Wed,  6 Oct 2021 13:23:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD421F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:23:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD421F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pzVmDATK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBF1260F51;
 Wed,  6 Oct 2021 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633519397;
 bh=wB67VZx3yGCPIQjp2L0jvOYpehd4wPRSmO+cXM/zjtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pzVmDATK0/IrP62mVWrNzIGr8mibSJZAVwhe0P5NvcqnJMKPfHfu89Wo1rEUz1dUl
 W/H45I4A8b4UamBcbTv7TWCr4KqJ17ZGHdPxIopQDTohJupFZp2nuL+y8cW6tIlkX5
 UZQYC93G1Ux+HCiReMeSi5Zhk/tOeZN0r5Cp/ZqgvIPqDbOCEhVP9o1HbgoNVyLN7M
 JWkmdmctYHyF/WB9eBJp9bKdsq408dGrTk7uflfd655mhOm/2Uq9r6uE+K4ioXW5yM
 rjbrE8sZUEfDyubG251Ole9HIkd/hQruyI+DImWHS7MvZzb5AFal7sAjkwy2gVDXv7
 BPVrcw0R61pmQ==
Date: Wed, 6 Oct 2021 12:23:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 00/19] ASoC: SOF: Improvements for debugging
Message-ID: <YV2HIkZv9dmSmvts@sirena.org.uk>
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LAG/fTQkR5J4eCz3"
Content-Disposition: inline
In-Reply-To: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
X-Cookie: A is for Apple.
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
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


--LAG/fTQkR5J4eCz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 02:06:26PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> The aim of this series is to clean up, make it easier to interpret and le=
ss
> 'chatty' prints aimed for debugging errors.
>=20
> For example currently the DSP/IPC dump is printed every time we have an I=
PC
> timeout and it is posible to lost the first and more indicative dump to f=
ind the
> rootcause.

You might want to look at tracepoints and/or trace_printk, apart from
anything else they're very useful for flight recorder style applications
since they're very low overhead and have comparitively speeaking lots of
storage available.

--LAG/fTQkR5J4eCz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFdhyIACgkQJNaLcl1U
h9Ct2wf/Qrm53BkZmLxDUlOOQIwZS+oOWGEqFZxnNK5nlwHhf7nYaTaQH0iWsaKX
7Qv8AI+a6QYxCaGECkF/cxPKfZr7MeXaqrSZ4C3z6eaWVwivE668CE7oOPniFgbN
jIVZIc6VMGkYwS/Bmogz/szGgWIdu8daN/rIAz0QQrlQXtv0BrtKaNmNnoCVI2Sn
g8JXjK9AaygMAZyTHQSjh8RypHYorXL/mgSuDrw/kVo4g4z1fXsIuAYGsJ31bESm
Y6Y5UbkMtgWNyNWmP8vxnMhrt+9lhp363c8d3OHvXu5Z4X+GpxBgwCNt/bdvHtgx
5Fm4DjNbTETz2hcE41UZbGV7CTfGCg==
=Isq9
-----END PGP SIGNATURE-----

--LAG/fTQkR5J4eCz3--
