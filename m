From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Wed, 9 Jan 2019 20:44:27 +0000
Message-ID: <20190109204427.GR10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3045359342229090478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3045359342229090478==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ZpWocbG2H/Vq+uQ"
Content-Disposition: inline


--0ZpWocbG2H/Vq+uQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:23:11PM -0600, Pierre-Louis Bossart wrote:

> +	/* make sure count is <= avail */
> +	count = avail > count ? count : avail;

min()?

--0ZpWocbG2H/Vq+uQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2XSoACgkQJNaLcl1U
h9D3TAf/RkiXWjo8GAYvkFBj6Tz4xwa4aF654iZ929zEaz9ODfTP6JNGrsKQuVdu
RWDZpBZ58lBoU0EzyxawJwlxLEp5DAIBVAmRZiU6RXEw0ObanvjnqWHmQVENl8N2
QYqKAROU0P9v0GvEL23et88RZne32cxNnIsSPRXmRjFMfGGzRi8gWfB6zwXDcePv
DDDek+vOQvWwvfU9ZMGinJgFc2Y9Eqb7o1duZTTqejG8B/nTDKQXP1CyS0Mm5tRo
GtHIu7C0QKxMnt+xDzC+T/qs3ODso5O6016523VRku7x/HqG22xp0eAZcPMZP7yN
kkR5BDgyVCnKcjAQyGxDtVMiQwtGnw==
=Kz8i
-----END PGP SIGNATURE-----

--0ZpWocbG2H/Vq+uQ--

--===============3045359342229090478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3045359342229090478==--
