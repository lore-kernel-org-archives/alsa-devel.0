From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware loader
 support
Date: Wed, 9 Jan 2019 20:55:32 +0000
Message-ID: <20190109205532.GT10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
 <20181211223829.GJ10650@smile.fi.intel.com>
 <c3389d5c-f960-d067-b560-47af97353017@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4307674918551223976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <c3389d5c-f960-d067-b560-47af97353017@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4307674918551223976==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UsbkURXZxe2ekgES"
Content-Disposition: inline


--UsbkURXZxe2ekgES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 05:54:02PM -0600, Pierre-Louis Bossart wrote:
> On 12/11/18 4:38 PM, Andy Shevchenko wrote:
> > On Tue, Dec 11, 2018 at 03:23:13PM -0600, Pierre-Louis Bossart wrote:

> > > +	struct sof_ipc_window *w = (struct sof_ipc_window *)ext_hdr;
> > > +
> > > +	int ret = 0;

> > I don't see how it's used. Perhaps you need to check code with `make W=1`.

> Darn, we missed this one. I thought we were using W=1 on github but we
> aren't, this will be fixed.

> Though W=1 doesn't report this one, so need to re-inspect this. Thanks for
> the sighting.

This is one reason not to unconditionally init stuff on declaration -
it masks some warnings.

> > > +int snd_sof_load_firmware(struct snd_sof_dev *sdev)
> > > +{
> > > +	dev_dbg(sdev->dev, "loading firmware\n");
> > Noise.
> > Better to introduce a trace points and drop all these kind of messages.

> it's not that bad, most people understand what dmesg is, it happens once and
> only if you have dynamic debug.

Then everyone adds their print on boot and the log gets huge (and slow
if you push debug through serial during development).  As a rule of
thumb I tend to suggest that if you're not reporting something you
discovered at runtime there's probably already other ways of getting
equivalent trace.

--UsbkURXZxe2ekgES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2X8QACgkQJNaLcl1U
h9AFPQf/e1kc/8ebH0USO00Y5uvq5iA3r/EEfLcxu59UO7GOcnyUMgYpD005UfiR
u4ZDSBgBDSaJKv/O2C9vre8mVsikHdLt97ugwSqZFaPE06u7I42tltpfJqnpiYbK
HkfbL7Arp9nCATGT6uL1EXVsdOdcAk2I2aEHH7ppQ9zaYkRUC02wsOxdOk8vP7zR
mjYlfUsV8t6KcVirOaun7ULE9TUS+hGyYcn7xxOjEjbX1qeXqRcQYC8ZvvUTaE8d
6BxnOjNUrjU4Zt77YT6tZ+R0KXJ/9YzPgO720+wWow9b+Ght5DsDQfeqcowyFTz1
AEz2fPfIzew5x60XhWSuIAHBRLAd8w==
=8H1t
-----END PGP SIGNATURE-----

--UsbkURXZxe2ekgES--

--===============4307674918551223976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4307674918551223976==--
