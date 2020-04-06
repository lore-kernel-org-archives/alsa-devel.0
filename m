Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72985C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:51:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29F5206F8
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kzD3Oh78";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvyM70Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29F5206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EACB822;
	Mon,  6 Apr 2020 13:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EACB822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586173873;
	bh=T8JPB2G201IEXtY9alosGKryKAmkDfl6bXQtj/eFyw0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kzD3Oh78ESmKYlKa6CecGvMe9eo+WMk7jj750776Bpw44WMwiJLH9gVllxP3VdT9D
	 +KzTC8bfTj8GXtrCYibnKBNejGYWSYj1Lab4QrZVtheVz7fwzeKB2MDEncN7O4t9nb
	 QRABHlJfRp5za4Gebvh+nL9/IhY9y70K7MZV0v9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEF84F80142;
	Mon,  6 Apr 2020 13:50:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBC6DF80143; Mon,  6 Apr 2020 13:50:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A510F800CC
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 13:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A510F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qvyM70Ai"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F841206F8;
 Mon,  6 Apr 2020 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586173810;
 bh=T8JPB2G201IEXtY9alosGKryKAmkDfl6bXQtj/eFyw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qvyM70Aitm0A8bkQA9KFhhF+YBMwVWKMlbAXpGvIlOPB5IymIJfiYVSv8iP4QkML/
 lQbPiycMFY5IpuJ8pTonEj1ZtW1CKB1V0TAUX7A3Udswogrt1vu4q0RGwwwsVO7D7/
 +pX6sL+5s606/Oy82X+VJEoRkXsS12NDjvAwn6bo=
Date: Mon, 6 Apr 2020 12:50:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200406115008.GA7650@sirena.org.uk>
References: <20200404115225.4314-1-jbx6244@gmail.com>
 <20200406110703.GA6837@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200406110703.GA6837@sirena.org.uk>
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 12:07:03PM +0100, Mark Brown wrote:
> On Sat, Apr 04, 2020 at 01:52:23PM +0200, Johan Jonker wrote:
> > Current dts files with 'spdif' nodes are manually verified.
> > In order to automate this process rockchip-spdif.txt
> > has to be converted to yaml.
>=20
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so=20

Sorry, I just noticed that there are actually some changes in this
version.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

This bit still applies though.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6LF28ACgkQJNaLcl1U
h9BQDwf/TLMzjvaOS/XrkaDPT2V2JBzzwos/AckUmEy1bGBb3gFmfuV5mHpZFfTM
f1svscqWp5VgXssq6EGCwZnUpmyGjo1AcJTq1aYCAgXa65a7c8D8QS2WwzYlFeFQ
NMTO/Vd5q/9qjreQSvqWCXByFF1lSaNX3LOq4F1b8wEloSjFUv33W4AgewOq8g6P
evxzb1IsiIUv9CJsOgz/cPAud4FseYOuh4H1L+TqigrDd4z1i9nUXeluSvmswf0k
WJGHHvU2xxLjFicbQeJrG5VyXHSELl6JRdbojGFPksD2SKTnHXl3+/mLDWHYzFW4
4YhxljCFCaRnx+ofEiOsmPEjt/HEOQ==
=y6jt
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
