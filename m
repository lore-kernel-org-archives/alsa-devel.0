Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FDAC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 12:45:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD851613C4
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 12:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD851613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF5321664;
	Tue, 20 Apr 2021 14:44:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF5321664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618922728;
	bh=qqNPH35jLf7Mal3dFe5p7bxPdqvfoBqD7Fun3644sf8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPwR3EJ4850yBDQLxLrZ2RbrcHvscy3CXPsepdMcKbcCbyRGjyY9Nxy3R7t8/u7u6
	 uD+dah0mAz/XB+WYXug4ryoc2mXW2LWAHskqAS5bfW73VGAeC0GDxjquPLTCwQXhHY
	 VBnw2UXwj51M+iOE1uUTzUG50hniAqbi/0TuJAbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FBA8F80168;
	Tue, 20 Apr 2021 14:44:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA16FF80253; Tue, 20 Apr 2021 14:44:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9581DF80164
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 14:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9581DF80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KYQQWUTt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DD086023B;
 Tue, 20 Apr 2021 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618922669;
 bh=qqNPH35jLf7Mal3dFe5p7bxPdqvfoBqD7Fun3644sf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KYQQWUTtdn/9s6nm6C4lAjAS18QLTXrmhAivIBXubu/0yHxT3bNf9vOvrQ9q0QqTq
 UIqpzrdojSDWeExw+9AIa6FPzMwqdrGMZjTdcS4thU5Nx86RR+m7eCFZoKt74bMpbP
 p7nsGT7KTK0jI6P/clfOSJwCe8wl93APDxxP90V305l5wlfptPXPb36LsDurp37vHy
 ryhi9qOavYQH6fp3Vdt8jpZq/lzpXxApltCJA6myysZKofYJb7zhLp9Xt/BhBwLipa
 qg8jVKRL/1RDiixPDrKUGlvsCM2zO7FIFrOSVWeltmOSVPZ+vNbXKCGog3VNk0BMZU
 Pi2unapZctd+w==
Date: Tue, 20 Apr 2021 13:44:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: Question about soc_pcm_pointer()
Message-ID: <20210420124403.GA6073@sirena.org.uk>
References: <87fszl4yrq.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <87fszl4yrq.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Falling rock.
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 08:53:29AM +0900, Kuninori Morimoto wrote:

> I noticed that current soc-pcm.c :: soc_pcm_pointer() is adding
> both CPU-DAI's max delay (= A)
> and Codec-DAI's max delay (= B).

...

> But I guess All-DAI's max delay is very enough for it.
> What do you think ?

We're looking for the delay through the full audio path so it needs to
be the maximum of the DAIs doing transmit and the maximum of the DAIs
doing receive (ie, all CPUs and all CODECs) rather than just the maximum
of all DAIs.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB+zJIACgkQJNaLcl1U
h9Byggf+Okt0kNVUnHIFLUaG01UrcUzNT5JkfkVrx1PdvEs7hlM1toJAmqnKvdwD
P2xJ0n8D5TXrYzjHk3vC5m2yKIHLwxUeCbT3SG5wXlFsQyYuGChCho7aWaDFk7uj
b29h4r3vl5Zex4DDiPFPHd7osgV9Lj2Fq4Ncrg3n3g7uVcFvcvuN7MSdzoVeRr0A
h75aCNckNcNreuA279RH0UJqXnHUzqGh79ux0wuMF2PADxkeKLqa1ySIPvt3jCut
MJryjy84+lBnyncWKI/hj24Gd9mfnHwuPbaKw3EkYMjbz6iJulyAcGXCzkNyV+Y4
4vvx+hKqArzewcdg45TvRAeT/LaysA==
=41oJ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
