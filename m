From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/4] ASoC: kirkwood: change kirkwood-i2s
 to mvebu-pcm-audio and DT doc
Date: Sun, 4 Aug 2013 20:40:53 +0100
Message-ID: <20130804194053.GV9858@sirena.org.uk>
References: <20130731081858.53413597@armhf>
 <20130803134855.GZ23006@n2100.arm.linux.org.uk>
 <20130803182636.012cccb2@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1288912100325973462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CAFDE261A91
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2013 21:40:58 +0200 (CEST)
In-Reply-To: <20130803182636.012cccb2@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============1288912100325973462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="isYHVKADKR45LecX"
Content-Disposition: inline


--isYHVKADKR45LecX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2013 at 06:26:36PM +0200, Jean-Francois Moine wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > >  static struct of_device_id kirkwood_i2s_of_match[] =3D {
> > > -	{ .compatible =3D "marvell,kirkwood-i2s" },
> > > +	{ .compatible =3D "marvell,mvebu-pcm-audio" }, =20

> > You've only just introduced "marvell,kirkwood-i2s" in the previous patc=
h.
> > Why introduce something and then immediately change its name?  This mak=
es
> > no sense what so ever.

> 2 patches for 2 different purposes. The first one just adds the DT
> support. It is enough for DT based kernels. But some people wanted the
> device name to be changed to 'mvebu'. So, the second patch.

There is no need for the DT name to be connected to the Linux internal
platform device name, just use the final name to start with.

--isYHVKADKR45LecX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/q5CAAoJELSic+t+oim92rYP/A9m6JvaQfFjiPOE8C/mZLxv
yIu9Nzg8IEs2+HLgSVYYEQtf3Z/wBHyk69UGuWfWYLmJ9lGaDznQ6SKgPk4sq3zY
BixiFv2U1Gt1A6kwSJ3SyhHU+kpEwIqCWQtfw25Q7jKzaoFrB71yfYNU2lN2htEl
8xd+pWSPu9xqQSg24fgq9mRyqA8+CTc2PJUSz+/99FdOL3cFgGLR41v9ZUxmZGmC
Fw//SxrIetx3R/iKHpCK6lxeDoqYyS4NvOWI+Hn2xHMvDLC/19R+PQfULlU6gb4X
bJBU1vXkXjXtrBEdNPLy42SoGl5glLIzzAG34bUu9M1g4LcMKHqp2FLgXlnw6gyM
EsU+6iQGtpBa46McVOyCuVwEFbb6zF8xsHnPGTe0R0VyhU2mValfMLz1Ab515rOg
SDnQiLwOvuBh64IWofsyiyVhA/iJ4mU1iFGW7YO3bGznMC8w+2TBAYyXchF7U52W
x/3AL9BmcJvrC1OUDo88HLu2GRHhiBIb2aF9V3rJTxyJVNVo+Uh8bL0KUep5zdrh
mLLKqP6ji3CSh6IlnboEeze8jFxZNNBcvXRkO1lE8DOBkrzpZJ6M3tNcgNtRGFBg
iox2x698YVD75q3BB0HStBoqJD9nb/5xpnOxfLbsYq5GVbP1a7ho50fsWyLjgjiA
JCrt3nM8ieAkNv4l1c99
=NnIB
-----END PGP SIGNATURE-----

--isYHVKADKR45LecX--

--===============1288912100325973462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1288912100325973462==--
