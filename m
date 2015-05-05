From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx: Add zx296702 SPDIF support
Date: Tue, 5 May 2015 23:07:17 +0100
Message-ID: <20150505220717.GI15510@sirena.org.uk>
References: <1430366850-10281-1-git-send-email-jun.nie@linaro.org>
 <1430366850-10281-2-git-send-email-jun.nie@linaro.org>
 <20150501105503.GT22845@sirena.org.uk>
 <CABymUCNcD_7fxCh110A-w5=3Lo5Jn2aCHGy3DwLDroZP9oqi4w@mail.gmail.com>
 <20150504135416.GZ15510@sirena.org.uk>
 <CABymUCNYZ=ik9Z6zfOXzFN6GyfQ+Z98EArPuG-s1e2S01rvU-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3383085278784984747=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 015212604A3
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:07:31 +0200 (CEST)
In-Reply-To: <CABymUCNYZ=ik9Z6zfOXzFN6GyfQ+Z98EArPuG-s1e2S01rvU-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3383085278784984747==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VxEiC3f0k/7mWchE"
Content-Disposition: inline


--VxEiC3f0k/7mWchE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 09:43:56AM +0800, Jun Nie wrote:
> 2015-05-04 21:54 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > So this special HDMI S/PDIF controller is directly integrated with the
> > HDMI IP in the SoC and not usable as a generic S/PDIF controller?  That
> > seems to mirror system designs which have an external HDMI encoder which
> > use S/PDIF or I2S to connect the audio portion to an external device.

> The first SPDIF controller on ZTE SOC is dedicated for HDMI and the
> 2nd one is for external output only via physical pad. The two
> controller IPs are identical, also independent with each other and
> HDMI in register address region.

OK, so this does sound like the software should like one of the systems
with an external HDMI encoder and the HDMI handled separately rather
than in this driver anyway.

> > I'd suggest for future versions reorganizing things so that you add the
> > S/PDIF driver with only S/PDIF support and then have a separate patch
> > that layers on the HDMI support.

> Reasonable suggestion. Then I can have more time to think about HDMI
> part. More comments is welcome if any.

This sounds like the software should look like a TDA998x (which is
having patches posted still) so just have the S/PDIF controllers as pure
S/PDIF controllers and then a separate driver for the HDMI part that
it's hooked up to which deals with the audio configuration for the HDMI
side.

--VxEiC3f0k/7mWchE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVST8SAAoJELSic+t+oim9pv0QAJIM+veJVfavK/TOh5Rwh9Wh
t91JVrNi720MypIR+WL2ch01+ICMfbdRmZ8RA1GrBZUfqR3AAcakg5XSU6O8cw4U
scKXg4Cyx4I7TrXK0dgPSuOZyOo1oo92rACgQR4fZ6IfK4RrZrqfnQlLOTIJ4GAi
9tlV9L7iBYKNmDlB3k3SVHrrOn36kQOA6KN08RZs+9GbzcTke/Jxa7eoWcn/CGty
mOkh65k6Gza4JGliVhDp44p1Rmu3cyUG5pc6p6lW82ABjB4wA3TDZcRcT/bsNQDi
Hp+HhgQeaZyM3AYki+MFa4g9+UJtlM2WktXFXCK4q5mX42c1u8PfMnjLFutDTxJf
B/HJQna+bG89gmyH6LjHXpHJAuXjRB8Z7OQ39TTxUuax39psxonnytTrDH98Hk2u
2Kqoe+O6G8OHC9lFWOjIZHLl49klQFDq3Kj9aF2rLmTrXll2ObRgAuLlWwuy48RJ
XlchVQ37SRjBOwUxVtNcAI+yQSm3u0SzyjdR6HGBlNrJ6BkXcI1SojXeu+3m7fao
sgSWOYjpIioaMIGTX6ugbSwuMiLoGe/U+tKVT2dGCK6OHil+e3oKqMbEPa6kg7bi
RAr6Lvmr+Iht6NnDLlGtzqOHn0uNOkL6Oprgl2ucedJbV+3pzrj20XW21VMC8VUo
aUOx703L1vwPdVNz/OlV
=K+0n
-----END PGP SIGNATURE-----

--VxEiC3f0k/7mWchE--

--===============3383085278784984747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3383085278784984747==--
