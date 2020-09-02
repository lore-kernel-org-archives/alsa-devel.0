Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52BC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:40:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF742078B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZigrKae5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTaELI0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF742078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2069B1815;
	Wed,  2 Sep 2020 11:39:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2069B1815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599039620;
	bh=rz2YWRkFtHiLU3bmkGJDyuxnYo1QLy/1GAkH2TvuQy4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZigrKae5YMovxR892+dJasl5B5pKkHsqKGgeoo2B3HFDKoa7Wc7EgA0zOJwX0syBF
	 wDvZzgiWLZKKbRoXaPX3oyTBhLSaBc0kKOVi6D9EKcXtuixozOuSGPPpKhb/aCP6Yz
	 otTXkcPYHCjeLz+8bg6ZK8Wn1FQUi49bZRFHK95Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C24CF80212;
	Wed,  2 Sep 2020 11:39:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9190EF8024A; Wed,  2 Sep 2020 11:39:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68DF3F800F3
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 11:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68DF3F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TTaELI0X"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DEAF32078B;
 Wed,  2 Sep 2020 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599039560;
 bh=rz2YWRkFtHiLU3bmkGJDyuxnYo1QLy/1GAkH2TvuQy4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TTaELI0X+vFIqmDdOPtbaZhwErfWjpQ0RAy/MwmQCOc8QmzTqk8EUYhTSW0i9260Q
 0Vu8qjH5yjQjwzJGRCOgC1RzcZ9DxGa4IIleV0Ptm0EUXUWS7ir/A80wCULZcRWJtR
 jQQE4bTv8OZul/4HnR41sT+Yh21vk47YRIXH6CE0=
Date: Wed, 2 Sep 2020 10:38:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200902093839.GA6162@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
 <20200901110349.GC6262@sirena.org.uk> <20200902091038.GB13726@pi3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200902091038.GB13726@pi3>
X-Cookie: Prices higher in Alaska and Hawaii.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2020 at 11:10:38AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 01, 2020 at 12:03:49PM +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.

> The usual prefix for bindings is "dt-bindings: ..." so I wonder what
> type of prefix you expect:
> 1. ASoC: dt-bindings: ...

This.  Bindings aren't a separate subsystem.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9PaB4ACgkQJNaLcl1U
h9C8/Af/RVJ7XZs6bEQHCNhy0ziMmQZGspvtRHWnmX5UKETH//1s3kNWWwFDZiSW
sCUAusHo+BU1ZkDIjWW+jmdlz+brViZjKjGyiwP2OHyjC1l50v5SfBUappHthFKq
Z8H+fIgTVcCC2VF4XTWkOvzNZKBYmplCbB2QrwSARpH/FG9xwfs5DXOTTjx+eYz1
ui/iHHGilY4jpTT/qCN5aOKvnUYPimbNISqviYmYt5+zgABexoq3pDGHra1M7kHS
Sv9ghpXtt/BBqb3eNrE8ITot5fOXQ4uD7UMbCECk4XkqFB/fJPLW06LfV0qqu4Ej
6Ba2iB6hEEoMX4MGcgDNpYkcFYOybQ==
=sHL4
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
