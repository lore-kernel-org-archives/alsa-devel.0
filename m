From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/9] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Mon, 21 Sep 2015 08:56:10 +0530
Message-ID: <20150921032610.GE2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-7-git-send-email-vinod.koul@intel.com>
 <1442570334.7634.39.camel@loki>
 <20150919162620.GF30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4417618178096821147=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D00260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:23:46 +0200 (CEST)
In-Reply-To: <20150919162620.GF30445@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4417618178096821147==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:26:20AM -0700, Mark Brown wrote:
> On Fri, Sep 18, 2015 at 10:58:54AM +0100, Liam Girdwood wrote:
> > On Mon, 2015-08-17 at 22:56 +0530, Vinod Koul wrote:
>=20
> > > +				struct snd_soc_dai *dai)
> > > +{
> > > +	struct skl_pipe_params p_params =3D {0};
> > > +
> > > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
>=20
> > Seeing a lot of dev_dbg(__func__) in this series that really are just
> > tracing. Probably best to trace the calls properly or remove if it's
> > just development debugging.
>=20
> It's all through the whole Intel DSP codebase.  :(

Yes the code is getting features added so we thought of keeping this for a
while, but I agree this doesn't help much, we are adding tracing anyway so
lets add that. Will remove most of these...

Thanks
--=20
~Vinod

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/3jSAAoJEHwUBw8lI4NHoLwQANVAw8BjbL9CK8V9lGFhPTRJ
pgbEBG00wac989kG3Y076pLrCjWW2wlma/UWbDXdhr4t7Dte2MvIZk5tdEE9Z2V5
mi+xwsoBy7Fqs3MYYYtmhX1GWwfPebXLGLNCQ6QlH8lyo6DF5hRyrzkjiV1FhzsA
oHDW0pzREmsTxmzcTuWwVR/a0jBnJFn454xwe0RlmkE0XZo2+PJMy5zkhj69ibxL
s0U71gUe34QyyuQNOHnN9+Mt+9GrNrtrj9Mcwcdj6Rpsw4//Bg0kyFfoE86mNmfc
TEdmvBVjPhVZlh0VvmkihJIiiFcT7MhjwT8H49vC+mEKueH1wpGGE1mgqt3rlYO+
S7fiQ5Pg0y2Esx5qDnJ/xKjg0qAIESaGGmd9XvNd1XhcmbJEMTnziJVel3jD1ZBR
s4wJEZzajL3//C1DKqsP0abzdWgDkvN6FSze38mPx0xcUy2WHVx9Im628vYlnlOw
QALMP9t/kJmlVqihVVc++Brx5U8BdPi583sshP8Lez0mKg2LP6zXh73wd4yHSbJ4
f2GXqd4gMe9aWWrJslXssKzNclGU8z9dwIDx1O/GlodZqwR/NbFSSAgZXreZRTC3
Fo/V15H++0Ty604zPtNa7jW+7/bRe6klEelASUl3XAIgh4AwwVL6aZWPBMU7n7hM
lbI8d3YZPMQv1TSrdVWL
=bh5B
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

--===============4417618178096821147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4417618178096821147==--
