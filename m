From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Do not traverse widget hooks to snd-soc-dummy
Date: Thu, 17 Mar 2016 09:54:38 +0000
Message-ID: <20160317095438.GD2566@sirena.org.uk>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YpRP0zjcYagsg5gy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--YpRP0zjcYagsg5gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 07:17:51PM +0800, Harry Pan wrote:

> Conflicts:
> 	sound/soc/soc-dapm.c

Don't include noise like this in upstream submissions.

> +	if (!strcmp(cmpnt->name, "snd-soc-dummy"))
> +		return 0;
> +

This doesn't make much sense and is going to be very fragile.  We
should either make the dummy component look like other components or
make the code cope with them as they stand, that way we don't have
random undocumented special cases scattered through the code.  Probably
it's better to make the dummy component look like others.

--YpRP0zjcYagsg5gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6n7dAAoJECTWi3JdVIfQk+4IAIABmLQIsUWP7/6db5+ky6MM
jr7Fh7/d42wfjKw2TS744tugV1plO7SPZogWOz6uE1FiKuqO2UntBlCx+1BOy1Z2
zd31Ibf/HZaX4T+BvPUdRci/TVsn7wGYLXSI5mBiOnaAP3ILQqEvJd0x3KFwjadD
IiaKVOqGNZ6iFAGW8Lw97s35n28ZU2kNgi/a0McoWf4hyu4fsRZvxiwcZgvLrZCg
unpz+kXGRiGtzmVut84RbnaNbz3q0GLw0M0sK5/5ygfH56KSAhlrIpJGPVKiTS6z
ZsuLBrbIltpQSbOchXv1HRyO4xYqMSpgyhEpVlt8uhuJBMkMC7A5oKkvqU+2yYU=
=Dsg9
-----END PGP SIGNATURE-----

--YpRP0zjcYagsg5gy--
