From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] soc-pcm: check symmetry after hw_params
Date: Wed, 20 Sep 2017 12:41:02 +0100
Message-ID: <20170920114102.oszwyegotv43js4v@sirena.org.uk>
References: <20170920062530.12252-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1098879054244868412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21055266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:41:05 +0200 (CEST)
In-Reply-To: <20170920062530.12252-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1098879054244868412==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zf7qfhv5pasm2dpj"
Content-Disposition: inline


--zf7qfhv5pasm2dpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2017 at 03:25:30PM +0900, Jiada Wang wrote:
> hw_params may be fixup by be_hw_params_fixup, calling
> soc_pcm_params_symmetry() before hw_params will have issue
> if there is hw_params changes in be_hw_params_fixup.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--zf7qfhv5pasm2dpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnCU84ACgkQJNaLcl1U
h9CJkgf/cfDd+RbKJ8hvJHi/jBva5/bWjZuinGaNtjGWtRXtFph+h93W47Ue+90E
z/6iedjkPKMmo37txsAa/robE1A9agELR1/ByUcbUxlAT4Qe8FScY2SKqkyIIpco
ea8f15LqmmoYYT3w8iZTVSoZQazhHiI8AGBQLEvnnkkJju0yRONLfaMpXZtdkY5p
5ZKqppthdU9AWiiaegqOrBWg5DylmgTeUvyi0KSCld7YYoMPhxP1V+ujka7t8cfb
nwi38BKbtishlFWM7qvkgfYZeglMBVvOTiUXK1LupA+e9lNtjYh2eOYMdu1MiGmV
1vQQHjd6xg3TmVC3xdc6921TI+kGOA==
=gNtD
-----END PGP SIGNATURE-----

--zf7qfhv5pasm2dpj--

--===============1098879054244868412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1098879054244868412==--
