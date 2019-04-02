From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 03/14] ASoC: SOF: Add driver debug
 support.
Date: Tue, 2 Apr 2019 12:44:13 +0700
Message-ID: <20190402054413.GA2059@sirena.org.uk>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-4-pierre-louis.bossart@linux.intel.com>
 <s5hsgv5k6ox.wl-tiwai@suse.de>
 <631c6cba-2f81-6f5f-3d5f-f9f5bbb171c7@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7273473939018186018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <631c6cba-2f81-6f5f-3d5f-f9f5bbb171c7@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7273473939018186018==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fKtH0JUtvN5p2ETH"
Content-Disposition: inline


--fKtH0JUtvN5p2ETH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 01:15:46PM -0400, Pierre-Louis Bossart wrote:
> On 3/29/19 12:04 PM, Takashi Iwai wrote:

> > Doesn't pos need to be aligned to 32bit as well (at least at actually
> > reading from iomem)?

> Good point,  we can either return an error if the count in both a multiple
> of 32 bits, or do some caching to allow for arbitrary size access. The
> former is very simple but not sure if this is accepted behavior for debugfs.

You really want something that will work with arbatrary userspace tools
if you can rather than requiring special magic read sizes - things like
cat and cp should probably work.  A common thing is to do reads/writes
of the correct sizes into a buffer and then pick the relevant bits out
of the buffer to satisfy what userspace actually asked for.

--fKtH0JUtvN5p2ETH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi9qwACgkQJNaLcl1U
h9BuTgf+NlmA7q9YSZBIssQK1AP049eF3W6Qg0Sk8g57IywHoOBErH59scvb7QTO
BX6NPAceHjNbG7ZzHWHwQZFNCgKyWJQfz00aE3inaPQI5/8dr9uyZccfmoVufLe5
XlxqnPVs1RB0uavLCAQSXzUQrCZuALDrbdAqFLSegDI5xWeGDX9IbJ5pKRkGMWaZ
wCDOyNkUwh5ABv8RY8HIGjBL6ZltvH09UpQAx+7a7MVI1b2YKs4SJDG0tRMEMlrg
cEtEVdC0gfl+pkA2+GL/nQf5MshyMtZmS1jnHpFdxdbvpfgz22n1V+5jL3gaCKmV
Scuy1SJuaJNcNS4rhmr3PI/bUlykUg==
=EFoI
-----END PGP SIGNATURE-----

--fKtH0JUtvN5p2ETH--

--===============7273473939018186018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7273473939018186018==--
