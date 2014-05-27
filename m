From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v4 08/17] ASoC: fsl-ssi: introduce SoC
	specific data
Date: Tue, 27 May 2014 08:21:24 +0200
Message-ID: <20140527062124.GB20989@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
 <20140520220213.GZ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5397585988436325469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 549462654C8
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 08:21:48 +0200 (CEST)
In-Reply-To: <20140520220213.GZ12304@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5397585988436325469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 20, 2014 at 11:02:13PM +0100, Mark Brown wrote:
> On Mon, Apr 28, 2014 at 12:54:49PM +0200, Markus Pargmann wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > Introduce a SoC data struct which contains the differences between
> > the different SoCs this driver supports. This makes it easy to support
> > more differences without having to introduce a new switch/case each
> > time.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
>=20
> Applied everything before this patch, thanks.  I've not applied this one
> since you didn't sign it off - please make sure when forwarding patches
> for other people that you add your signoff at the bottom, this is needed
> for legal reasons (see SubmittingPatches).

Ok, thanks, I will resubmit the remaining patches.

Best Regards,

Markus



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJThC7kAAoJEEpcgKtcEGQQ+MYP+QGVHSudxlZR/3EUYfRtiltv
KdDICUkwhRAEiGZOvHeQWQz4SU/n1axgw2Fjzv25EEM9c/cmxNDSA1JEIZV1gwE/
dwayxMT24zT9e4O3OoOGvszIb98bzbZRmwR346SDiXt7fWq5MMEekHnsvz1/VXir
YARJiWDm8K2T92fzDwRVwg/jiaMJBmgMsELqePZKoDuAr9X4MQmCsDCSPjloFUtk
PBfSDY8DKK+zbT+rC9bALe50p8gRqf9Ej4a9e+0ON7yoFDmoq6a5LG56M9kiI1/F
/5OvU1Y5C4dhX/lGYGX6MPqF0VKU8pqTLPumW94fSvOeufoSDnjvDE+dSSB2XcXx
UfpvebfEQ83ZO2fuSrlr7GIxBJqvLnhmQxHEK647sSyQsy/m4DLDKZoKe842t2Zt
hosYqdwFOtwP/k1TEpXz2ochss2q6Dhb6lZrNF0j8/xVHKqSSY9+XUwhOO0oQyPe
mNIvGoUC4FptS2AWmZZmxh+8QZ149BjCjBXEoNYTZGoGccrLQsMMVx2qQ0v9kfzg
G4jS9x5P5de679p/O+UEtcrhw2RT+wzahnw1Wz9sK4E3GSWUeU5vOoShC+oGhoG1
yyMIRTplyPu/4v+cJQQNO09qbPmc/rQAxs/vzRvNZTy0oTssjg3P8EJnz4SpqDXf
4sdKNWwcWZVRMEhJJPa9
=EyXE
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

--===============5397585988436325469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5397585988436325469==--
