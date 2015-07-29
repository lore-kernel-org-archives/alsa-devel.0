From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/6] ASoC: Intel: Skylake: Add DSP module
 init and binding routines
Date: Wed, 29 Jul 2015 22:25:44 +0530
Message-ID: <20150729165544.GH29916@localhost>
References: <1437503040-7392-6-git-send-email-vinod.koul@intel.com>
 <20150729123514.GD20130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2380997145202010083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 01804265DA4
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:54:09 +0200 (CEST)
In-Reply-To: <20150729123514.GD20130@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2380997145202010083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 01:35:14PM +0100, Mark Brown wrote:
> On Tue, Jul 21, 2015 at 11:53:59PM +0530, Vinod Koul wrote:
>=20
> > +int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
> > +	*src_module, struct skl_module_cfg *dst_module, bool bind)
> > +{
> > +	dev_dbg(ctx->dev, "%s: src module_id =3D %d  src_instance=3D%d\n",
> > +		__func__, src_module->id.module_id, src_module->id.instance_id);
> > +	dev_dbg(ctx->dev, "%s: dst_module=3D%d dst_instacne=3D%d\n", __func__,
> > +		 dst_module->id.module_id, dst_module->id.instance_id);
> > +
> > +	dev_dbg(ctx->dev, "src_module state =3D %d dst module state =3D %d\n",
> > +		src_module->m_state, dst_module->m_state);
> > +
> > +	if (bind)
> > +		return skl_bind_modules(ctx, src_module, dst_module);
> > +	else
> > +		return skl_unbind_modules(ctx, src_module, dst_module);
> > +}
>=20
> I'm not sure I understand the purpose of this function - why not just
> use the bind and unbind functions directly if they share nothing?
Yes that can be done, this allows us to have common dump and invoking
skl_bind_unbind_modules() with argument rather than calling two APIs.

But yes I did look at the usage and can be removed

Thanks
--=20
~Vinod

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuQWQAAoJEHwUBw8lI4NH7SMQANAsMLM0Pid/P2A4RMiReTok
LNSsBINv2kjooILf88Ij2ghRRaFVVjIfz0IvlnUIvcVFk9W9B3tsCmokEUd5fwrs
ZVNPvjuuBaF6Ss41KqHI3jpL0UF7bPy8Ou9Ohkt1NC9uDqQwy4aWeYM+LKd5T/qR
4fw53NdjTlQIntPWz4QpVrzAAtof+UyJET2oHvPKgZHLABSURgmEdwfMj63O/HcD
iFPXXAcl7Y3QV2MEG3mjHNj6rrekUjyDJCsGtNoIjF55JjJq3OdXy8hzoH3meLaj
HTQbArHtXDGFRue2fZG7i72zwTndu4Sz89AVIJByT+YN/TgP67s2AOU1odX/Wzkv
vHSg0ULpTMJbHEhU0uScGXRqdzIICaVP6s9tgoARVR8PFZaLc0r7upB7eWX9/z9e
VkrtigjBQyTyp/aGsjNiXeicq+9lL8QYGcrGWISN0mTXtlN+OwIlMhTyB422QkqQ
EuWKENgoaZEZhR4pOcDLSpFiDPYv3Q4k9cVYFyxHvg7y4scgHadj6I6ymrIBuWgW
8OI4cOUqRM7ZAn5aOilMVCteKOBRHG+0pBAob9W2QPogUuTL13X8uCq4cZiOYq9W
tlOfuO9VwdChyYEZe/XwkZz4oAOvISlhvLu0UVAwo2yTiKiX9TwflJyHRN7U1HJr
fnlKZ41H7ni1rO6o+VJw
=d7EB
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

--===============2380997145202010083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2380997145202010083==--
