From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 0/7] ASoC: Intel: Skylake: Driver
 fundaments overhaul
Date: Wed, 24 Jul 2019 17:50:32 +0100
Message-ID: <20190724165032.GB4524@sirena.org.uk>
References: <20190723145854.8527-1-cezary.rojewski@intel.com>
 <20190723154449.GJ5365@sirena.org.uk>
 <cac0d84e-61d3-5379-cbce-10f8d637310d@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2162554400612889834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B75FF800E3
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 18:50:38 +0200 (CEST)
In-Reply-To: <cac0d84e-61d3-5379-cbce-10f8d637310d@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============2162554400612889834==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 01:07:31PM -0500, Pierre-Louis Bossart wrote:

> Overall my recommendations would be to:
> - give Cezary's team the benefit of the doubt for their Skylake reworks, and
> add him as mandatory reviewer for the skylake parts. That doesn't mean
> merging blindly but recognizing that no one else at Intel has a better
> understanding of this code.

This seems like a good idea, Cezary could you send a patch adding
yourself to MAINTAINERS please?

> - draw the line at "no new features" after e.g. 5.5 and "no new platforms
> when SOF provides a solution". SOF was expected to reach feature parity by
> the end of 2019 so it's not a random date I just made up.

Let's review that nearer the time?  I don't want to impose a deadline in
advance and have people needlessly rushing to hit that deadline when
things might wind down themselves naturally.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl04jFcACgkQJNaLcl1U
h9AQhwf/YeiSNmz8/Pok2f0VH9Pzu8YoGxTj/LTegQwAIr6zYvTxy7a8p3xGKjT1
eU/p/uIK2OATqVUMQQvDFdUiiMaN5/j2Arfid1jeOJVwVmhP4N4420J0adkFWdLd
OHX8ObPVQGXFttbEz2fk/FmD14N61qxY8wcUUf9zQfbz5a+9iQINe3QFjAdly8NP
QBkgiE4rqmsxOd/JLrU/GNApjkDG1YZzaKXdXVX4zRYvhMFLhWCZRljfvlPuyn5u
D0cFzmlW2gRjDspaocTFWzMz5N03vAOXff6cdA05bUKdvJnDAjhJCot0NEe6RtLm
uvU4Szdw2NYWjrzTPzz4qEVrYiRgWQ==
=Oz1G
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

--===============2162554400612889834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2162554400612889834==--
