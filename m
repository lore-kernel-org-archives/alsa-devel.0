From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/14] ASoC: SOF: Add DSP HW abstraction
 operations
Date: Tue, 22 Jan 2019 18:56:19 +0000
Message-ID: <20190122185619.GH7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
 <20190109205129.GS10405@sirena.org.uk>
 <739d6933-0846-49c2-aa85-c3e869521881@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1521584554670500749=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <739d6933-0846-49c2-aa85-c3e869521881@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1521584554670500749==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 09, 2019 at 03:37:26PM -0600, Pierre-Louis Bossart wrote:
> On 1/9/19 2:51 PM, Mark Brown wrote:
> > On Tue, Dec 11, 2018 at 03:23:12PM -0600, Pierre-Louis Bossart wrote:

> > > +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
> > > +				     u32 mask, u32 value)
> > > +{
> > > +	bool change;
> > > +	unsigned int old, new;
> > > +	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */

> > This looks a lot like you want to write regmap_pci_config...

> I think you made that note for the v2 a long time ago, not sure if I replied
> at the time.

> We only use this for 4 cases (power/clock gating on/off, traffic class, etc)
> and only during the hardware initialization. This is similar to the legacy
> and Skylake driver, I don't see a significant benefit with a regmap?

Mainly the debugfs stuff and trace I'd expect.  It's not a requirement.

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHZ1IACgkQJNaLcl1U
h9DeUwf9HG1hM1IfYpxSQ4mbIex4M/n2l2rhTFjQNPKc5/3U3af6FC0DsOK9Ia+A
f4uILPPpIbVXJmPYdRN/Vm84p+wj6WU3BazdSjPII4VR00fgo1rAm+492gsUz9IB
VLZneZevNE5mNfU64OtK3EatW+PuMWuRqOekfyJmmUESmUw/Zczt6JU9sR9V0do2
AvCeZdwpvmPHDFQGRqlCuNt0A8a/gg0w2um32TGf5MM7XOgRXjmskySYsuSWu0q9
crISeaytP60bZTDrbeMKLDWuOW7V49zufHg0cbiswF6g/4hnArd1ynVzMwkByneS
opeSz//Qy2oCgSILdFHuUWWTvV92cA==
=b6UQ
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--

--===============1521584554670500749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1521584554670500749==--
