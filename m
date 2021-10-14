Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D45EC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 19:55:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AF6610E6
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 19:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30AF6610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A76EC165E;
	Thu, 14 Oct 2021 21:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A76EC165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634241316;
	bh=wo6BAwjiiEqa8jhEFac5jjrzRbnU/STDnLvtcmAKWps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B8nl3Y0a9gHAWmebskq6v8TOtffhzT9aeh0ByNeZJlZLeZh3OjfCe6CDkrV8GchcM
	 M+l/SL7ulZ43u4lI00CmcJQ2HHGGDERFceH5xfl5ct/oGmwLcoY8RFYNHgLu4rdato
	 798+jb6yEJhfb3WaTnJa+ZxWKspSdW/rPiQlnhtA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C5FFF801F7;
	Thu, 14 Oct 2021 21:54:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83D8BF80212; Thu, 14 Oct 2021 21:54:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71F79F8016C
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 21:54:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71F79F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ud7YaU7S"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4CFE610A0;
 Thu, 14 Oct 2021 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634241255;
 bh=wo6BAwjiiEqa8jhEFac5jjrzRbnU/STDnLvtcmAKWps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ud7YaU7SkvUkXIxz91SvXpICf6Lqex4voRqwwyQQDUvV3qKK/sDUeE4V+PLWal79z
 i/xcJACVpOr+Uh9TdIXbuBOm+okfsqtRhIEM9cARO76mZiQ2x5Z1EXFHskJsXowuSK
 hdP3A/82lCWuFmHN55aFCOLAVkerdImcu7UY7Pq7y9qdduETUM6L4kPNyPT0+9aok9
 q4/K4C9u35azIVOngg8mgjtKJm1G4ZoauETJoFUjHyCjytbILsOpGLVWTL3glxxXxz
 mpIKV9GF8BGRCgrQE+syTHdNo+tsApHpozEpvH7z3aKaN/0pqrRsTYgMrohhqjUY+9
 IzAVDNFcVzt4A==
Date: Thu, 14 Oct 2021 20:54:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-component: improve error reporting for
 register access
Message-ID: <YWiK5Hq5Cyt/8Kq0@sirena.org.uk>
References: <20211014161330.26645-1-srinivas.kandagatla@linaro.org>
 <cdd5fb0f-ff3e-9da0-1ea4-1d1ae5e982bc@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rtpS0x/rRirlfQRr"
Content-Disposition: inline
In-Reply-To: <cdd5fb0f-ff3e-9da0-1ea4-1d1ae5e982bc@linux.intel.com>
X-Cookie: I'm having a BIG BANG THEORY!!
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
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


--rtpS0x/rRirlfQRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 14, 2021 at 11:31:24AM -0500, Pierre-Louis Bossart wrote:

> BTW while looking at the code, I started to wonder if it's intentional
> that we cannot check any error code on component->driver->read(). We do
> for the write and on regmap read, which suggests this API is problematic?

I dunno about intentional but it's always been that way since ASoC was
originally merged, it's just that nobody's ever changed that as part of
one of the refactorings.  I did add error checking to the regmap read
interface when I wrote that but I wasn't about to go fixing up all the
ASoC drivers for a new API.

--rtpS0x/rRirlfQRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFoiuEACgkQJNaLcl1U
h9ByXgf/df+gaTCEozPawBCiHh+Jji4HpPaLVivkIaqafN7257IAOgNIQaZpUmno
zL1YMFVxF/EsTziLTi5Yq5e5c+8EhqVj8MiprF02Eu4FnB34ofwNASm2onA2PQr0
h14Pkp74R14BAJHUUgNapPIMFvDqvb1t3BK0hARx0sEElYYHduqT+nuCuY3ZxKgg
E5UDf1z/oqvToDmBIOfrUs5KAefQZ+YrXeQ0xdQcFTHIb7oChU0Kfd329R3mZKE4
VZD8IIkPHmgyes6NrSFcRX1yQxEixKgtiYMtHJNmfedLmlYNjKFg75V8SIwzrQWH
bBF49p/Fa3O6xteZNWu8SO9NFxOm4g==
=MkaK
-----END PGP SIGNATURE-----

--rtpS0x/rRirlfQRr--
