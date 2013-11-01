From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Add pinctrl PM to components of active DAIs
Date: Fri, 1 Nov 2013 11:11:59 -0700
Message-ID: <20131101181159.GC2493@sirena.org.uk>
References: <1383308175-5053-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oMfk58fZ06Sy4zVm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383308175-5053-1-git-send-email-b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: lgirdwood@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oMfk58fZ06Sy4zVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 08:16:15PM +0800, Nicolin Chen wrote:
> It's quite popular that more drivers are using pinctrl PM, for example:
> (Documentation/devicetree/bindings/arm/primecell.txt). Just like what
> runtime PM does, it would de-active and en-active pin group depending
> on whether it's being used or not.

Applied, thanks.

--oMfk58fZ06Sy4zVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+7sAAoJELSic+t+oim9FcIQAIE73n/cYVLHkjzGd856TUFi
wDAVEjA67YHt6Mm8FTwZxHudjV4wqBLKSFxaTqMmdTTXjeMxrU0Td4GYAGZMhT63
Xkk+w1wrZbQsv4FlLGnIIjZJ3LUAzimPugQEqnA8sTEjqR/6UFQhKXTntGmwscZB
qifvrGztT78d4mGR915sLHC3YMqALAXH9RXBW66PE5KYAcPorerUNSPXQFenWgmd
f1JiXefPIfTFFFooMvvhvh9CbNRZu/R91jKh4i51SafQHHVN8k2cNuKjYTmeAs48
H4L7QDO+iV4K0xXagX+lRVwVw9p/0KfjHDrN1EleHKGOcFNhWmmjzJj4fJdKfxWu
l6coJqHSgxl0vAu3IwzRKQwHL0dSHZU9aYTIZef9WZRG6yiMF2bMAtGZyNA8mNnV
saocQNMDsepCM5Fh1Lsp+dvJpuj89C+INH3wfGtTUXNKAXK2JX8vd3sqOtlO6MTm
6s+gkAu8hByYpGEQtOhh5dLeEy/tbr7tKCFmUEf1JQWlnm9wPz5Zi5KYbcIbVonk
VKrTkGviRxng7cHwsv86ZxqgOOUWlTRS7P1nfegesPIKXw/JMe/uvv8uylo63T0a
1s0wQxuYhbiZdKlOpjBzdmHiWPzPbB5jZwyPkI/bPFcjfrZl/BGRVsTzngHC/MY3
c+v2j8dM2bXJDWbMMsGy
=l/tR
-----END PGP SIGNATURE-----

--oMfk58fZ06Sy4zVm--
