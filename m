From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Fri, 2 Oct 2015 17:59:07 +0100
Message-ID: <20151002165907.GU12635@sirena.org.uk>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3285554964063925095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D7D260668
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 18:59:15 +0200 (CEST)
In-Reply-To: <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, vinod.koul@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3285554964063925095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzbqGaOtRNiVr7w4"
Content-Disposition: inline


--pzbqGaOtRNiVr7w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 05:31:34PM +0800, mengdong.lin@intel.com wrote:
> From: Vedang Patel <vedang.patel@intel.com>
>=20
> For codec-codec links, this struct will be mapped to the DAI links's
> params, which is struct snd_soc_pcm_stream and it needs a stream name.

OK, so this means that every DAI link name is going to become an ABI
too if there's a topology in there.  Not a problem but we'll need to
watch out for that on review...  I wonder if I can make some automated
checker thing.

--pzbqGaOtRNiVr7w4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDrfaAAoJECTWi3JdVIfQVvMH/ilXoO00NcAVgVHI8G3M8Rjz
HlMcr6oEJ3s/KkC8s9O4IMnr3SGRoPtFJFReaNBgnTRuf9q8d9SUBAvepI6nJKNo
iTulOzBZwG7p2e6IoN4k58NDDas8XVrR9LNpVB0mtwKdM1MdgneLEQV9BotsXIne
btb9vGK1GeQuU/dob2fD+MJF1em2COPC5E7qQTmrPO3+m+DM6OBQ2Tb8WaUMm2Rm
54HnUlkRwTmPpEmLwkmS4vBuYJFJ1LCp7eSVX05OkS88YY2DtawUdC2zz+xtSq9L
yTmBC/m/Hv2EKcY4Qqj2zx7B4KgZazd+wlGMdGhD0NVvtGiLIfSj0EBJHAQqPnc=
=r/w8
-----END PGP SIGNATURE-----

--pzbqGaOtRNiVr7w4--

--===============3285554964063925095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3285554964063925095==--
