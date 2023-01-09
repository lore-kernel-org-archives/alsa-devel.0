Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534BC5479D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 16:38:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35477B925;
	Mon,  9 Jan 2023 17:37:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35477B925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673282299;
	bh=0sKd7AfSXYUJc/cfdAGyK8FWT5zeZY+0eFnJqXFU6Ck=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LmxV2p3ljsD1aq63ScT5/BQy9PlzgplgESd1s23Osth8DTVcokMdNqhOb/71Zdg8C
	 dMP51NJ2Jdd46x3Z9eEML5OBB3fEhg10Cp8BLGrMSWCUQmI3yKV0LUrSiPqx/gYnkP
	 Vx8/KPq97S/r4T0awrSk6qBcb4zhxi0zcU04GI3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7BACF802BE;
	Mon,  9 Jan 2023 17:37:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5751F8030F; Mon,  9 Jan 2023 17:37:27 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13912F802BE
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 17:37:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13912F802BE
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OaqSSpN2
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id F2894CE10B3;
 Mon,  9 Jan 2023 16:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190EAC433D2;
 Mon,  9 Jan 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673282238;
 bh=0sKd7AfSXYUJc/cfdAGyK8FWT5zeZY+0eFnJqXFU6Ck=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OaqSSpN219rTwr7CNcOXrMDibKayWLblKNGLBc48QSg9uwqL4kEcn25GO/hTJQf8R
 yQvaZIAe1ei2m5Zf4dlHEvzZqAEd/s9IzMoOX8xrW5olwWn1twPzCvHqAARtU/HrJk
 aoJ4glzSCibVlQitNhCgDkfVWwWLiQhR02iunjGSxnb8H2R4k20kDnU/9lnEzgXwJT
 1/R0wZNcslepHyhQNoJ2kPfZjVNHiTRFt16JfP4UeYgA797IVkZY/3iLWP08a9hC8t
 xLoryDmHrQSg5qg5ZJ/QMWC04LmsqscYgTeVtkYY5URcYgLD4K+gTA5yne2UPzL8hx
 Q5Juzonr2jr3g==
Date: Mon, 9 Jan 2023 16:37:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8821: Implement DRC controls
Message-ID: <Y7xCuC4uDN3iWPcS@sirena.org.uk>
References: <20230109111531.391034-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uUnEW2WSbxPZshWr"
Content-Disposition: inline
In-Reply-To: <20230109111531.391034-1-wtli@nuvoton.com>
X-Cookie: Those who can't write, write manuals.
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, scott6986@gmail.com, SJLIN0@nuvoton.com,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com,
 CTLIN0@nuvoton.com, dardar923@gmail.com, supercraig0719@gmail.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--uUnEW2WSbxPZshWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 07:15:31PM +0800, Seven Lee wrote:
> This patch is support dynamic range compression controls.
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>

This doesn't apply against current code, please check and resend.

--uUnEW2WSbxPZshWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO8QrcACgkQJNaLcl1U
h9Cs7Af+PqL6f6AFfAYFTgtZFs+/3uzNzux1zHW/6rdXknk41rGUyeKKRheTRJ8U
wUEsawJuYf1vGh3a+TQ4alpscIRam8c3aQGCDfs8fd2kN3kgKq2w6bGOs+oI/fm9
UuXvALu38+i0TI5cf2FAI1TDPVgV+17z8DVVTF649WrG1lTVr0PMe4L0vQQeJG0Z
sqG+PQyXbuwKSnMvLoAn8LPtPhP8JB2wkL3I3VYI0wfM61CHQHAVBP8nbnmsHymY
v4TR1U5mEJLD/GIt2Ex8IBZ+BB+lFgmkDVBjZ65WHCgB8E+jOIxoJR5eFu5sdBZy
o/O5zyAfW+PVZtv4jvjj6tmcJX9TRw==
=frZf
-----END PGP SIGNATURE-----

--uUnEW2WSbxPZshWr--
