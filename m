Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BBAC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFC32070E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TFz5NjE8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLUUdLz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFC32070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A670416B9;
	Mon, 22 Jun 2020 15:30:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A670416B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592832680;
	bh=JNYMlAXCILV6iHpKiMK82/0wAqoINhFwtjyZ7/gk6AQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFz5NjE8e9FIZkcjhYJclgR3hO9uwVHmVG1rsHBBeYDqKh5OnSdxELdtF63mx0QZj
	 x268rZRr5hmsJpICxxtnF1iDPxD5RHKH3TzOeliuOcLq3PsHgbt9uSbjBF34qIHKuS
	 SqQR4A/MwGZGUlYZBcFzf2wKCzII9pMnD01GXaO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ECBAF80162;
	Mon, 22 Jun 2020 15:30:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77C82F801DB; Mon, 22 Jun 2020 15:30:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3BF1F8010E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 15:30:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3BF1F8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KLUUdLz1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8409D206D7;
 Mon, 22 Jun 2020 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592832624;
 bh=JNYMlAXCILV6iHpKiMK82/0wAqoINhFwtjyZ7/gk6AQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KLUUdLz1OihUckEksBNGf0VG+TnR8SxhUnQbaucbW4tto07P6ORFsDA5+ymuOgwH8
 kNsTsF/jEfhFBUzyiaOds40mHplJooMbs0Z2sZYHtPsX2fzJAig2e8AsmYgemVu3jk
 yQluskZj8qTisgzmKxg9zsVfUg6Bbj7zsGC+9ke8=
Date: Mon, 22 Jun 2020 14:30:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 02/16] ASoC: soc-component: use io_mutex correctly
Message-ID: <20200622133021.GH4560@sirena.org.uk>
References: <87tuzb4mjg.wl-kuninori.morimoto.gx@renesas.com>
 <87r1uf4mfa.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.22.394.2006221537050.3186@eliteleevi.tm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006221537050.3186@eliteleevi.tm.intel.com>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 03:44:33PM +0300, Kai Vehmanen wrote:
> On Tue, 16 Jun 2020, Kuninori Morimoto wrote:

> > component has io_mutex, but it had been used at
> > snd_soc_component_update_bits_legacy() only which does read and write.

> this is quite interesting. I wonder as regmap does its own locking, should
> io_mutex only be used on the non-regmap paths? The patch looks correct=20

It's definitely redundant, though OTOH the redundant locking is easier
to verify.

> though, holding the mutex only in update_bits won't help when write is=20
> without locks.

Even with a mutex around the write that'd have potential issues.

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7wsm0ACgkQJNaLcl1U
h9Dq+wf/dpeI7TOdLEeRHmN1aeK/rwaIIBbV/LpsLQ3T5dDMAS1P4aLvpaeTsnNU
IA2olE8xR2FSkm+72D/vB69scZZz2MIlCwJ7xSCjzaCY3gf99ajDoYdCl4zwbnHo
M5yAr/ybPWpam9uje0JLQDShlFulinndp9ExykIlc6KbrTNSepRAziHJKXEqRLxc
CMeBABwOzO6oeIWGLYl2KP/S43uxsDA8RYhenx6+HNqEZUVtEONG5tjeJJQkUHN7
R8s34dLTRjU9W6mO6+/ytmfZlGA8XvjZ+oJvjsTRXYg3HH9hnHyzl7e/mLKI+ukI
KiWcTAI8YfQkpOi+31VzT2hFjD96LQ==
=5oB2
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
