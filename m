From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: Fix vague codec and cpu DAI
 prepare error messages
Date: Wed, 24 Dec 2014 11:59:07 +0000
Message-ID: <20141224115907.GS17800@sirena.org.uk>
References: <1419325481-32094-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6154513702844904792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6881261490
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 12:59:27 +0100 (CET)
In-Reply-To: <1419325481-32094-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6154513702844904792==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7xCt7SCsg4fkJ38"
Content-Disposition: inline


--p7xCt7SCsg4fkJ38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 11:04:41AM +0200, Jarkko Nikula wrote:
> Both codec and cpu DAI prepare print the same error message making it a bit
> more difficult to grep quickly from sources. Fix this by telling it
> explicitly.

Applied, thanks.

--p7xCt7SCsg4fkJ38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmqqLAAoJECTWi3JdVIfQq+MH/0Fe8MZKGk6w5Q9zCGwBGkcG
tFMs8kQCQdyPaKQWYD+2HvSEuyaIlUln7J6Yusg2UgVKW1+5SrGhgYtIi62V2UZ0
vAdlhYjMzC1ITPB7zDfgD9xCO4GwznCEZ71FBKsK4j3/3omDg37dz0sIkjKuZDc6
cg0hWMOZLvsB92r0XdARBt0kmgGlKmL30qXsHL54wOxeqGQ0BRzkzQO0r3aK732I
a+/bI4NgTT1K9DDtFS9LfyIUqxtm0Z7eL0tcqt49gKyvxgxoMUQdUyV5rjPli2ZE
2pCY7pdgDwubbhAlBqhD3WvimcYPnJlnS96fbl2oUyFi4f2U/PPuH3zscwRhoao=
=oyjM
-----END PGP SIGNATURE-----

--p7xCt7SCsg4fkJ38--

--===============6154513702844904792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6154513702844904792==--
