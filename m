From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control registers volatile
Date: Tue, 25 Feb 2014 10:21:38 +0900
Message-ID: <20140225012138.GK25940@sirena.org.uk>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
 <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
 <20140224124230.GF25940@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376BAD405D@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="teB4kYKCoFg+dcUh"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376BAD405D@SW-EX-MBX01.diasemi.com>
Sender: stable-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--teB4kYKCoFg+dcUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 01:57:53PM +0000, Opensource [Adam Thomson] wrote:

> anyway. I'd be tempted to keep it simple and just make those registers volatile,
> then you know it will work as expected, at least for the time being until a

That breaks suspend and resume without further work - for suspend and
resume we generally rely on restoring the register cache to restore the
current settings but if a register is volatile it won't be cached so
will go back to the hardware defaults after suspend.  The ability to
avoid I2C traffic is partly just a nice side effect (though it was
needed on devices that don't have readback), the main thing these days
is that controls get efficient suspend and resume handling for free.

Refactoring the offset correction to happen once on startup would solve
the issue since the cache could just be bypassed, though you are likely
to find that there is some run to run variation for the callibration due
to effects like thermal variation and simple measurement errors.  Still,
the effects are typically very small.

--teB4kYKCoFg+dcUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTC/AfAAoJELSic+t+oim9GTUP/idaL0Ku0s1Nxe6uExqBNqJl
aRom7QFTJbrn0L0ZDDFf8n63/bdWaRvHM95lft0VJWiayQD8FfOYGcP1vbqWOJX7
GVVKWTmtg8PrvnDP5Qd982mJ+wKPts2hhECLu7BvWCvuwOpbGR4tCdrXXRmwmPOU
01VvSa/pclwQ8P1EQVZTZptnorIDqVMUJyVu91L9NQxVlONXRUMUHk/yBqfDSlXr
uWUWWu+jCcf9lLDa5IMcLUabi9IuCfyQFoOuDie4Og3/9T5OQF+qXGZcZSjoO+UP
WhgLpLBMwXMky1KfKLTqNiiL2S5+W8/mz5sXw/Y7lfs7BAlMaee2cuoLqjGtIoa4
hHFVI0lfJXWKtOlgeA06gmVskrJtp0N87JB5WZZ/H99QoZVCUHSIdp0KUUHgRCf8
XuqmNDv2pDHMK0m1A2cQ0k+JHhajCKa/Nxu2KASlDq6UfxytDNksMO88H5Jeqp+A
9MzBPETH7dpQC1ikOPV6dd3RCLQKCIWZj0lusXRSE1k2jYPaz+2TauRmBenHv5Cy
U4e+/IWXqsqlUXz0I1mFQe2LcXGUKHFZlNiA/Ars2MUBEnO/NrZOAcmJn+5mYGHV
e8HuuJWFA7QDLkEoTOdhpChWX4DfaXxs5bPnKKiWhc2mqWCtg7CmQsXPBcgGU5mB
8AGSptXB6vJPrk0D9m6B
=Wj+y
-----END PGP SIGNATURE-----

--teB4kYKCoFg+dcUh--
