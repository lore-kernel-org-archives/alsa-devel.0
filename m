From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 42/42] sound/soc/kirkwood: don't check resource with
 devm_ioremap_resource
Date: Fri, 10 May 2013 11:56:20 +0100
Message-ID: <20130510105620.GQ3200@sirena.org.uk>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-43-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368173847-5661-43-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 10:17:27AM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjNJRAAoJELSic+t+oim9LMgP/jywx9NAjFcL8jhkepKJGZ5s
ghvVXPjgCNTzxZ5U4/3ggS3l2zrv0yQ332KUU4cSMqMnkV2F6ge6ecO4qpArbffF
rqK2tw811plfTTR/TN4+PBnJgfslyRyApDCTg7xmqzndVCdaVnTjM6OHKfZ69pea
dd02q0sUSnI2Xv/f1EntMqWesqQ/YCoFp/hFAHEwK4ng8wMW7kxYbI3Pro8SJFMR
IxPH48Nf5lAZJHSbOtz8wS0d3F+rAgeZGO+IXH9+wUrRFVoNPrh+rP1PoikNoXho
IXjARjc1rbekTgfd5Jhx4P9x8wleiQisT5it4FBtfWwAROXCUrfSAWjmCMJHrCp6
yh7HVLlL/DJTwCj6NEBmx3j9CXXnZaZ+rRvKbj1pnBD+O8BzI8JVUp3dfNDso91X
hL1bI5ZcfZ+wSvSR6wCeAWXLv1uAaBNDBttLjNSjy3kmhTRgbA59rh/i2RM36tCp
DlGymaJzwLzBCoP07ozQPFutKoodgHmLBjoMty4AxQf4yXdh8f/BZC4azBJjWN7z
/8CPjrphHU8hlKWHTn7NmUV+1Po9gWpoAhNgjyGOu6TicuDDeEQ7NpQlnH0bLD7N
uka1d7EWvtsDqIxjoh3wfH+4VCl9/OKoxFR92kFryAtgw6tbhaGoso/XDZeZLj36
ZtcHQMskfb05ISehHbcU
=yxO3
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--
