Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD00C47404
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAECD20B7C
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ClPEPzyk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wnmE+fIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAECD20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB0C9165D;
	Wed,  9 Oct 2019 19:00:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB0C9165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570640450;
	bh=o7IfMuGA1qIcRLG+Qr/tIeUznNIkM8fstKnZVq7jijc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClPEPzykTFFKR7b0TOcFyIOE8CkNhEplFeUI12rRumP0rvZtzxyjUCNN4/i/5vGxR
	 8D8h+/vbJvizIfM/wyAqymKDpykTOnj1yYY9xPedXez8x1m8S8y3omYYpfe7PxFE1X
	 u5imxzi+I825BtXRq5vEBHsUpbOyzAOB0WAogOGY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E6C6F802BD;
	Wed,  9 Oct 2019 19:00:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02202F802BE; Wed,  9 Oct 2019 18:59:58 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FD5DF800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 18:59:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD5DF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="wnmE+fIt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rj06Tv5j+rvhEcTqvvqFPxXNxUI4Mfz6LMD0PqzgMF4=; b=wnmE+fItLg2W6Q9JuGiFzyNtF
 Hn5rFYVs1CrEiohk66VdhhmARG+r/KAFLkPbtAbHUTN6IXR4w5tV4MDBnF1qr5mWmTkMGcAChts1f
 /D/pJ3wR2vnnQczB01F9vf05nuT2dzVeJgbvo8DohPDZ16Ck4T3wz33eEkJJXEZ4rSveI=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIFJa-0005HN-L7; Wed, 09 Oct 2019 16:59:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 8DBA3D03ED3; Wed,  9 Oct 2019 17:59:53 +0100 (BST)
Date: Wed, 9 Oct 2019 17:59:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191009165953.GM2036@sirena.org.uk>
References: <20191009102127.7860-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191009102127.7860-1-srinivas.kandagatla@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 vkoul@kernel.org
Subject: Re: [alsa-devel] [RFC PATCH] ASoC: soc-dapm: Invalidate DAPM path
 during dapm addition of routes
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
Content-Type: multipart/mixed; boundary="===============0895740363577291120=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0895740363577291120==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5y45gzHVJWc99xXB"
Content-Disposition: inline


--5y45gzHVJWc99xXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 11:21:27AM +0100, Srinivas Kandagatla wrote:
> From: Sudheer Papothi <spapothi@codeaurora.org>
>=20
> During sound card registration, dapm adds routes of
> codec and other component paths, but the invalidation of
> the widgets in these paths will happen only when the
> sound card is instantiated. As these routes are added

The whole point with this check is that as you say we're
validating everything as we instantiate the card, not piecemeal
while the map is partially constructed.  Doing that is wasteful
and noisy.

> before sound card instantiation, these widgets are
> not invalidated until a playback or recording usecase
> is started.

You said yourself that we sync everything when the card is
instantiated.  Not on first capture or record, when the card is
instantiated.  If for some reason there is some problem with that
on your system please fix that, don't add a bodge somewhere else
to mask the problem.

--5y45gzHVJWc99xXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eEggACgkQJNaLcl1U
h9BgPgf3RQI51vbBRTM40x54ZfHusQX6D6EE8gGPuMWgrrPkxU6CroFzRmvr5jps
n2voRmRkI7TsiHIRL7qYwCwjsNxwRi7J/s3SLem7WoC64io0f+yU7z/hTmuMK9Js
NejKG2uFU0o3Cmtzn6I160MCnav+FsCJ5UgwqTcZdUxLmMJJoOScM8BEK3ExdUf5
06YQGcMpaZtB1XbfyCNqy7KpHkOpFxAerW5Df5Vkv5WEs0zZNZpbvUKpyKBD8lOY
iBIq48MHlsZ7sp55FKhTKqfs5Uj2DZ2zkF7fSeqTBQuaZK/o2zRTxEB5lnkD/88Q
dNCBvlCBtU4PiMfgJ0mvrUbjD4lQ
=rzwa
-----END PGP SIGNATURE-----

--5y45gzHVJWc99xXB--

--===============0895740363577291120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0895740363577291120==--
