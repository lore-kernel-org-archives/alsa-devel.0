From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 11/13] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Fri, 25 Jul 2014 11:16:46 +0530
Message-ID: <20140725054646.GE8181@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
 <20140718121920.GO17528@sirena.org.uk>
 <20140718142623.GH1985@intel.com> <20140724061803.GD8181@intel.com>
 <20140724115040.GI17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4380066533374059424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AAF02602F3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 07:53:03 +0200 (CEST)
In-Reply-To: <20140724115040.GI17528@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4380066533374059424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2014 at 12:50:40PM +0100, Mark Brown wrote:
> On Thu, Jul 24, 2014 at 11:48:03AM +0530, Vinod Koul wrote:
> > On Fri, Jul 18, 2014 at 07:56:23PM +0530, Vinod Koul wrote:
>=20
> > Wanted to check if there is anything else required to be done for thsi
> > series, if not can you pls merge the ones before this in series, if oka=
y.
>=20
> It's been less than a week...  I've not really looked at anything else
> beyond the export (which I'm still not convinced about).  Patch 2 was
> very surprising, it looked like it ought to have some dependency on the
> rest of the series.
Patch 2 just adds the DAIs the ops are added later, so this can get applied.

We discussed that with Lar's as well. yes the approach will be modfied a bit
more based on his feedback and we are done with that. if you wnat we will
send updated series completely for you to review :)

--=20
~Vinod

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJT0e9GAAoJEHwUBw8lI4NHHagP/A0jn/FxFWPrOMJEWaWFQtWY
G0Jwr5jmoCmmNY14mtIW+tQgN8h8qRT5FvGHrsyVHG5ELu5fNMfg+RkeEhxx89KO
b+2oa3LonaI+Ga5PaNmbE5CHW6SaW6/fB1VyZUCnMTSUK4tJLiM2ysC6UYZhjKTA
sjL+515o2HfFNNZ+PNq5yoZcc6d+I+xsVRkMWXRp648NLUgJjkdhZxl/omd6KWb3
IVGN7Rm3m+A//RrfWjN6f4rs/aAo85Tw0L3nhkXLKVO363m09yDTmoIbPRG553pQ
dR95MeyVJy4oWTC+/SmvjtVMe1Ox3paECUrspZmDKKEy++qjaODwzByF5vxRr//q
XB9sC7tMnKdE3+iA5sFXsAqzDFTwnFfxcjzth7L/d85fnrablaJzcRvNxSTO91pU
I2yJFpdf2DPe2zvKr1DUqXPU7ISjdIjhoe0y5f6dVp/ik147HJw0C9tCxb4m/OiF
2q42XT1We7cBns/qEvdzas/pcC6QtXFqI+hdpJtPSV59t/ZbHLjLI5JZRFdLQ1d+
9BW65girfIPRXAN5Z4Eb3kX1qAwRih2X9j/lihtl4m93q9dbdrNbRKBXQs76MGXf
GtqOcmZwlLPRSe1zwSBOVC0IrukuI2bEfcl4ZHIiNURTqgtTmep2sDoixCieGm+F
3qmPZ8jCh2/TOSihhm0M
=1OKf
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

--===============4380066533374059424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4380066533374059424==--
