Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:37:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CD0223E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD0223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD51B1711;
	Mon, 11 Jan 2021 17:36:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD51B1711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610383045;
	bh=FJ6UYmcp9qZ1+F9nDoqN3eSCeXg5LWZGhO2qmO2UrgU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFs2i4bK77MabXslQqdWef+gZY8oxVpKdWxdvIt5bkBoQ4jczNBzbCROfTkXZcczV
	 W0NnLEB0SoBmckwKaKL7UVom3/d3OSrKoRZGgNUdbSLE6244ooilPuHdqRJs8jctMH
	 PbyFkaK/6cGjZZ+3oiCLRgaMaURMtyken5KQJ/Es=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CABCF8016C;
	Mon, 11 Jan 2021 17:36:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0CC5F8016D; Mon, 11 Jan 2021 17:36:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5C95F8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 17:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5C95F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="erEHoJgE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9F420B1F;
 Mon, 11 Jan 2021 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610382984;
 bh=FJ6UYmcp9qZ1+F9nDoqN3eSCeXg5LWZGhO2qmO2UrgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=erEHoJgEokRZJPDaOfAepJ6+VEHuyp7HvfoJ+KEJ2EyWGzv0KVvCFc2J2gTDQM58v
 rTjbHSoJHqMp9+g27xZk2GKBbGxnUHJ9eANnJjyKCoTFFccA/EA3LSyV5eCwcC3BqP
 f8WW2UlhOhalPXGu0Iq/WpCI+nfy4NG28cFzJXv1GPA9RyWKpymG2G9rABQYCg8/G5
 j+2IonqWPZXA5QpQMZKBOUMv9KSLxdRQKvXQHbyOjx4ZbTTvh4no/eT4oFQ4kSSz7c
 f0zEwxhCMeSeszOrS2mlPq058PPIywzyL0oz4K/DXteje68hDf1F1JbjqAtyGRSkfu
 1VuLM+o1Sigdg==
Date: Mon, 11 Jan 2021 16:35:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
Message-ID: <20210111163551.GA33269@sirena.org.uk>
References: <20210108123546.19601-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20210108123546.19601-1-colin.king@canonical.com>
X-Cookie: Made with real ingredients.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, =?utf-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 12:35:46PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently when attempting to start the BE fails because the
> FE is not started the error return variable ret is not initialized
> and garbage is returned.  Fix this by setting it to 0 so the

This doesn't apply against current code, please check and resend.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8fmYACgkQJNaLcl1U
h9Buowf/Z7C140455AraBh0sDuBCFIG9HvDvb3RUm0/Xt5lR91JwaVxdYRlBbjJ0
dLSaYFh0GepPSHSAAn+AjVG5dN+26Lck2t/19LRscETOIZlqNwJ+YNY5f/FLJlau
Fe7Z6qDaPUL/WgeDGaY1gqAsJpdVdfGP1ojKEXeqsKjyZnB35D7Ftt9Ouw/v5MPV
V4z2ody8iK6SwNe/kIRIZndr8c2DOz3nodv0nBBuEn+18jdL1twh3CqqiL0eirCa
nC9dqQWuy12SdRHWWv6w1M/lfWqVdZKhVO5/d/2jS2nGOr2bphnJ5/3Hy9ecbF5o
TKGZIfArkmvxX+IAXxXeyPP85xKDBg==
=RuRu
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
