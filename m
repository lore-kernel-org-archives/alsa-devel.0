From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: sirf-usp: Fixed a bug for playback and capture
 work at the same time
Date: Fri, 25 Jul 2014 18:55:05 +0100
Message-ID: <20140725175505.GH17528@sirena.org.uk>
References: <1406092772-26371-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZoxY5VDSg+7Vbn9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406092772-26371-1-git-send-email-rongjun.ying@csr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rongjun Ying <rongjun.ying@csr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Barry Song <baohua@kernel.org>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Workgroup.Linux@csr.com
List-Id: alsa-devel@alsa-project.org


--dZoxY5VDSg+7Vbn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 23, 2014 at 01:19:32PM +0800, Rongjun Ying wrote:
> 1. The startup function invoked when the playback and capture.
>    If start playback when capturing, the registers are re-initinitialised.
>    That cause the playback fail. So move the startup code into runtime resume.
> 2. Modified: If non RUNTIME_PM support, the probe need enable clock and
>    initinitialise registers.
> 3. Refine code.

Applied, thanks.

--dZoxY5VDSg+7Vbn9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pn1AAoJELSic+t+oim9DFMQAIws5eN0VV2xP7jYfK65dgA3
u3mBFQE1Hfo2gWf6YVdd45IW53mKC8nJRgUA5LzijQl0HSZZBFMqyLd1teRECxyU
Dry4HS4EyOVH2oMzf2CbfWSGgVVN3qqfkgew0L3VlZDA+AD4nJ9NzdtvytrEuW1K
SYGfuwBdpVKASE9HSKkwOfZ/DkNrVBPBozuepUne+WbfHmoWM0gelQ8HggAkNjpL
y5Ity/a6LZkmwtVr3kVqqEtcPH0kMNHs1xh1EkHOoux+Al2Euaw0Su9N69ZY8V7d
ftfH0r2/iZ+fOE+pqkwjHIe7LGwgEQYmH2ez+XEVoY+S2v9kJ0nf18RQAifggvvL
SCiKgHmQBHOOr6P0myE6R13uI4eLrBOMEdQ7fMIBbmtM5Ai8V/P4+gpDI9GGtjND
zNrx84PrzCMBXGe9Ew7kPGc/bYDR4iK5gTgiWGU3AkhPoGAqFu7zXt0ZsliYUUf2
FpYHH0D8kRoJZ7dvMJaNnWO95X3XjrIUAcAWexC5uYGPGOoqwR8AaOAXfzzKPgtt
fhVn+1tK0NcR5+BJQpU+EJP7+M82hfvlQqb6A9bfGQOeh+g1ee+4zWRw+p7a8Q0N
lkWui/5XOhrGg7MpSb8yQV36xo0zPeSdO4k5dD53kFDxoeKyA8dSVnqKnv6S96QB
SEvoksDsVzX3TbIMTjEF
=KquA
-----END PGP SIGNATURE-----

--dZoxY5VDSg+7Vbn9--
