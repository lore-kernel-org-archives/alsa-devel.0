From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH alsa-lib v4 0/4] alsa-lib: ASoC: topology:
 Improve hw_configs
Date: Fri, 20 Apr 2018 12:45:00 +0100
Message-ID: <20180420114500.GB22369@sirena.org.uk>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
 <s5ho9iepc7i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0453493141284929892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CEAE2673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 13:45:06 +0200 (CEST)
In-Reply-To: <s5ho9iepc7i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0453493141284929892==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 09:29:53AM +0200, Takashi Iwai wrote:

> Ideally, Mark should send the pull request for the uapi changes he
> applied so that they are "fixated" before going further to user-space
> patches.

Unfortunately that's a bit annoying to do now without using topic
branches...

> But this topology change is no intrusive ABI breakage, so I applied
> now as is.

Yeah, it didn't look like there was an actual dependency which was why I
didn't immediately push anything.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrZ0rsACgkQJNaLcl1U
h9Cjcgf/V/Brjc029bOSGFwSyuB5OtXQH+bLNKOXwj2ACKE7oDttEXWQm0djoY2i
mEdlwd/xoV1C1koEFx5DMoLWnEcks2ZChIq/WSRVVf5Cr4eTXqEPM0avl9TzrxIx
8CBz/cXJNlUe7cZCONEL5Q2na2QDRJrqZL9SbSfdyw72MPEffaCHRM5ZLNYjW27Y
VTRofaMMEdh0zYG4hsXo5uC7o0LtdOBbWrMv7/G1JOPmD2m+nSaDIJyfKK1+wmY7
horRncCia5UjDyJAjQiuGZADGeuMgModPnj8n7/0qduQTJAprqBwd8KC+61ns9hl
IJwEuPIPcHyOZKFif8YTNJrGLDyTrw==
=mwxd
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============0453493141284929892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0453493141284929892==--
