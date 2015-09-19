From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/9] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Sat, 19 Sep 2015 09:26:20 -0700
Message-ID: <20150919162620.GF30445@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-7-git-send-email-vinod.koul@intel.com>
 <1442570334.7634.39.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2584471279109546431=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE3FA265FCF
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:32:49 +0200 (CEST)
In-Reply-To: <1442570334.7634.39.camel@loki>
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
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2584471279109546431==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2015 at 10:58:54AM +0100, Liam Girdwood wrote:
> On Mon, 2015-08-17 at 22:56 +0530, Vinod Koul wrote:

> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct skl_pipe_params p_params = {0};
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);

> Seeing a lot of dev_dbg(__func__) in this series that really are just
> tracing. Probably best to trace the calls properly or remove if it's
> just development debugging.

It's all through the whole Intel DSP codebase.  :(

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YyrAAoJECTWi3JdVIfQLfoH/25Lsaxw1ooZCYz9zhrBxqX8
iYpqcRUvNxHQuqWUf48QMy9OJUpoqFARHdAT3/ZUsYsW+MF18LfMC7jE2hWEcXTp
jx7FhlxvvHpgxaYZdwVvkDZXozFsRZBQz+oeScBdFo4hJ15OS7lrKjJdDAKO77rU
6xX9mmQYDJgB9O49otGyfsuxiAnSjJr91WUewNSxJabMbxOAI7ngroHNY+7SGA9v
himwDLi7NYXiNEFwlTZPZpQXixCApOsl01USvJyDspCtmzdy8HWo41DVzX+dX4cd
j56zI/Xv9YOlaSANdIcNJ1wPDTQf3h4UUq3NxHxVPsqjmd3rqyxpYyEbdTPuWp4=
=UArw
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--

--===============2584471279109546431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2584471279109546431==--
