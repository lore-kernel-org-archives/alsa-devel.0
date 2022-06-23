Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21584C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jun 2022 11:05:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9701EDC;
	Thu, 23 Jun 2022 13:04:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9701EDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655982306;
	bh=aIdW+I8dNqFwqnLgbomd19CUJMezjB4BlkNogKF1XZo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+3c2Y5JWGuzBCtFbjeL7vgQrSv/6ct/bX1ChOtrYpfWDbIlkpZKjc8L81oscJIEt
	 wbec1CzEYhSVS0NDNVb8Uh38t/9xDY/A9lspXqVv8T8hX0nbc2x9i2tFehwJn6JJnj
	 mvVnE7jO4Hpn4EQ4zBcA96nhJDq+9SrkL6i7LyWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC84AF804BB;
	Thu, 23 Jun 2022 13:04:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E044F804C1; Thu, 23 Jun 2022 13:04:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8991F800D0
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2022 13:04:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8991F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f94JHIY2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 42D8661EC5;
 Thu, 23 Jun 2022 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D82FC3411B;
 Thu, 23 Jun 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655982249;
 bh=aIdW+I8dNqFwqnLgbomd19CUJMezjB4BlkNogKF1XZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f94JHIY2LJbI2Z629AcUkVoFj6tJtMk6c6chxLzm/Y40OJmm/H3oD/tx9PhFDkM+R
 akJg1h/M78V9YOs135hgonnv43OiVa/CDM/PR3a1YGeQ/5n+hYZLJQhmIaeIR/OOCe
 w/liblWEHu65ul29/nr2gN8BWFXIuCAw/++yEk3UfAGWrbxzwEldfC99bk84QTNfHJ
 Sm72tCN2sIz+b+wNKtmui59HDfV2Vx4S6YA1Q2RgN4ke86e/9aHDiF7lqDVRpOsFmS
 ApZ7rzgErYj75gj/K3Lkw262ujnaGbyq0Q2caYXBeuhL3hc+ZnRSXTUufhqvmBzQ8/
 FBE+onHEaBEhA==
Date: Thu, 23 Jun 2022 12:04:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [PATCH v5 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <YrRIo62na5FCCa06@sirena.org.uk>
References: <20220623021153.587423-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bAAQzJfUr8Tz2hZ6"
Content-Disposition: inline
In-Reply-To: <20220623021153.587423-1-judyhsiao@chromium.org>
X-Cookie: I had pancake makeup for brunch!
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
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


--bAAQzJfUr8Tz2hZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 02:11:50AM +0000, Judy Hsiao wrote:
> The patches series is to fix the unexpected large DC output
> voltage of Max98357a that burns the speakers on the rockchip
> platform when BCLK and SD_MODE are ON but LRCLK is OFF.

An earlier version was already applied, please send any changes as
incremental patches.

--bAAQzJfUr8Tz2hZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK0SKMACgkQJNaLcl1U
h9CrCAf+LQBNxKh07eXpoNhG69/PzuPmq/iy71grFtQtZnGyzGn2Z1HDltI4l5pW
ac3Pqo+XRj3DYnI6TbysWctR7ZrsootwIfuugKZ4zSLxvC4RX94EnKxKsOSDq+6Q
2+eFccgAih/GvhGR+RXmtx72jixO0eq2Ywpfinfn3+TsbWQSNL6MbyHX1WsErIqR
+OUii5syBaM8/AlOwbJBz53Ad0beGnKYGk4TvN4mNugXh7QIHNX3tRRomZ95A+Kn
f33IjTorYaXsJXsi/3OUT9/Jhb5ZBH7gy+2yVUsRbUH5jQzyIgVAYcHvTRSb0B1A
zP0bwOPq6qUNV60QFV8VXDwMqGzYTQ==
=K5QJ
-----END PGP SIGNATURE-----

--bAAQzJfUr8Tz2hZ6--
