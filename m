From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/16] ASoC: core: Add strobe control
Date: Tue, 13 Mar 2012 21:33:57 +0000
Message-ID: <20120313213356.GE3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0541934667120352249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A60221043B9
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:34:00 +0100 (CET)
In-Reply-To: <1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0541934667120352249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 04:11:32PM +0100, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added support for a control that strobes a bit in
> a register to high then back to low (or the inverse).
>=20
> This is typically useful for hardware that requires
> strobing a singe bit to trigger some functionality
> and where exposing the bit in a normal enum control
> would require the user to first manually set then
> again unset the bit again for the strobe to trigger.
>=20
> Get/put accessors added.
>=20
> snd_soc_get_enum_strobe
> snd_soc_put_enum_strobe
>=20
> Also a generic convenience macros added.
>=20
> SOC_ENUM_STROBE

Based on this description it's hard to see why this control is patterned
after an enum - why would we have an enumerated control to bounce a
single register bit on then off?

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX702AAoJEBus8iNuMP3dgGkP/izTxWXM08VA//gfDkFilH8G
uNZ7n+a8NRT2SOp64IH5pZQ4dPJ/M8NYahBetb4Hg5EGM7wws8M8pMe2d+tq77v0
wAlELk2Aj0ENymwdYA3SOD7a1HBEm6ptJCIMnK3PPykp12n5TtkHK3g1P+K6TTrq
/QmcferofYkwNNYRukePfqqW7Q4PFD28+IIImdqGbnRhWShpwbrWe3jManxsIhgK
F4C6s/LTBkw3J3GPToBLxORPA5lXXV1FEqM3HNgmh/e0q6Lad5mUsg8e5YXiTEVX
484OL0nUTbo2PCsgxg7MKTDYi2KK9Jqj3ZxrnGr+gBS/A3VqN2XcSaGEjbNFpa35
y0LJ1e3Z7179cMVgKJef69WlX7a8Apn79DG6eMaMIKZobu57tMXRQGkPNlASvF98
uQ1iMUQc2XZ41+XKajdGFwh9RGojp+1OwkQzPfRknecuQLM5cridfuoLuBQIuGJp
ZJmckMrEID4AmVIUatj0C1E8dJaDzMamhdM35DSkdIq2ZIPDCn8fkYJAcDWelsEi
mFEoyb+ua02+rW/eJ4w6e/5KxHchpjxAarZGuhVZ/jWUEe6LACvZELOWpETp/fE2
TYVVt5BjT+dtkCQQ6HaJNv3WpObyt+H495XMS/1g0+Vd2njAUd2VuT6H52jgrk7X
v9RpAonIJehqXVi/jhhZ
=eA2z
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--

--===============0541934667120352249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0541934667120352249==--
