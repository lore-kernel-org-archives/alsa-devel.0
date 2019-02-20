From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm_adsp: Update cached error
	state on trigger
Date: Wed, 20 Feb 2019 11:54:21 +0000
Message-ID: <20190220115421.GA9878@sirena.org.uk>
References: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
 <20190219173157.14611-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7397694404757092291=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D44FCF80774
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:54:24 +0100 (CET)
In-Reply-To: <20190219173157.14611-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, aford@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7397694404757092291==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 05:31:57PM +0000, Charles Keepax wrote:
> From: Stuart Henderson <stuarth@opensource.cirrus.com>
>=20
> If a compressed stream is restarted after getting an error, the cached
> error value will still be used on the next pointer request, preventing
> the stream from starting.  Resolve this by ensuring the error status is
> updated on trigger start.

It's better to send fixes at the start of the series as this makes it
easier to apply them on a fixes branch for sending to Linus early.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtP+sACgkQJNaLcl1U
h9AivAf/VMVx/helHpkdsid6LnNgelVBjP3uwwf32Kr9bw+VEMpZuIWxPaoAgS6G
NlFkJv4Ub9XgJHwaO6j7Nd28EUTOFgu17dfNwp9L7WOaAuFpAtNhuvITzB/c9RI+
90xyNRXpavC3eRGOKV/zuwqod0aRdT/v9+V67wiZ6bvI5NzAJhYHRgs2ZQ9Kr/Ye
UXHbfcXr1airUmCzEbQqwxpBsQBHoihiRHp6qSJ1fI5STwASt887AzWpFP+cLN/x
u3nUhJlFl7GpOwMElqVhm6geA7pRroIMCujcJ0EtlXc2mqkcSjwwamCSdRD4rxhC
5PjkeBdoiaBX/xwsv1sc0IWSOT61GA==
=bejF
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============7397694404757092291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7397694404757092291==--
