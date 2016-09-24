From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: topology: Able to create BE
 DAIs
Date: Sat, 24 Sep 2016 19:56:06 +0100
Message-ID: <20160924185606.ihvmwpqtn33mgozw@sirena.org.uk>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
 <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
 <20160916145651.GD27974@sirena.org.uk>
 <17DC8B7179E3514D90E3A456B23B91EA1A0B0F50@BGSMSX104.gar.corp.intel.com>
 <57E21E2B.8020502@linux.intel.com> <1474441795.15879.6.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2883949028296783094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA382665B0
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 08:05:16 +0200 (CEST)
In-Reply-To: <1474441795.15879.6.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mengdong Lin <mengdong.lin@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2883949028296783094==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keqyxqkvry6awbm2"
Content-Disposition: inline


--keqyxqkvry6awbm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:09:55AM +0100, Liam Girdwood wrote:
> On Wed, 2016-09-21 at 13:44 +0800, Mengdong Lin wrote:

> > And how about the BE DAI links?
> > They are also physical hardware things. Could we also let topology=20
> > configure those that can be changed by SW on the BE link, instead of=20
> > letting topology create the BE links?

> Yes, the topology should be able to configure the physical link SW
> params as the link may be used for multiple use cases on multiple
> different devices with the same FW binary. Each use case or device will
> possibly require a different BE DAi link configuration.

Configuration is fine, it's just attempting to say that physical links
are instantiated by the DSP firmware that's the problem.  That's just so
obviously an invitation to fragility and abuse.

--keqyxqkvry6awbm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5sxFAAoJECTWi3JdVIfQEoQH/1OSRJC2PCuebbzUrw8OT/ya
mQsb6xI9kLHnqvk/8qT7weHqx3cjZLdUHAI7RhHBxonAnYy8VzERi7nWI6GG9Re8
r2u9Vrj7eWusBFQwNu7nQ7oX7RdST6WsWTuZtPIQ1EJqkdiFvVdN4i049N3zbNls
vmhBgOV/5KoWcLT+iCB2HR4WS0ku6BVStMdRM4JvWcqKmipipfl4Yr96vUp7Rfu6
ikbgrTYR08LCnIKt5iCj+QvHGI70+/mgGzXO7WYQu7kgIQqpwBfY8LGdhypz6LTi
7gicH5dh5PaElrBsjVfkqrr/iPL+uNHn4Zx8t2d1AuMJUlSLJIHMpTOb/8m4UYU=
=SxFk
-----END PGP SIGNATURE-----

--keqyxqkvry6awbm2--

--===============2883949028296783094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2883949028296783094==--
