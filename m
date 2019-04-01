From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 16/20] ASoC: SOF: Add PCI device support
Date: Mon, 1 Apr 2019 14:28:22 +0700
Message-ID: <20190401072822.GF2059@sirena.org.uk>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
 <20190321161055.26582-17-pierre-louis.bossart@linux.intel.com>
 <20190328174819.GM9224@smile.fi.intel.com>
 <20190328174918.GN9224@smile.fi.intel.com>
 <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6916765465257522262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6916765465257522262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 02:21:47PM -0400, Pierre-Louis Bossart wrote:

> > > > +#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)

> > > Can we use Merrifield / mrfld instead of EDISON in entire series?

> we could, but I don't know of any other platform than Edison to run the
> code. I know it's less accurate from an architecture perspective but felt
> Merrifield was confusing for non-Intel folks.

I'm not sure any of this is particularly clear for non-Intel people...

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhvZUACgkQJNaLcl1U
h9B24Qf+LGZlXwNzW4nm8zR85SEBkQ1jdyunEHKnd6xryhbKtsg7lPbL2RpbXmQo
q4I7N86FR5zHXDLDzSqEVCEhIkUmppVj2/miy/BFfOstDkzsVWRBJI4sgKCprM+s
FoXw/h0OoQEprmu1n+roQUvwdtvXMvpL0pikedWelQSNpdp29LwMT/RXltujSRwy
DjMztRJKT9/0Ivt1r1ou3i5rpxflhgeZSkq5qfdNogqCUXaKPma1aR0TCRtMYRJF
hhYDxDHZrbf+bjipyOwr1QXMyX0xFpNgs25ZYYV5yBNu8ooCxgmc0X14Fag1aJz6
3ZodBobg09fcgndfk3AJ4dPBPQVsqA==
=FVC6
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--

--===============6916765465257522262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6916765465257522262==--
