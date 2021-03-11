Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D1C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF41C64F93
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF41C64F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7323218AD;
	Thu, 11 Mar 2021 17:17:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7323218AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615479500;
	bh=tC8xQLvl0ED5iaAOUU3NWeADhke0KZJuMgdD9l7TFWA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qsf1wRaCRPuTp9Q7ql7fvjeZxAW5YXcaJXYjhKmm2SZxrNjiI8iyNBNYn6lOyqlwX
	 Tsc0x23oER/eO4R5YacYNjnrNEn6eL8pJj+zRdL1CyGTorFcdmKQG4/Qvx6e7thAhn
	 xu5FqyffAXI8vBQZisg1vZNsQik0omwmLPD8C9KE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2B23F8015B;
	Thu, 11 Mar 2021 17:17:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D5A3F80227; Thu, 11 Mar 2021 17:17:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCDC7F8015B
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 17:17:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCDC7F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RyuJ62MV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCD8464F88;
 Thu, 11 Mar 2021 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615479432;
 bh=tC8xQLvl0ED5iaAOUU3NWeADhke0KZJuMgdD9l7TFWA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RyuJ62MV0j1/0koV3tq8MZh+/x1RDJHUX5qSrZ3paxvAockMHvG17rC8qJac4MdSf
 sHjsYIzxL9OLh0PxPjAaWR59N2TlKSdwzPDYcFN/PIrCOxPJ1Kg4hn4kpogdt23424
 7fYazPCBxabTn60iy1PugT4Y81/xcWpa8tySmBCpMPyACfFXtg8I9dYITP4zcgVR1v
 xCS5xx73GHuHAf8z11KTd1NiFz5+tksiIeZTJ5ce74kJntcxiJJu8LL87Jd7wMuOYK
 E1XQe3JZQXwXi6u0TyBhVZzfePlBs7lF2b2B8LZhOh43QTbgnL1VbK4fi3FFU2ApBA
 DycL7AFAZDTxQ==
Date: Thu, 11 Mar 2021 16:15:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
Message-ID: <20210311161558.GG4962@sirena.org.uk>
References: <1612939421-19900-2-git-send-email-spujar@nvidia.com>
 <20210309144156.18887-1-michael@walle.cc>
 <e8b80188-978c-29fa-b5d4-9788a9f2282f@nvidia.com>
 <611ed3362dee3b3b7c7a80edfe763fd0@walle.cc>
 <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, robh@kernel.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 Michael Walle <michael@walle.cc>, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2021 at 08:20:28PM +0530, Sameer Pujar wrote:

> If I read this correctly below is the configuration you need,
> SoC -> MCLK(fixed rate) -> PLL(wm8904) -> PLL output (256 * fs) -> sysclk

For this device for integration with something like simple-audio-card
since there's limited flexibility within the device the simplest thing
would be to not make the internal clocking of the device visible and
just have it figure out how to use the input clock, using the MCLK
directly if possible otherwise using the FLL to generate a suitable
clock.  The trick is figuring out if it's best to vary the input clock
or to use the FLL to adapt a fixed input clock, and of course adapting
any existing users if things get changed.

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKQj4ACgkQJNaLcl1U
h9Bm7Qf/VJ91STTM9RrXZ6oXyjy90lybK+uguct6tIBOH/cCBlf2qGxlWOIaKw2w
ybRwqTEJm5fKKRDMqvUBk7y7O3VF9onjg5x8N/+FcbPgrK2hEuzBJQlzEn47GEpK
wangKZc80y5Sz7jPi5yK2dRyMfClSIyv78y5rFHcetDHH2+xLFz7com+SEczQeyx
gBNaIJ7xyQb6/KUQQLPO21wTy4rzFpurRatmPJTVlUM1qREmptX8SB5lRFXIb8yJ
gYp353sgoWIwm71bhZl2xtBuNyZJg7w4TnvPIaEBPi/cjaQvSUohaDJXui1tFITq
JF2ZCpVivFlMaIgQNfKfH+lSv5Feag==
=OLq0
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
