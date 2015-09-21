From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/9] ASoC: Intel: Skylake: Add pipe and
 modules handlers
Date: Mon, 21 Sep 2015 09:36:05 -0700
Message-ID: <20150921163605.GV30445@sirena.org.uk>
References: <1439832404-12424-2-git-send-email-vinod.koul@intel.com>
 <20150919160023.GC30445@sirena.org.uk>
 <20150921033713.GF2381@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7109290840101031845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C54DA261519
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 18:36:36 +0200 (CEST)
In-Reply-To: <20150921033713.GF2381@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7109290840101031845==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nKvJs6ze6az+4fwY"
Content-Disposition: inline


--nKvJs6ze6az+4fwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 09:07:13AM +0530, Vinod Koul wrote:
> On Sat, Sep 19, 2015 at 09:00:23AM -0700, Mark Brown wrote:
> > On Mon, Aug 17, 2015 at 10:56:36PM +0530, Vinod Koul wrote:

> > > +	if (skl->resource.mem + mconfig->pipe->memory_pages > skl->resource=
=2Emax_mem) {
> > > +		dev_err(ctx->dev, "exceeds ppl memory available=3D%d > mem=3D%d\n",
> > > +				skl->resource.max_mem, skl->resource.mem);
> > > +		return false;
> > > +	}

> > I'm not sure how the user is going to be able to tell what exceeded the
> > maximum memory here. =20

> Module Id and Instance Id are printed before this but yes that is debug, =
so
> merging the two to error alone makes sense, will do that here

They're printed at debug level so might not appear but this is an error
message.

--nKvJs6ze6az+4fwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWADH0AAoJECTWi3JdVIfQcJ8H/0g16n/l5Glgri5kmOuOPu6F
r1IDcMfQY69Sbr4C0CuIqdOEu3Uecd9Cqe1dYSr+xWnXrmnRp+n/qWv4YjWO87pE
u6vMhm1DuVj4ntSM9dLwP685pX7pCQZur00da3QanQElAxCXsTMUZO0XXLcPorvf
8OE2PfAG+kgZdwUeQNFiQHUoO1yzBPMR59lUpYbdrkY5TnexapIDfn+VP9p/LBIe
lRSCb7MJqArzFL1ixR0sv0IEh/CBHEfDB18ag/M7auV4Yp80oIuEX448nyKd2oTJ
+SKzXiMMsbAYm/v29qk9WP28/flaEsHYdqSEOc3HwjtSA6bh1DjXxlh2S+MWvvU=
=7Xt1
-----END PGP SIGNATURE-----

--nKvJs6ze6az+4fwY--

--===============7109290840101031845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7109290840101031845==--
