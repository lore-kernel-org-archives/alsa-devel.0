From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Mon, 21 Sep 2015 08:43:05 +0530
Message-ID: <20150921031305.GC2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-5-git-send-email-vinod.koul@intel.com>
 <20150919162210.GE30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0100420893396162828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DCE9260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:10:26 +0200 (CEST)
In-Reply-To: <20150919162210.GE30445@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0100420893396162828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:22:10AM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 10:56:39PM +0530, Vinod Koul wrote:
>=20
> > +/* Run/Stop the FE pipeline */
> > +int skl_tplg_set_fe_pipeline_state(struct snd_soc_dai *dai, bool start,
> > +								int stream)
> > +{
> > +	struct skl *skl =3D get_skl_ctx(dai->dev);
> > +	struct skl_sst *ctx =3D skl->skl_sst;
> > +	struct skl_module_cfg *mconfig =3D NULL;
> > +
> > +	dev_dbg(dai->dev, "%s: enter, dai-name=3D%s dir=3D%d\n", __func__, da=
i->name, stream);
> > +
> > +	mconfig =3D skl_tplg_fe_get_cpr_module(dai, stream);
> > +	if (mconfig !=3D NULL) {
> > +		if (start)
> > +			return skl_run_pipe(ctx, mconfig->pipe);
> > +		else
> > +			return skl_stop_pipe(ctx, mconfig->pipe);
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Another one of these wrappers with basically no shared code :( =20
Yes this is wrapper over pipeline start and stop. This function is invoked
=66rom the PCM trigger code so we though providing a wrapper makes it look
better. I will remove this and invoke skl_run_pipe and skl_stop_pipe from
PCM trigger now

Will check if we can remove other wrappers as well

Thanks
--=20
~Vinod

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/3XBAAoJEHwUBw8lI4NHzk8P/jmH1pn12FHRAP3gBH5Z1tAK
e+wPgaK8EpjlHDQXQ0HAuH8jSJHU/tgJK7avDrO4Kb+mPKxgNxBuXAeZk14XBPR4
nN4mY8mqGvpI28BGKG1580AWIy6Z7LfsXI4qUH+5G94cAZe2g7tTs9ip62Ot7EWU
L25iJE88MCTEp4GADbDdDA9nqnl/vqA0LNWXER+r4FpJ/Rvs0RchBNhkeg1Fh454
4gHGxhhrrOVE1Bkqz4V/cgQSEYuijRneLqJVvysafCY++wcd/EJV9vLVOWhOOE6V
c5bm1RfCCQal4d7B42wgzulrLkMv7Ib3miFxL5iifMEzohkyCHhaF9j3Ghx2A25L
Wi2nbJML3gKLZyaX3+59jkhTakTaI5CU32uJKrQ7THcExIkhKyDIxy0YvczMDl0y
GZGQSliUSC/x/E0D65E5ajfzHgCXJgdHgZAgeBNoxLiP5PH6WyPqxsU2xZEOlXmI
6lIxBIOa7d6vhXoQXRv3wzI1wC9KnQgPWDceQ8gJ7NnrkW6Af0xL+rjJhYi1j/vL
C4AZ8qevsvi5lToWwtAv4xcZm3pEYAyrVrOs6oi/TCsJfLeO1iclngIqnepDT4fW
1rpsTAsKmb4yG8FXIWuGwq24ZnohPROV8K3mon8BGBwZz7ef/vaUtS6cUZ1QMf9x
KB1ZVsBq04n9Ebmq3k4B
=aXHr
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============0100420893396162828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0100420893396162828==--
