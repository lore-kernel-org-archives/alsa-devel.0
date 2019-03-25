From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Date: Mon, 25 Mar 2019 12:12:32 +0000
Message-ID: <20190325121232.GF7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 23, 2019 at 09:55:46AM -0400, Pierre-Louis Bossart wrote:

> I'd like to highlight that there is a fundamental flaw in the way the
> machine drivers are handled. Since we don't have a hook for the machine
> driver in the BIOS, the DSP driver creates a platform_device which will
> instantiate the machine driver. When errors happen in the machine driver
> probe, they are suppressed due to a 'feature' of the device model, so you
> can end-up with a broken configuration that is still reported as a
> successful strobe.

These are driver specific issues not device model issues as far as I can
see?  The issue fixed by this as is that you're storing a pointer in the
ASoC level (not device model level) probe that you don't free when the
component is unbound, causing you to dereference it later during
suspend.  There is absolutely no problem with the machine driver not
being guaranteed to bind at the time it's initially registered, that's
perfectly normal and should cause no problems.

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxa8ACgkQJNaLcl1U
h9BQNQf/ZXvr/GtRQbc1tulU2dg2cV0Ubh1sW9F6qTbJgiJDD2cHA1EG8aoZaYEe
vbrYbhpioejXYybsY1Y7J5fHvW1zCPCZ7A0qtP/RtBWt9Wagcq3glxuSlrPTx8tN
Tdt+NcZnHN7D5ybaGmEaOcsNY431mEgJOfNZf08Zr/gHLWAe6QHNBYrlBEGhn7Up
3vgh+G3W7JBpE3EytIIoaqfMqnTOkwN7lPl/3l3yEqk11rYYS8X2vJHzx2w2Dsdc
Osq9rBM3qvwuSJjR1P5+kZJHm4JKzhUUhmXlvK43iHANba0IZthB617xMI9dK2B/
ACLzGeDepi9dTaoEByAV6uPwIZ7LXA==
=wwVO
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
