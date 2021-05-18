Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83195C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 18:56:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54E961244
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 18:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54E961244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A7FD1784;
	Tue, 18 May 2021 20:56:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A7FD1784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621364217;
	bh=ngHUXT+f+DSDBSObqrCSX01A2qzhXw+3no7b1VXfMg0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C57J7Y65DPl+lFtsolTrs24q5C6rS10533hv89aXkoDe/a+r/Ofj5MhDqxZNvqkku
	 5QIlbodaN42wDA/nSZDebM8ryk40vu6bZ3ihBos5BJ96+F5bFyvXYfQk5TZFJiR1zA
	 RfCgA5OzAUZomgBjGNsD1SGwzFD3PvqMwUum79yU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAF68F80229;
	Tue, 18 May 2021 20:56:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35CC9F801DB; Tue, 18 May 2021 20:56:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0BEFF801DB
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 20:55:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0BEFF801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YwAbxH70"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB49861244;
 Tue, 18 May 2021 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621364155;
 bh=ngHUXT+f+DSDBSObqrCSX01A2qzhXw+3no7b1VXfMg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YwAbxH7046HmOhfxPAUS3Rr5DA/W4aaYUNEssSGZdgmHnU1bKMZw2GZ/B+Zifp4LN
 v2Z7bK+3OMUDkajDfIarhZg8poplHwMek5tn+zDueYcAbdyId8Kmj27/HhE2B8kjQr
 PZACSYwnZBnoMqw6cezD7LwhRKWS6PT052bbZN1ZPZjSxC7UCiWUQobIqwc4GjtxZj
 YBfElL11OfkGLvmSYdr8mHH+YWe3/5TOEuzRc+Ua12C8vI2cQ7811cx5kvCwhuTL0Y
 wE03nZ2OZ9yZo6ZusMm+mctH/suomFn51bxvVrGm/rIAW0icWUJ79mgjFlwQM3FXpB
 IkHf3SmPL7Png==
Date: Tue, 18 May 2021 19:55:11 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: wm8750: convert to the json-schema
Message-ID: <20210518185511.GF4358@sirena.org.uk>
References: <20210512205926.780-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20210512205926.780-1-zajec5@gmail.com>
X-Cookie: Radioactive cats have 18 half-lives.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
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


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 10:59:26PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This helps validating DTS files.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCkDY4ACgkQJNaLcl1U
h9CLjQf+N+1vWZP2xEyjUXIoDVcpwY20cpELji9dGtr+XKrxJKvfhCkha3PEeh+p
80OB5SHZ53eNQPRw/pedfbXnuC+RUdUQwQGu5L4ZX3KKtQZqST8u/dtQjbMKT6/T
uOQ4O05Is5ZhniCdraNPDb81XmHU9Ead44VJ7qNhWyN7UvBjLNF8vobuk7RLNBrN
nCE7yDDKnFpVS7QNWbODxF8MBbYC922iHNWgYFPGRWRDRwCfKc0USOgpuw3bsHc0
gRCQxkqp25s5tQUOh3A68kBJw3upSTWYBCIDJSrvAw3H/6IuaqolXDCoHoe+eBcm
omrKS7m2/D1C0i+Px16Knxit+wCfYA==
=xD3o
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
