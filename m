Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8595AC433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 17 May 2022 18:22:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1B1E20C;
	Tue, 17 May 2022 20:21:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1B1E20C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652811745;
	bh=o4YnPO2zCm3/l/lgeERP6gHXMF/WjAEl9gph3kEWbAw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKE+VduCOfp2qKINUVIZEuLxpJcG5Lr/ACcQEp+VXsb9NkVDxjvwo94T0ZjUNpp5L
	 KegBtnKEDkB1K+eLdZ+a3KrDeqoNk/fitlAcLqTJAdIdEXqDkPqGEz5kE5cvDagSJ3
	 oD5B4N41i9NJ/EO3XSCGH0xIZUwlMgWGR/Zi8xD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76DFCF801D8;
	Tue, 17 May 2022 20:21:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81C0AF802DB; Tue, 17 May 2022 20:21:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F0DEF800F0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 20:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F0DEF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eU4PZnpt"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1896F6156C;
 Tue, 17 May 2022 18:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7689CC385B8;
 Tue, 17 May 2022 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652811656;
 bh=o4YnPO2zCm3/l/lgeERP6gHXMF/WjAEl9gph3kEWbAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eU4PZnptgzI+oYklDg9hk1aiYO3gqI2jZWcfy62CZm6Il8XXsi7L7MGjE0gSphQiI
 lx+sek59D29VwxYcG2rowpOxNuaRDJV6NGNriCQbMXCXxhDwwvYPo7KmJ+h7zhzr7w
 Xtcq4idGbYrU70xsdWLyaDyiewicDFMBKW28tFiTZMdpGtqsHgzVIZ71yO5+OSGQOF
 EIcZjDz8csPRPcWOGm/D3IVuapRn2M44/tgOIVsqUze+IvfNB4wwcV599yWEILXPkI
 6XfoMKk1vaomKUHZWvLjzYd0hHVQ6KAnCy5Fz9fTnM2nhXbidYorWPAtP5wKbSYsFn
 tF/AAHl7Pckew==
Date: Tue, 17 May 2022 19:20:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Tan =?utf-8?B?TmF5xLFy?= <tannayir@gmail.com>
Subject: Re: [PATCH] ASoC: ops: Fix the bounds checking in
 snd_soc_put_volsw_sx and snd_soc_put_xr_sx
Message-ID: <YoPnhDRMwoT42vS7@sirena.org.uk>
References: <c2163c71-2f71-9011-3966-baeab8e8dc8f@gmail.com>
 <20220517011201.23530-1-tannayir@gmail.com>
 <YoOdauC5Q8POpHLe@sirena.org.uk>
 <2f331adf-6f95-06c1-a366-ea81b5bf6ec2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mPeorUta12cKt0D1"
Content-Disposition: inline
In-Reply-To: <2f331adf-6f95-06c1-a366-ea81b5bf6ec2@gmail.com>
X-Cookie: Fats Loves Madelyn.
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org
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


--mPeorUta12cKt0D1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 05:25:48PM +0300, Tan Nay=C4=B1r wrote:

> The problem is that the snd_soc_put_volsw_sx, checks the userspace value
> that has a range
> starting from 0, directly against the $mc->platform_max value mentioned
> above
> which is set to 40 at that point so it checks for the incorrect range.

Do you have the fix in 698813ba8c58 ("ASoC: ops: Fix bounds check for
_sx controls")?

--mPeorUta12cKt0D1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKD54MACgkQJNaLcl1U
h9COhQf7B+9mlkPfcMrEUGVphkjGt2eRlgfMJD1rn/3DlZiO6lKeYV2ucHqAqOTk
+bs8+atKKXclIFAP2E93ShgpQDEjMKZQWxoi9GoYZ6XBLtmbcKFTitDnmMava4lW
7v5KgP3ZhFZx5bBrPucYz/fV4Z+mAMQu6RSB29UwvxClh7vKWTeJciPNapS97pWp
yw1NIftwIuDVe2bmHQn2wBDNwpPmZUohyLot/ENMPli7O/CvXQNINq7cmUNEJxfj
orI8Yw15BCw4+fraycoqs3qrldnxFtr8WFwC/pEM6+xYdMNatZNNtMC52xrceAtQ
IiRLAB0bIlGsU83Q6/DHg6rRT+2v6A==
=76U2
-----END PGP SIGNATURE-----

--mPeorUta12cKt0D1--
