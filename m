Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C765C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 14:55:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68CA916F1;
	Tue, 12 Apr 2022 16:54:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68CA916F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649775307;
	bh=jn+HPq0xNAFgDzP8V3hRx5PLN2FH+2mWWa4YP6ifmQY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLD/Op+dbN7MN3SxS4FfTZSHZvJhBMHNGpbzPNMEMk3ZFQVYRK639lZENFExdMO+A
	 ByvXJfRETb0E5TbzamM0qZ7y+EVHfMvQJFjh7jXIr8Ru6Kp7hyJRkHIBT1Ywi1X4FE
	 LQ3JG8wKbFdBArPeF34ABG6v1oOgXQbJfyon/ujg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09EFDF80134;
	Tue, 12 Apr 2022 16:54:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAA5FF80154; Tue, 12 Apr 2022 16:54:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DC66F80095
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 16:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DC66F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uYqWByj1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AFAFD61328;
 Tue, 12 Apr 2022 14:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F850C385A9;
 Tue, 12 Apr 2022 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649775249;
 bh=jn+HPq0xNAFgDzP8V3hRx5PLN2FH+2mWWa4YP6ifmQY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uYqWByj1LGRWd62VvgVb06IMVNi8O8thYWoCvZ0da27JkCm19VykUoT9sWoSuQ6Vu
 wo+aNoJffdwEjC5hNOUSVAIUSASxptGVk9VTzNqmh/QvSXCUlLich339ISRK1YuwgH
 YGSe1e84Np5ZgdwfBJ01dZNwQzWH1ZehsGsrngFyaXThpCyPl18W0kF5XGOjfqb81/
 Cm9KEBAMtwToNEi/et1gd41BWlQom/If85rOttrBaOf0pjeJ6Lzob+zY8quiPmXY1H
 Zogvcn21MeSoussmKdnhe2gubm2Y2kWun5w9xfKe+8rsaKkHKCXOz5gG3fc+O3gzVl
 stdlieOa4WmeQ==
Date: Tue, 12 Apr 2022 15:54:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v6 16/16] ASoC: cs35l41: Support external boost
Message-ID: <YlWSife2zTxAXY2u@sirena.org.uk>
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
 <20220409091315.1663410-17-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VIQAQDLg4VJbto2M"
Content-Disposition: inline
In-Reply-To: <20220409091315.1663410-17-tanureal@opensource.cirrus.com>
X-Cookie: Approved for veterans.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org
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


--VIQAQDLg4VJbto2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 09, 2022 at 10:13:15AM +0100, Lucas Tanure wrote:
> Add support for external boost voltage, where GPIO1 must control a
> switch to isolate CS35L41 from the external Boost Voltage

Acked-by: Mark Brown <broonie@kernel.org>

--VIQAQDLg4VJbto2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVkokACgkQJNaLcl1U
h9CeiAf+MUH9JwPfSJSPk+FELVgYltt6oeP0bUojWxoTfsXCB7Alv6dSt8iGR98p
YG5d1451qcl+cPeJEER1IFpY6MyHOGa69eFWUJ+n/8wMXk9M1oFSEuL8M3ttQMuK
ivYRnYwut283M6kBom3W7m+Tqc6lYO8X0PXuvAstQWf6kMWijnhfzMn2wE/QO4OL
Cjj9vjXEQbtFPfOokaug3I5OaiZ8Y3+5y6S74ja7HQ3vh6bk4o8E9ivOJ3Mi9fHg
ilKPmX9n1/OggwkIIreU7fr4SBTIQ5C9ZR4ATDLFulqtSz07D1bed5SEeZQhVisr
0V4PR55aQD2Tp/lp1W4ngcBUTKMW1w==
=D+Z6
-----END PGP SIGNATURE-----

--VIQAQDLg4VJbto2M--
