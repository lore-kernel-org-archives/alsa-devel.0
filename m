From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/8] ASoC: intel: boards: add card for
 MinnowBoard I2S access
Date: Wed, 6 Jan 2016 17:42:07 +0000
Message-ID: <20160106174207.GC6588@sirena.org.uk>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1451949630-3475-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160105131539.GC16023@sirena.org.uk>
 <568BD823.3080703@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3196620771470718688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E565260417
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 18:43:20 +0100 (CET)
In-Reply-To: <568BD823.3080703@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3196620771470718688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TCH5zSpbvKOKdCih"
Content-Disposition: inline


--TCH5zSpbvKOKdCih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2016 at 08:50:11AM -0600, Pierre-Louis Bossart wrote:
> On 1/5/16 7:15 AM, Mark Brown wrote:

> >I'm wondering how this is going to get loaded (I don't see what creates
> >the platform device) and how we handle systems with a CODEC connected on
> >the expansion headers?

> Good question.

> To solve this audio is disabled by default, and we have an EFI application
> loaded by the startup.nsh file that sets the relevant codec information in
> the SSDT table so that you can swap codec cards at will. The EFI application
> will be open-sourced so that additional codecs can be added as needed with
> changes in the ASL code. The whole thing was tested with experimental
> releases in three different setups for now but will be formally released
> next month.

Sets the relevant codec information by...?

> On probe the sst_acpi part checks for the presence of known codecs and
> registers the platform driver. For the case where no codec is present I just
> added an entry at the end of the table that always works (checks for an
> SOC-side HID) and is selected if no other codec was found. I need to add
> this patch and submit it, forgot to add it in this batch.

Can we punt on this until we've got the rest of the infrastructure to
look at?  I'd feel safer and it sounds like it's going to need some
manual hacking to get working anyway until the other bits are lined up.

--TCH5zSpbvKOKdCih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjVHuAAoJECTWi3JdVIfQNywH/1y0sJLrBlZUhgbKFjaQC9qc
/TLfSjBkZw7go6zNjNqggS9ev+6CvzG+gVX1R9ZN1BUC5ThXb7mDPHIzSDcE2Dda
10I668l8csL9Q8UqofuRUv+T98lZjvgAWJvEOPGQzS6a0f8Ki9x7ZrajSm6xjjpw
h+4+sAe8fALUswxde+jsoB5bSrV5JwuVP1y0j+qo1x2oJzX2VEQ4jstoo0nOkARP
qZUZrOAToahokoIsXXBHg9uMUrijjB3+JggtHD92xo+XZDPWnbyWd3vxUwSVwRDC
0FSX3Gm8jqfNYELZ4Pd4WQ1SQ+H8LIkFFlE7IjjwKVy3D1/hpCVP1JjpEL3oJWg=
=FqaC
-----END PGP SIGNATURE-----

--TCH5zSpbvKOKdCih--

--===============3196620771470718688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3196620771470718688==--
