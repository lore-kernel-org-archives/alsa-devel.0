From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Intel: Baytrail: Fix stream
 restore after aborted suspend
Date: Mon, 11 Aug 2014 13:41:03 +0100
Message-ID: <20140811124103.GC17528@sirena.org.uk>
References: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6517321694546007000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF005265196
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 14:41:18 +0200 (CEST)
In-Reply-To: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6517321694546007000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ic9dmA6AaBNtx8DN"
Content-Disposition: inline


--Ic9dmA6AaBNtx8DN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 02:15:35PM +0300, Jarkko Nikula wrote:
> It was found that resuming active stream fails on Baytrail ADSP in case
> of aborted suspend or when testing only partial suspend. Reason for
> this is that in those cases ADSP doesn't reach reset even though resume
> path is expecting so and fails to restart stream.

Applied all, thanks.  It'd have been helpful if the commit messages for
the second and theard patches had made it clearer that these were bug
fixes.

--Ic9dmA6AaBNtx8DN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6LncAAoJELSic+t+oim9ryIP/07GoK6Ix+2+kd0zU9iQn0kb
i2I3URmiPh03HD2uT4AIX0exaR1JqC022JLW8UX+5TF5xcREe1Ywh4q8FoU0kLRa
G1rnAdCTYJvq5hq8pR91ZqRmE8Po6tQfTvABSFYlbLRJ+xAkzGLrZv2QYcZZEFyx
BpmJMI7yJw7rwKjwZfqQUIcNdbEectqahiWm8RQwCtmQ+FYz6eE+eWy0//FY6diI
D/ddbhmT12/asyc8nrpGMm3UWfb5hg+PJCCrKYCkpS7APt173PRzDZYXADsQmwXK
TvdBeemi+RMpXOTPSvV4/MFsHiWi4wtBPR1Wiqhx7mybnEQ/H8DPHoy6uXP7/X/3
bG/OvxGUWLqvz8TASybHXK5t8oUA85Zu4k4rQN9EoGphH3AC9H0gf14YnUkcuPDh
+ApXrBXbNsf/7i1z1+jw9N2Ct1VVdo+X5qxcIKA+D0azq9AGX8l/GHpyNELElyqZ
v8gAy89zGvJbDbEhcpFvg0RR7KTEo5A/hyKvRk812g8y+92pIs8mF5Z5LgUYK8Ls
L++Z3TVkgC2Rc3SBek0+OTW0AZjWbY+asobnQctkkCOUhH8DKC6mtbHCA6eR3MeN
2r+6b4lo1L6LhYIonGX4T8A9ErEoxtai3sX5VKG01nEmdMQ5ULUVbyWeHwRvPO/T
EDhJ2UidPceMYN5XGt84
=li77
-----END PGP SIGNATURE-----

--Ic9dmA6AaBNtx8DN--

--===============6517321694546007000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6517321694546007000==--
