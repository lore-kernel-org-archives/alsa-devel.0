From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Sun, 18 Oct 2015 20:37:39 +0530
Message-ID: <20151018150739.GO27370@localhost>
References: <5620E482.6050507@ti.com> <562100EC.4030701@st.com>
 <20151016141525.GM14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6520315034158498898=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC452619FB
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 17:04:45 +0200 (CEST)
In-Reply-To: <20151016141525.GM14956@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Russell King - ARM Linux =?utf-8?B?4oCO?= <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6520315034158498898==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 03:15:25PM +0100, Mark Brown wrote:
> On Fri, Oct 16, 2015 at 03:51:40PM +0200, Arnaud Pouliquen wrote:
>=20
> > - Does trigger is needed when CPU-DAI is master on bus?
> > Otherwise how to inform HDMI that I2S bus is no more clocked? I'm not
> > sure that mute is sufficient for all hardwares... For instance for my
> > hardware CTS parameter is hardware computed based on I2S L/R clock.
>=20
> I'd expect us to be always calling trigger - is there some debate on
> this?  Obviously since it's called in atomic context it can be difficult
> to use but we should be notifying.

If the question is only on trigger being non atomic, we certainly allow that
now, we can specify that by having dailinks's nonatomic flag as true

--=20
~Vinod

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWI7W7AAoJEHwUBw8lI4NH44MP/3XehhhhuCG2SYq+hL26Xfao
dZLER4wMeJuj7Ov5KJZftU9gcHmwEfXXhp8UZLmkchok4tUeUd0Wx4KayG3Gb7zp
REQ5wgasoz3FPqMdbykJT3iwwZXOjr4D1S0xC4UFHDhyTnAHanmjBEB2OsQoDy5+
w2uVICBRg2+3FGpkHh/nHpWYQ1ymQOETyKDgrALHZUO0WPQUr5evMoxNs8nBGW3u
PoEVc4SPtna9PN+ybfe/jf6xEAOraFVGhsU/xppDhQ8BLmz90emXtzHlkSTIco1U
LyzkW8B79a0/n7yCCOzQn4marg+MbubL4agFCxZACljL4yhPTUcfpmP3WK1iBQCg
9EsKnq+diBHFHlio6xubns39UkJ4o/2zI9/NaPIFd6A6fMGUxHJq41BQrL5/9sXQ
VpJL4Q4rYd4A7NODUpA5wBrZJrUpkPIBkx/57bJDELmJkx8VeS6JCpHHr5zpME/w
5+SWmXQNZeunDDD6Si6EG61CsacXMe4ixT9RjZCyjO17ScYoht6fgg7opDneFBMk
aZ7XQPOjnHOT552wl4v+ji8GYB1aZpzt/X1VEP2/5e207bVrPp6mAwf1KutLynG4
eVwpyQjINfbydGZmHB8Mb/Agq/unJaAvd5T9Slvl9i6OTmGEIOb0Vj8kCJP0MaIJ
dWKH/SYOc4pzmk54aGBY
=jB9m
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--

--===============6520315034158498898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6520315034158498898==--
