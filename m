Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3958ACA9EC5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:10:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B851820856
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IuUaeBxL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vsHxYqQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B851820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0656B2309;
	Wed, 30 Oct 2019 15:09:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0656B2309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572444606;
	bh=nhoSXGYtLxmNJnYXdwbwkgMkiY9mwqxohpS9t4fSxsw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IuUaeBxLciWaoqeqh2/roX2k1gZcCnxPPZzTCID2dELsEGD4OtvUPAOL52w0eowcJ
	 UNfUWZnL7esbrEHWuYbf8uAFbuCaCKTAhxdOrSvRG7+AT59SLBHVq2DmtKZC5SHtv0
	 pvJ2v9hg+1r4wlU9iOxS5SsEByyC8tJk07iK75cY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7C6CF802BD;
	Wed, 30 Oct 2019 15:08:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 165FCF8044A; Wed, 30 Oct 2019 15:08:54 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D65BF8015A
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 15:08:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D65BF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="vsHxYqQ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rujyh9JDW5FAD76PsRiR0Mm8fHg2qDePSQnFFysCS+U=; b=vsHxYqQ0OLmnrZ6WyeDP28eTc
 Vpu5OICP0hMv52+CFx+TuoPmOicK1zKIDpzFwlBZetMgwajqOWpcIqygkGu6II9xzMraOY9dLAfdF
 UOWWDeBhYcuSz8TcWLO1vKYfxRJT5ROJoF6TE1IvVtzp/lLADf06azQSuPL0qfW87x3jY=;
Received: from [195.11.164.221] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iPoeY-000589-4G; Wed, 30 Oct 2019 14:08:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A3B64D020A6; Wed, 30 Oct 2019 14:08:49 +0000 (GMT)
Date: Wed, 30 Oct 2019 14:08:49 +0000
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Message-ID: <20191030140849.GM4568@sirena.org.uk>
References: <20191030085617.14405-1-shumingf@realtek.com>
MIME-Version: 1.0
In-Reply-To: <20191030085617.14405-1-shumingf@realtek.com>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, tzungbi@google.com,
 derek.fang@realtek.com, flove@realtek.com
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: rt1011: improve readability and
 remove redundant code
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
Content-Type: multipart/mixed; boundary="===============3634353222343673694=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3634353222343673694==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Content-Disposition: inline


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 04:56:17PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> 1. remove !component->card->instantiated statement in kcontrol
> 2. goto the end of fucntion if "ret =3D -EINVAL" in rt1011_set_dai_fmt()
> 3. fix typo
> 4. add the range check for temperature_calib from device property
> 5. remove unnecessary tabs using spaces instead

These should all be separate changes rather than mixed up into a
single change, this makes it much easier to review the changes.

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl25mXAACgkQJNaLcl1U
h9DE5Qf/UHKMlh4It+dTeiPuuOz1x2YL4wsxTDT32wTXUZ24u3JCLcQI4xZlT9cn
YVyeqQBOQT6LwzvOiqYRlzP+8IblkkNUgNeR/oN7YpBvznHVe06uAFAGZmydIQC9
IcFVD64C3vcnIIrpqmHHKTynGJVb4Yyeb10+iVsGdlXzPbakzjlT0GCUPS42jKgH
zqXR9r+eW/OEARSR3KkGg9fHyzUiyDdtCmPBSz0DTSOWhwsAdlzIhdgK3SMMv/cd
DQVST4XOqrFsUY3qnamtGJzj2Y8WT/Kf4k38Rie+6oDcEMJEOzXeEACM2cPfHjCp
+XZBPvSb6r6BJDVVjsvpO6VYEGs+TA==
=6LGJ
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--

--===============3634353222343673694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3634353222343673694==--
