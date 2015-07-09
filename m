From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/6] ASoC: Intel: fix kconfig,
	symbols and sparse
Date: Thu, 9 Jul 2015 10:10:22 +0530
Message-ID: <20150709044022.GH836@localhost>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
 <20150708182423.GW11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6992989139434972313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D9134265AF8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:38:37 +0200 (CEST)
In-Reply-To: <20150708182423.GW11162@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6992989139434972313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:24:23PM +0100, Mark Brown wrote:
> On Fri, Jun 19, 2015 at 11:55:25PM +0530, Vinod Koul wrote:
>=20
> > Vinod Koul (6):
> >   ASoC: Intel: use CONFIG_SND_SOC for intel boards
> >   ASoC: Intel: kconfig - Move DW_DMAC_CORE dependency to machines
> >   ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
> >   ASOC: intel - hsw: fix sparse unused varible warn
> >   ASoC: intel - atom: statify sst_slot_enum_info
> >   ASoC: Intel -atom: fix sst_platform_compr_ops declaration
>=20
> Please try to use commit message styles that are consistent with that
> for the subsystem, these aren't even consistent within the series :(
Sorry about that, will repost with these fixed

--=20
~Vinod

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfs2AAoJEHwUBw8lI4NHIXgQAM30rZskG3BP9o7+U9Vc5oYe
6+BeeH0ND24AHOVuLxtstySRBQrUMYGxKtAez9Ei9B1pzF04dH6cNzwBVOxebc1Q
rE+IZZBd7EaaF4p+RZNhZQ4dnoC1MQrS2YynV0CfIvr4Mojqpa4L3ScRGQ7GQNQ7
Hk+t1uO/Gov7K6OKomSdDntCTJs6ihZD86oGoaq3EjTDXGfQvZWJj+PfDUmSZU70
VZNHjhtqLzcfDMzx5WSYBEmf6AuuM+mJZxfowoeJNNawnrMw4/MyM9QtHIkKQehK
Hc67E8qwn0Izw4v+sFhDlROVoe62+HawWG9+v4mXW8IBHlZCb1OPitsL8+VuGqyS
KMUaXVQlkm0c0CR1vaMuTLpmux4JzJXNlHvbiMnpWGNCU1iIwCARyaU7lpqPFVIq
MBxnHqlztmfU9aUY37RenDvdXrrJTxQC+A9/m1uNLWq6ucDDpKqINFJ+7OO/DfYO
+fTnZttKv+U3i7VZ3CQRRt/fOupLjqADMqYh0RYPvLQ3XGSeiMCmPwEciVFNYVZE
KUd8aD1deOVH/HRpcohdUlhuKBSoTK/z3la0qxaGpDQgOEJlLgq2IcJIIjAgvjSa
IAYtcmkf+9jBUW5h1CpzClrVemlm52Apl9qmAYLr29YKsqfzviOfbB0Aat9Juimv
efbVNWLC8NiO63cRdl4Z
=n5Ti
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

--===============6992989139434972313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6992989139434972313==--
