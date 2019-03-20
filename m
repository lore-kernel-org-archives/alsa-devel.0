From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: tlv320aic32x4: Propery Set
	Processing Blocks
Date: Wed, 20 Mar 2019 16:26:37 +0000
Message-ID: <20190320162637.GA27518@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-13-nh6z@nh6z.net>
 <20190319153758.GJ5514@sirena.org.uk>
 <D82403D3-0C43-43A4-8594-BAF08D9C2554@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0934320035647444791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0518DF80791
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 17:26:39 +0100 (CET)
In-Reply-To: <D82403D3-0C43-43A4-8594-BAF08D9C2554@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============0934320035647444791==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 09:24:00AM -0700, Annaliese McDermond wrote:

> It=E2=80=99s not really a bug fix.  The codec has a variety of =E2=80=9Cp=
rocessing blocks=E2=80=9D
> that enable different filters (there=E2=80=99s an onboard FIR, Biquad, et=
c.) and
> such.  The big thing they change with regard to how the driver is written
> now is that they change the decimation filter used.  The documentation
> specifies to use certain filters for certain sample rates.  This
> hasn=E2=80=99t mattered very much in the past because the default filters
> (P1 and R1) are the ones recommended for 48kHz and below.  This is
> particularly important for 192kHz operation because it won=E2=80=99t
> work with P1 and R1.  So, it=E2=80=99s not really a bug fix.  It=E2=80=99=
s part
> of the road to enabling 192kHz operation.

It does sound like a bug fix for higher sample rates (96kHz is
supported?) even if it's a fairly niche case.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlySaboACgkQJNaLcl1U
h9BpWQf9Gog7eKqCPLVIkECQP8MgQbXr4ef2CvvLHuCnUERjV/Uhh2DbedaY70Xd
sUabz9HBdxEf0TzFpX/48LWaX3KMaftZDd5wtlHg727UmERTRchbag1LtbgU5POb
NoVVo9cfHH7BGsFcz+kcqB/Bv74EpbJYyq6cKMZdZXIFCSJV4Iaf35ffMpuQuzZl
V9Qfu27JL1XMgNt9GaMFDy/gWexbc/BsZAv5LjWj3xgnFFO4RqdKh+uOdT8DEUZl
G4htKFzVlEoZ/tkkVBrSvcXPAvAYu7uhUjXlZujNLm1K14GIbeWiqf/5bOC9u4tV
ReoyjEDKW26DZf6PghLt/+/1QW6zZw==
=Oksz
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============0934320035647444791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0934320035647444791==--
