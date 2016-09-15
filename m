From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Create dynamic
 instance ids for DSP modules
Date: Thu, 15 Sep 2016 10:01:50 +0530
Message-ID: <20160915043148.GS13920@localhost>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
 <1472042001-9582-6-git-send-email-vinod.koul@intel.com>
 <20160914164312.GC27974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4055404814402052035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF9F266653
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 06:23:31 +0200 (CEST)
In-Reply-To: <20160914164312.GC27974@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4055404814402052035==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 05:43:12PM +0100, Mark Brown wrote:
> On Wed, Aug 24, 2016 at 06:03:17PM +0530, Vinod Koul wrote:
>=20
> > +	if (!(mask_val =3D=3D 0xffffffff)) {
>=20
> Why is this not a !=3D comparison?

Yeah that's right and simpler, will update

--=20
~Vinod

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2iQ0AAoJEHwUBw8lI4NHxl0P/iqtRjVmPPw4rCLcYMQERLan
PfQrPlEx46ciYNFK+9yIZ6nDKB9RkpTaWRw9ZMhLfknaivOjdiie/j72TmI/Q7ah
08b/GlWboYtRO4CELlNL++ydUhqN6EJkoIAiYc7Hf/rAnLy32bUER/VxVkYC9hB+
hEVYA9p68v79AsnmFKCT7TWZPtnb4AblKtFTbYY3FrLpp3vG1NdcQcWkXWRCmc7A
6wyxHKBltud/zcxQB1B8H8XLqRYDTCq6M6mUbCSNpCeVouzmzmeCALyI2vv2E6Zu
Gk36ZYAp/LjMx+V+JcZkutYHomMem1aqbradokqdnbzkvnTghqSvtL2XLGHR+MYO
5PgFCpxIVpIPJu0+XVRCClMeBcUudVaCvwN696o0sJeVU+hQ07PE+yFk3nhbl5Cx
2S6qWRXM+8CYkI1GNeAm1fnwmVudwdDN/Iz7I+8+8fXDI4JBQe6yswl7X443Y9oK
gM/H7iBcPqIoS9ZB66NJ+VNW9THdE8sI7ae124LCBEvxQVx6mzlHpItAjATH6nD3
YYST5L6ls+6ZkhLNHEq5FgCjtAb4PnpguvhqR6gN/lnP41dyshyTnHpsB6Tj9gOb
mkcYLFCRuetgX8LfVoVAbcJGST23z7ertnvQfJwxJjfWQncZVPXI1zAYja+tSTHj
Azq8MfLwl6HYxSccuPsO
=4Z4C
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============4055404814402052035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4055404814402052035==--
