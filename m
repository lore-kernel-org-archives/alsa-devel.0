Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8534C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 11:51:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6FE6108E
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 11:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E6FE6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 914FE1691;
	Mon, 20 Sep 2021 13:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 914FE1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632138663;
	bh=V6kgYgogW976xpByhMqKFGsk3ORwS5VxWZ+29DRMxHY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRnb/tfUDgWnYZ9k41ChK96MZk/Wos56dYYkBgJb4MVVv8Fn46hScbaw/Fxnp1Gb7
	 IF1D7VjD+IPvZvClNC43Q1Nm1ZqMGj9p5MeMGyvF+ll3mWinR3ISHcr3h7tOlabHA+
	 3WYtQths8jO79n0YpNCA1IAqhETx6fscb8UzXbYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 204A5F80246;
	Mon, 20 Sep 2021 13:50:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E430FF8025D; Mon, 20 Sep 2021 13:50:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D013F80152
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 13:50:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D013F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AlaozWlW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE1E6108C;
 Mon, 20 Sep 2021 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632138598;
 bh=V6kgYgogW976xpByhMqKFGsk3ORwS5VxWZ+29DRMxHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AlaozWlWlARDWspL5oZTclqYkhokylGOFqWGYdLdB02cO47tSDd7L0tudUYAx3dFf
 txoMY4xg7OH8bq+ztj99ZgC8Kdaa4BeMHN2IR+8LKff3V/XnyRCOiX3nIr8n4WYsgO
 wPii8/jg2yFfALwoeAkHFdW2J1A3Z82epJbqEX5sJZFIhoddEzzQt1xlAkrU8N+6JV
 ALX+HYfiiIK9wg6jAUHh3l0F8m8maKsuO4amRpPX+xwq3B2TL58aWCkXlXsG0eYDQq
 m3wPWMWnrVgQPWVMX+2NRvsUwSf6peLFQBTpbbfn2715FyElDuxOSeuoHl2dFob08F
 Zz2N0RgiGWezg==
Date: Mon, 20 Sep 2021 12:49:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <20210920114914.GC4192@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <42974939.Tn3hggVSkZ@archbook>
 <20210916122549.GF5048@sirena.org.uk> <2435067.tOv7cHfTnj@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <2435067.tOv7cHfTnj@archbook>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 07:38:47PM +0200, Nicolas Frattaroli wrote:

> Going forward, what would be a solution that is acceptable for upstream? =
As=20
> far as I understand, the obvious route here is to drop the rockchip,fsync-
> half-frame property and just always set this mode when we're using a TDM =
bus=20
> format. Is this correct?

Yes.

> According to the TRM, the register bit this sets only affects TDM modes.=
=20
> Though since TDM is not standardised in any way from what I've read onlin=
e, it=20
> is possible that there is hardware out there which expects the non-fsync-=
half-
> frame mode, but I am completely fine with only thinking about this hardwa=
re=20
> when it actually surfaces.

Right, we can figure it out later.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIdToACgkQJNaLcl1U
h9BGIAgAgRW0++RxUFblbEgs7rujuZ+mmldKzxR18cC+Os/498LvNXyA+iEO49w8
uKcqHbz77yNSnVJj8aJhhLin6Xie6m755h+PFnlZ2IbjCRrfHT1QPP3sPmfJn3xW
RrZHrQX3kKPb3Tbm8s9tdz0E1HgjkqnrlETHnGbXYL5RUv2/SzDQlAD40i153a1T
vcaIhIvmIH5un/jbFoJSPlp11EQWsMN1dz1CvWaT4m+3AsU/oht57XdVeJHk53h1
HjXefXq9ZE6bjHSwudceZtHvM4aFf+3IVmRM4i9ZKHF046mOYWxw+49Z3dTtA7Bi
ipwsNPQOMZGPIfZTgZ8+ST/F4aJTlA==
=xhRq
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
