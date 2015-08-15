From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Sat, 15 Aug 2015 22:51:32 +0530
Message-ID: <20150815172132.GK13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-6-git-send-email-subhransu.s.prusty@intel.com>
 <20150814220313.GW10748@sirena.org.uk>
 <20150815141658.GF13546@localhost>
 <20150815170058.GK10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6818177731482233313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 366F32654BD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 19:19:32 +0200 (CEST)
In-Reply-To: <20150815170058.GK10748@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6818177731482233313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 10:00:58AM -0700, Mark Brown wrote:
> On Sat, Aug 15, 2015 at 07:46:58PM +0530, Vinod Koul wrote:
> > On Fri, Aug 14, 2015 at 11:03:13PM +0100, Mark Brown wrote:
>=20
> > > > +	/* Index is for each config load */
> > > > +	ret =3D snd_soc_tplg_component_load(&platform->component, &skl_tp=
lg_ops, fw, 0);
>=20
> > > Which index?
>=20
> > The last arg of snd_soc_tplg_component_load() is id which is set as
> > tplg.req_index =3D id;
>=20
> > So the comment tries to explain how last 0 index is added. We have only=
 one
> > load so we will be always 0 index
>=20
> Your comment isn't explaining that at all, sorry - it's making things
> less clear.  It's peering into the implementation to translate ID to
> index and even with s/id/index/ it's begging the question "ID/index is
> what for each component load?".  If you're adding a comment here I'd
> expect to see something like "Use the same ID each time because..."
> which explains something that isn't in the code.

Fair point, will add this detail now

--=20
~Vinod

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz3UcAAoJEHwUBw8lI4NHPeYQAIFtGWbgmcUpr3ElzhGOo1pe
BI1WIhQGEv+gLDgu8eMpAcqRDUhngJJ0mes8hVZNpAdsXPtH3TzsNbc15qPWyHIP
MNGXozE0s+nnNII4GE6yFoFdR6SduItesKJ5wR417GrXkw97jkIscVCrEIqxT29p
1zW+ixuJgPk5DVUEESjAb+rv07UCA02OI8VuX2O2q4Tbsy/QboaRMCGnSNDy6NRH
qokj6tWwGAwJa20dswlyeGS/5S6ViAulblcNjth4ZG/hyw8c/NKHUZYEj+ejMenD
kHFd0xla+j0n1it/2nwjRYxn8z2Z7czWacXMQBKTSYOK55/ciixRmSKdy8qCGUKw
6A3n865x/VSq+pixUpdAsANPrvC3nV8VsVc7+MgcSI4WBCguGtjXNBMRX1+GUttC
3EGZFJWnpKmQVDmpAoQZdS250g8Bu7WQNz73ef+O2KnM0/h3cPWrBHheZBUdyAc4
HlRnSgc9vZsALp6Ip8A7tWotIy/E1ohbMKlTbJqjLRbdZRxzLIotrHWkSck1tLjg
cd+RVjtQHfulkfcI44jgj9lzIGZYmsOAVe+HUgLWR8HsGxstZWCh+uuDShixSJIJ
BtEiN7jpnmPaQ13gxmEWePhxuie2+fIdpL9Uy/w9KbGhMW58Ru54XEnj1xo/zo7y
DohcYXVgfvH8/nIhaNOC
=BWYo
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

--===============6818177731482233313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6818177731482233313==--
