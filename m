From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: da9055: Update driver name to
 fix breakage due to pmic driver with same name
Date: Mon, 5 Aug 2013 17:23:42 +0100
Message-ID: <20130805162342.GS9858@sirena.org.uk>
References: <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix>
 <20130717103651.GP22506@sirena.org.uk>
 <1374482594.13726.11.camel@matrix>
 <20130722100211.GP9858@sirena.org.uk>
 <1375110386.21326.6.camel@matrix>
 <20130729160157.GZ9858@sirena.org.uk>
 <1375689331.28910.5.camel@matrix>
 <20130805144201.GF9858@sirena.org.uk>
 <1375717898.29528.23.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eLzwy7sDwuTm2pX7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375717898.29528.23.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org


--eLzwy7sDwuTm2pX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 09:21:37PM +0530, Ashish Chavan wrote:
> On Mon, 2013-08-05 at 15:42 +0100, Mark Brown wrote:

> > No, I'm talking about the same thing I was talking about originally.

> Thanks for confirming it. From our view point, we still feel that it's
> not a good design which requires an additional MFD component even to
> support a stand alone CODEC chip. The way we look at it is, there are so

What makes you say that a MFD is required for a standalone CODEC?

> many stand alone CODEC drivers in kernel and most of them are fine
> without the MFD stub. We wish that our DA9055 CODEC driver should also
> be treated in the same way. Just placing it in a different hardware
> package (together with PMIC, in this case) shouldn't necessitate any
> changes in software. e.g. whether any chip is produced as a BGA
> component or through hole component, has no effect on it's software.

You only need to write the glue once, it'd probably take you less time
than writing these e-mails...  Once you've handed the regmap to the ASoC
core the code is identical.

--eLzwy7sDwuTm2pX7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9GLAAoJELSic+t+oim9OSgP/i0wQv6HLLKZ9dS5BeKMOee8
NKLNTje/vYpHaW1qJATgw95OMDZFl42A/dRdpSY4CxZcQtIOTozwSBVO9lHIJMoL
LTsfuUIdFUUIlTvlHDWIObquRdqren8ktmkBrTsvVISrj+6Gm9M/MErMMKwiQw3a
jLAHvh7Q0biugfkCHFiVimvoIpSNVhMmnpce0U03Ry19m3YanFOf5s9qASC6BthO
oi+Xr77dBDqT22CN/b/GyZ82TqlV4mxEac8PNQ0q55t3igeI5L8eSKaWfx8PrXUH
XV4ZU+oG0e1S+navzcBItln6nEEsWpXiIrALEOVvVEaZknzfP5VEloyeMAAmZezc
yWhSnAAVjAgQ9j61OXy8ZzxWg96cqiTkY8MNMGNVrW+MStKnyGzXsm6NQ0RfoOBT
h2W3tdD0GvYTnlf6gTJ7xOXi2yXPYh0DKNPx3KSDO6YpHieBpjCilMCE+upsTuLf
UZr7N01V0bsHJYRxyr7qD+Y5HrVH9sujnYOYVxpINuMx9gGlf4E+5fNRwBvW6z7m
C9fFpoHyA5hQ+pPmP8ozuEWJZ7ciC8Afpw0EcGA9R7f/E74omMMqu8VVDITzywAd
5UPYMmOdFuZz0JFwPLXVGuWiJf5RiD3XkEEGx8cl3A5KKKs90RW4YWXvE6PXx05E
4y0WySPVGtWclrcJ0N6q
=zP8W
-----END PGP SIGNATURE-----

--eLzwy7sDwuTm2pX7--
