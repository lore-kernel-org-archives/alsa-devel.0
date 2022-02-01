Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF804C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Feb 2022 18:41:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44AF086F;
	Tue,  1 Feb 2022 19:41:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44AF086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643740911;
	bh=PrSLte2Y8GuTj20LkcJzvcJPJ5q1SnDN7UElQd5zWDo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4nuReiVdF0rCy+xTX0bBXdMx5W5HteWU60eDjRu93/qoTTCF1mk3+6sLqagYd+gA
	 eOyO57/NMnjTX60MuHh+4IG0UTzNZpn3ci+yDinVxraosOrDRkN6AQxAylv/a1Q5uf
	 Y9wTyZ4KfT660knpRs/pB15Y7pHhkeZUUfHPPlcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D559DF80095;
	Tue,  1 Feb 2022 19:41:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F157CF8012C; Tue,  1 Feb 2022 19:40:57 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D3B4F80095
 for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2022 19:40:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D3B4F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L43sT9Kq"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2CE61585;
 Tue,  1 Feb 2022 18:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836EEC340EB;
 Tue,  1 Feb 2022 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643740851;
 bh=PrSLte2Y8GuTj20LkcJzvcJPJ5q1SnDN7UElQd5zWDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L43sT9KqPOoqnvCZOntutRldNjFfzj1k2sJk+iGjKSKstlq/Z9jpDBGJ01TxaYuXO
 TI4EN5htJh1ArITS57Rn2xa7SssQfBg1TUHmho3e0qWm4ZTjinQNjtO63RPkMLXaYS
 IcsZI3hWpeStKzJYjz+F37l7VFE9+nQ5eApNYzf6DtO8Wm4Xwap5oUYq/+21I3xXcw
 G0QLXN1FonUxiR7mHWAL0+WIBqNq3xXL0Vv5FvRtn6i88q/TGeojItiyBap72VR6Ud
 krR72SV1TfX18i+A/F4G3Nhaqkn00DeFPKvnQU3B0+KdIo8EJ/sGbEaQVDBTfhaMsJ
 ej2jq7FzVdFAA==
Date: Tue, 1 Feb 2022 18:40:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@gmail.com>
Subject: Re: [PATCH] Revert "ASoC: amd: acp: Power on/off the speaker enable
 gpio pin based on DAPM callback."
Message-ID: <Yfl+rZEucvLEmFjD@sirena.org.uk>
References: <20220129000837.6207-1-cujomalainey@chromium.org>
 <a8ffb740-9f03-340f-a7ba-5e0f1a074b22@amd.com>
 <CAGXAbSq4+YY3qNt2c8J-P278QtUMTkJAo7x3=6UvJof4bH2C2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VMfhuoaL2M7AAQLU"
Content-Disposition: inline
In-Reply-To: <CAGXAbSq4+YY3qNt2c8J-P278QtUMTkJAo7x3=6UvJof4bH2C2Q@mail.gmail.com>
X-Cookie: All's well that ends.
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
 Curtis Malainey <cujomalainey@chromium.org>, Eric Peers <epeers@google.com>,
 Rob Barnes <robbarnes@google.com>
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


--VMfhuoaL2M7AAQLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 31, 2022 at 10:39:00AM -0800, Curtis Malainey wrote:

> > I feel instead of reverting this complete patch we can quickly submit a
> > new patch set with "gpio_spk_en =3D NONE" for maxim codec case. As codec
> > driver is anyhow controlling that gpio we don't need to do it from
> > machine driver. We've already done that here
> > https://patchwork.kernel.org/project/alsa-devel/patch/20220131203225.14=
18648-1-vsujithkumar.reddy@amd.com/

> I'm pretty sure the proper solution is to shove this logic into the
> alc1019 driver like it is in the max98357 driver. The header is
> already there for gpio which makes me think it was planned but
> forgotten. Otherwise everyone else who uses this codec and associated
> pin will have to duplicate this logic in their machine driver.

In general if there's something like a speaker amplifier that's just
controlled via GPIO I'd expect that to be something that's set up by the
machine driver.  If the CODEC is a GPIO provider then the pattern should
be that the CODEC registers with gpiolib and then the machine driver
uses that GPIO, that way the GPIO can get used for any other purpose and
if a system picks another GPIO for whatever reason then that'll just
work.

This gets more annoying for ACPI systems due to their lack of
standards based enumeration of course, the endemic reliance on board
specific quirks causes breakage all over - it looks like this is just an
example of some ACPI systems using firmware description and some not.
Are the systems that need the hard coding here shipping, for example if
the Windows drivers rely on such hard coding rather than enumeration
=66rom ACPI?  If we need the quirking then the fix isn't just a simple
revert, we need to do something that ensures that the support for all
the different systems plays nicely with each other.

--VMfhuoaL2M7AAQLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH5fqwACgkQJNaLcl1U
h9CQ9Qf/XBOtfiYK3ct17F1nMgVqtWxcy+T80wp69Sf2Z+FG30XmrRJrTQ2OJgaH
vQbURI/pTKuwOyXfcgEyQnVa7BKECIc+BgWtglXP9f4xScoB0qbkMqFW/4TDxUs4
Q5sayjNXY4WA0wIPtRgiTA3d9WJOtoj1OCPCXOk1VtLogwoGLW7N8mXjb8MBR/0C
1ria7ihXTHMhYg/iXxUrrI1TYrOkgq+eKyHNAs0W50eL5qvD2Ywu8GxqcBpzH7u/
5UygsnxtWjmVB7Fo8BF6IlPI2tTYHrohhDtOt3371v2TeLGRZdCUHWP/o/a1yfa2
HHJ3H/LKOcWJATNzV5VJ4RA+11Bpqg==
=Iw3b
-----END PGP SIGNATURE-----

--VMfhuoaL2M7AAQLU--
