Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59952C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 11:27:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37761613A5
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 11:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37761613A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0A7A850;
	Mon, 23 Aug 2021 13:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0A7A850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629718060;
	bh=SNXPezX13mfcuVusqi9++jw0PbkmIdb33Xu6aIl7Cps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wq7rkcJEy/svzR98kjR8WA7ciROf2ufoN952Cv1e641p7RZ42rVlRTmst8CKZeN6M
	 WxyxhPRIO4yqLVaH6X8MEdcTkzoqK2YGRJDDmkd16h1zHUwgr2HaVzRTV9fbgJBEKr
	 ccbadRNpvEHMRiJPAd/LIcukl7FtVKZyeGTQuvrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 127B1F8020C;
	Mon, 23 Aug 2021 13:26:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3038DF80217; Mon, 23 Aug 2021 13:26:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B310AF800B6
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 13:26:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B310AF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k52MX7bc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B692D6120C;
 Mon, 23 Aug 2021 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629718001;
 bh=SNXPezX13mfcuVusqi9++jw0PbkmIdb33Xu6aIl7Cps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k52MX7bckBei8Fe5kTMVB2Guq+tsMgybPciSKFS/WOBJSWPdQSQrHefK1uwzWYhl9
 9MHzvxwm3QJ/h81UhyWihlSQxx0Opcwd54kc5LFohHqbwrfNAo7/Pjcv7rCwqFrczB
 BnfIDgjJItd6fL0AwMnRidpCgR8qrQy3pY/yUbFLr+Yom3DSo3ppOh8wBPBTVgdUlj
 1R6D/QwQP9KdRt31sdoj/pzvA+HBsi+mn4gmQaXFoEP2jrVND/1YTgNtKzxq3FeWGj
 unVZIblEwxr2bsw8iPpEXlPk7PBQ34MZkkAX0ZIFpIIthS+1K6VUIDXnr6E4juUisX
 VcGfexLSrwDsg==
Date: Mon, 23 Aug 2021 12:26:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 2/2] dt-bindings: sound: rt1015p: correct indentation
Message-ID: <20210823112615.GD4380@sirena.org.uk>
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
 <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
X-Cookie: APL hackers do it in the quad.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 David Airlie <airlied@linux.ie>, Dillon Min <dillon.minfei@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
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


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 12:10:20PM +0200, Krzysztof Kozlowski wrote:
> Use common enum instead of oneOf and correct indentation warning:
>   realtek,rt1015p.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

For stuff like this where there's no relationship between the things
being patched it's probably better to just send a bunch of individual
patches rather than a series, it works better with tooling and makes it
clear there's no interdependencies or anything.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEjhdYACgkQJNaLcl1U
h9Ah2wf/WfM7XjJE/ztslTnuMDDI4tC7FvozpC17wxbK3oNxPlzluBz+r0Bu664m
GEFc1PpVWxMEzRcVVa3axO+jTlNcRqWNpUHPxtINqUdZ1s1JSEsHdvyfdXKAytx3
N9T7OWRHi4LQagC+FRKlVsDY3UkyzL83pCC3gdZXxs3icKhr/zpFePWa9r04yAVl
l3qrndJpATla6IPu9OQuxyPpyyxkChYMkS0KDvAWNscIU1XCkDQgUXnBS0VRUOKP
heIksdtyfDK/93XpGyWRB8PqSba6QMljBLbvRBpGV3v4gQbON/Lvyde4MCmXnoLA
wXaLGSkpbItq31bZJcipEPb0dBZXNQ==
=65Xc
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
