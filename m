From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v4 01/14] ASoC: SOF:
 Add Sound Open Firmware driver core
Date: Wed, 20 Feb 2019 16:26:45 +0000
Message-ID: <20190220162645.GB9878@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-2-pierre-louis.bossart@linux.intel.com>
 <s5h1s4abu2n.wl-tiwai@suse.de>
 <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
 <20190219153836.GD6319@sirena.org.uk>
 <19843650-4f58-4aa9-7bf3-c1ce4c72d1c9@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5574793243940213669=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <19843650-4f58-4aa9-7bf3-c1ce4c72d1c9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5574793243940213669==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2019 at 08:35:16AM -0600, Pierre-Louis Bossart wrote:

> I see your point and agree the current direction isn't scalable, but I am
> not sure about the definition of 'first class device'.

> Did you mean 'component' at the same level as the 'platforms' and 'codecs',
> with all the DSP stuff nicely packaged and maintained in a self-contained
> way?

> Or a subcomponent that might be part of those platforms and codecs?

As far as I can see for the Intel systems it's looking like a first
class component - there will be some systems where the DSP is embedded
in something (like the big CODECs) but even there it's easier as it's
contained within the device rather than affecting multiple devices which
is the big issue here.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtf8QACgkQJNaLcl1U
h9Cy6Af/caMV45/fLm1lRwXpiqglZwPrB3t7VBCn6n85p86vA0Dcj6dISpHdjlPj
YA67dFqlUjCoo/A0WrJemQe2STIwv2zMWqMKaD9P3XFOR0gOZhXz9UmrJpESZcw1
LynzPKkSJlwc5WN6Ge6d5IJyYMOBnkb9qKqKveoNzcgzJae3yB28/H768K5ggbJy
GMNXM2aQb30Y57bDePwn8itevMJj0xQXjcfG9XIb+pslEtnAVlNUO5MKXr1wPH3S
xOJnZdqj2DAYDG8ZDs9oXshSSgs7ynUtrQ9qtFnhMYSHSU9lPtciC9dyR8DiXnFr
nk6UwiJf56MAfXICgDojJzG+91QQVQ==
=xIwV
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============5574793243940213669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5574793243940213669==--
