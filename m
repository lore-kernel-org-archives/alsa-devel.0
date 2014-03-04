From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue, 4 Mar 2014 18:11:35 +0800
Message-ID: <20140304101135.GJ13126@sirena.org.uk>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
 <53159AD0.5000800@metafoo.de>
 <20140304092723.GH13126@sirena.org.uk>
 <5315A0CB.1020300@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0733349794484945701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED80F26575A
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 11:11:48 +0100 (CET)
In-Reply-To: <5315A0CB.1020300@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0733349794484945701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 10:45:47AM +0100, Lars-Peter Clausen wrote:

> Yea, but we are not in a hurry. My plan was to get all the small

YM "yes".  :)

> independent driver cleanups necessary for componetization merged for
> 3.15 and then for 3.16 do the componetnization in the ASoC core.

I'm keen to avoid getting lots of people sitting on unmerged patches,
it's a risk source due to interaction issues. =20

> So what the patchset does is add a regmap pointer to the component
> struct. For now it also adds
> snd_soc_component_{read,write,update_bits,
> update_bits_async} wrapper functions which have the same signature
> as the matching regmap function. Internally it does check if the
> regmap field of the component is set, if yes, just forwards the call
> to the matching regmap function. If not it falls back to the read,
> write callbacks setup by CODEC or platform drivers. Once every
> driver has been converted to regmap we can remove the fallback and
> make the function static inline.

Yes, that's what I'd expect and roughly what I was suggesting doing
anyway inside the existing implementation (ie, not the new function
but making the edit inside the existing functions).

I'm not sure I like the _component_ naming since it's getting a bit
verbose, but on the other hand it probably should only be the core=20
using this stuff (the drivers ought to be able to find their own
regmaps, or at least doing the same lookup) so probably it doesn't
matter terribly much.

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFabUAAoJELSic+t+oim95xQP/0gvw5lTNxw+3gBfyIX3oMp1
QlmmFbrYycdaLoxRitlwnQbMDnOLS9ZcNfWvsNNvILOjVg3uWpBYk54la2ldvgXD
5uM+SUMKVT4kRmBec9BFRUaJsQU1zFaO6WaVpJw9WefCcM7L/KQmfxWbvt1C+5/Y
0EQzP1e+rM4FNJBoKVIS8TSvlUVDkjI7vIIeK+DR8Zqe67C3en9qnAwBXZR9mwR2
ZaS6CHoXcM/x9SnMJrAWkpDpaSAIod9fHH6OyqBkCZa7x8riJhymUWl/5T9KsMuc
IJvvruZuC99EPYCvaX7ULqfM4VTRM09THS6BfZaB5baLX0vtnwEePGv9JeQFfiri
TGYzFNEm0ERFB5wqjXBbAmajjHWbGkaJ/Zerq5KzYOFzhus4Zd/IPOniCT0pnO0I
wpsquCu8H8/THbF3GzaQbt75oLEIGTlYKvLfy3kxgmC+rI9nGsRuSfuoa4gPv50A
xRc1k3pMR0UAiYHR4A0lxG7VfY8E0pDW5hFh1fVYPMXqAEryRnv8GBnSt5CxPDf9
w/rT7VDkwF2DACjOuDIyajWms0/5LlTU3gdovzspS3xF5EMJeoXWJr+KDmnTKtuW
Ph5PstmbofaLypwTcyyjpZPTo2VU4tHIPBcweVOVLUj6C5qy+LJjvNUvEYQG1xKZ
+eki8VqCbI6r1RDkKtOp
=lfM1
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--

--===============0733349794484945701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0733349794484945701==--
