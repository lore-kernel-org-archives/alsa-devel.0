From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: max98925: reading beyond the end of the array
Date: Tue, 21 Jul 2015 12:04:57 +0100
Message-ID: <20150721110457.GT11162@sirena.org.uk>
References: <20150721085527.GA22070@mwanda>
 <20150721104350.GP11162@sirena.org.uk>
 <20150721105743.GO5422@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oEj3/8+YnogYHQRs"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721105743.GO5422@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Anish Kumar <yesanishhere@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oEj3/8+YnogYHQRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2015 at 01:57:43PM +0300, Dan Carpenter wrote:
> On Tue, Jul 21, 2015 at 11:43:50AM +0100, Mark Brown wrote:
> > On Tue, Jul 21, 2015 at 11:55:27AM +0300, Dan Carpenter wrote:
> > > Debug prints are seldom useful and this one has an annoying thing where
> > > it reads one space beyond the end of the array on error.

> > It's a pretty big stretch to say that debug prints are rarely useful...

> I asked Anish if it was worth fixing and he said to delete it.

Sure, but you're making a general comment about debug prints being
seldom useful rather than just talking about this one.

--oEj3/8+YnogYHQRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVridZAAoJECTWi3JdVIfQ+OMH/jpQMS5idHCPfkTYyC6kFuLs
fiUA4CdNWuObghXEjCmbVyWEDEnujw4fqkXjE+2eQwlE9LpsoM9fNJO93WFBwtAn
mfgL6rog0c/YG6+/2yZJhQmr07ys1viO7L14AxPdTgKMRBIvkes4Wx9hXOzHwRXn
xpr7VmwAfBSseqpI6srtNU+JIsxHquhjO2VJpZbsv2s6RrKemYAjAHs6t3Eu2oNs
pTf8qqO5bxJrsmPws7TNQVGhCZAOdOAX7XVMuBLCs0Ax55E+rl9js9rib28Q5tZ3
/3CwGi5dBWHFN7c/CE36u/UUcOpszUGJHI6+Nb0S5zJmpw/yWiF8CRAuMiIq7MA=
=BZjE
-----END PGP SIGNATURE-----

--oEj3/8+YnogYHQRs--
