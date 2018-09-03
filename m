From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/12] ASoC: SOF: Add Sound Open
	Firmware driver core
Date: Mon, 3 Sep 2018 16:07:47 +0100
Message-ID: <20180903150747.GN10302@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-2-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3725290424440395377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF9E2676C9
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 17:07:48 +0200 (CEST)
In-Reply-To: <20180831151910.16122-2-liam.r.girdwood@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3725290424440395377==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+cfQkLQGU7KOA/8T"
Content-Disposition: inline


--+cfQkLQGU7KOA/8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 04:18:59PM +0100, Liam Girdwood wrote:

> +	/* private data - core does not touch */
> +	void *private;

This is still a bit awkward - the name is now not SoF specific but it's
not clear which of the several drivers in the system can use it.  How
about adding some sort of key/value thing, or making the DSP a first
class object in the system (eg, parallel with the platforms)?  This'd be
a lot easier with the refactoring away from DPCM but progress on that is
very slow so...

--+cfQkLQGU7KOA/8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNTkIACgkQJNaLcl1U
h9AHsQf9ELjNCSGw+jB2iPxTvbMmnO7zY+BT9KfYJD4oHf8GKdNVvVOSQFJbx48V
KmvkHuQHgMejCcr/WwyczUzV0JE/dwSk9tPBBio4+jpOTAM8Q9KOLbekiJgxR9pu
ge52r7TWyIbC/TC0ajD/FAlr7YdrE7hXzfvCq29jllqNo6LDhFUrKEkXKzW1xH2K
SSvS8VwL8kdjhWDnR92JI8/gnP5iXS3XFc9jH2Qq0s/skPzue621UlJnqoIbzStE
skZRh5ebxv0r82nrGZOlys2spyJMGXx+peuKmagyYyyUPDryq2MEHvSyyAz8DrWh
4Eh6v149cQ2zl9rzM/XKxmF0j5DsaA==
=N++Z
-----END PGP SIGNATURE-----

--+cfQkLQGU7KOA/8T--

--===============3725290424440395377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3725290424440395377==--
