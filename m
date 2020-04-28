Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E1C83008
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:15:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C4020730
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GGGfUcsq";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="et165nRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C4020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26E2F1673;
	Tue, 28 Apr 2020 18:15:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26E2F1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588090555;
	bh=Yu5rOt8UvDrqMgRxGBjron5p4MO36vWB5qX6Yt5qCtM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGGfUcsqWTKD8nSAU96csilfx8zm2mueMgRMv4TmJKDJm0fwte64LX2IiOaWx1LCK
	 H6mztSskNC1vDL26TsTDye+Ykwn+WuXJoAxXfeYipXRNu4/uHHjdCl4PtN+Pw3QYW3
	 f0MrYeZzuRClMnwHrbbj/KP0zBo5S3ZlMx+Jl668=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9413BF8010A;
	Tue, 28 Apr 2020 18:15:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BA3CF801DB; Tue, 28 Apr 2020 18:15:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6829FF8010A
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 18:14:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6829FF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="et165nRK"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE3D32054F;
 Tue, 28 Apr 2020 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588090494;
 bh=Yu5rOt8UvDrqMgRxGBjron5p4MO36vWB5qX6Yt5qCtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=et165nRKumn6cmjPtjcP1Mdc23LoHzzKGn9dt4y7zH7Z2eYvBSfTtBGB3Hy3Q3wHq
 rcJ2lSdvwbWPM/JkOdUnvQDxpMT3slJ+LRR11up7MjMYihIip7dQT4TZOsie7ITkoF
 LOXm3hbMPVals3cVnweUZNNVVSAGLKP9BKFn1R98=
Date: Tue, 28 Apr 2020 17:14:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: Make sure component driver names are unique
Message-ID: <20200428161451.GK5677@sirena.org.uk>
References: <20200427193306.31198-1-ranjani.sridharan@linux.intel.com>
 <20200428114044.GF5677@sirena.org.uk>
 <e5116a2b2be975f07ba29ea438f100bbe93ded76.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline
In-Reply-To: <e5116a2b2be975f07ba29ea438f100bbe93ded76.camel@linux.intel.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
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


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 09:07:04AM -0700, Ranjani Sridharan wrote:
> On Tue, 2020-04-28 at 12:40 +0100, Mark Brown wrote:

> > I would not expect driver names to be unique, you can have multiple
> > instances of the same device on a board for example when two mono
> > speaker drivers are used for stereo playback.

> Maybe I misunderstood your comment in the previous thread then, Mark.

> https://mailman.alsa-project.org/pipermail/alsa-devel/2020-April/166665.html

> Did you mean to say that the individual drivers should do this check
> before registering multiple platform components to make sure they are
> unique?

That was in the context of a single DAI link, not the system as a whole,
and only for platform drivers not DAIs.

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oVnoACgkQJNaLcl1U
h9DEUQf/dcSmwqs67ASJxjKqHjXzbis6y7YoRIHPI1xaZd0vJm14j+lgswXO5B6Q
TejfPUURHy7twm7YU/qDVvQ8LALmByfKETIcUS1sLzzrxuZ03t3gi5XbCIYZaoMc
np1EqB7eVzaSuyPu2+vfFXpnLrmvi52amHRG4HlelINoB9zVy+G/O+SrgvnirS4Z
+NDN+HcruGOq2wXm+uR45BFgYyHtykioJkVIH//vAr2GwwgIOTmf0nVJjCTx663k
H/OPDCWGw2+BdW+I5WN/zaeyWVvPIP+siuZDnUCK3hWrWO0Mp9gTjaLzt5mRsmXM
kZlUfoEKriX+i4PvBgmuHwT8OUsrMA==
=4Fze
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
