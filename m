From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
 compressed ops
Date: Wed, 24 Jan 2018 15:33:30 +0000
Message-ID: <20180124153330.GF9366@sirena.org.uk>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124142901.GG18649@localhost>
 <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2658672969275386666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3039026758A
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 16:33:41 +0100 (CET)
In-Reply-To: <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dan.carpenter@oracle.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============2658672969275386666==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 02:49:15PM +0000, Charles Keepax wrote:

> The offending change here is only in the v4.15-rc's so if we can
> get the change in before 4.16 there shouldn't be any need to send
> anything to stable.

This doesn't apply against Linus' tree so that's not going to happen...

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpop0kACgkQJNaLcl1U
h9DCzAf9HevSbkdBZGYmpl5A9rgoPia0D/JAVluC2E3Q4SO0o0NTzMeIXDRm3KWr
fvRAtl1wzDNcB4xNY7GGuJQjEHbCwAxfRFhjQHVdjhPAM+FxsPUPs2KIi/7WsOeo
E0v2w8pLfWKcTuVDCJpRWZvw0OfRJ7KzkHlmUXOLc1UzjUki+JyJ/K5zOWgPy0jB
m5JKa5+MkoEposN9ucJq16vdH34a0f4oJM4BlORQWATCuj/iBQ02ajAByM9JryoF
WhE9XfgRlVUyhb8FXks+Hv8mj+b+dpBd0gvpzEt7YJp+oM4BDMbIG2BogIOZripW
DPhgncNzga6qZp8sBVGB7q97+WrW/A==
=ngQa
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

--===============2658672969275386666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2658672969275386666==--
