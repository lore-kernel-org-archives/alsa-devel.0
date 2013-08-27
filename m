From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 9/9] ALSA: compress: use rate values for
 passing sampling rates
Date: Tue, 27 Aug 2013 18:56:41 +0530
Message-ID: <20130827132641.GC2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-10-git-send-email-vinod.koul@intel.com>
 <20130827132959.GI10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1701574738934355856=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B78EB260856
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:11:43 +0200 (CEST)
In-Reply-To: <20130827132959.GI10783@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1701574738934355856==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 02:29:59PM +0100, Mark Brown wrote:
> On Tue, Aug 27, 2013 at 12:10:39PM +0530, Vinod Koul wrote:
> > Clarify that its better to use the rate values like 8000, 12000, 11025,=
 44100,
> > 48000 etc to send sampling rate values to driver. The changes kernel AB=
I but no
> > drivers exist upstream so okay to change now
> > Tinycompress to be fixed as well
>=20
> > - * @sampling_rate: sampling rate of audio
> > + * @sampling_rate: sampling rate value of audio,  eg 12000, 48000
>=20
> It's not clear why this is a change in the ABI - the values written and
> the types don't change.  Personally I'd not change the ABI - it's a bit
> late now that the code has been in the kernel for several releases.
the problem is the meaning of sampling_rate. It was SND_PCM_RATE_XXX. It wa=
s a
lack of foresight on my side, we should have done values which we are chang=
ing
now to handle rates not defined here.

But since none of drivers are upstream, impact is IMO managble. I was plann=
ing
to communicate this along with tinycompress fixes to all folks who i know a=
re
using this :)

~Vinod
--=20

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSHKkRAAoJEHwUBw8lI4NHWjsP/25LPLqYOlnfRgNnnw/R9kgx
B+T+KQ/pBw8BuyMjMtWie71vR8ZDW4He0wnxrWQnLUOqQJFSNDJPrK8wUaSFSWI8
PKKXwFSRXsIipXqaWXBwgGrtPuwdeP0+e6T369CSgtZ/eRP/dxT13FvL76yRc8G+
zl0k+2M50tx0ul5cXW+CQIPAb+2Hv79sUF9J89mlebfR2s2UZ4BO8gVfZpXYSM/R
yvs7qPDgC/ad6AVIt3Ja6qzCxIKPI05xCICk1KtuDFNRi4V97B41s9ux0ZXWahxG
EArq8/H9CFyurAUz0nD4LJ6dlv/fdkFXYKcQu9Txtp1DBpKFl6U+oD4XfKFYo+tO
HFCfKQqoCFw17jCu5bcYclcOz4OUzkia1JzluHzEwrQZhnzvAIZh62yiFh6yBwZI
TdSyMwZ5FkQ3dsBq9q/tXSn9LqNGCNgjUzJDT/z26bUhSRkA4BL6dX+yWAsIxL+p
NUq5Ln+bs/yH9jCL7bour3ym8qY8//f5fmaBoUpTbUPEejtMG61lNCooUWvTFs3z
XTuBN/jS9OigoYhu2VF4I8pVQoD621InNnRUw4vyXKYakPnds2g23fSQJrS2quq+
01MJdKw5MjaeER/xaWA1TMY1d55ugo1yj1W1c4i8NKpaEt5t/OJGTIG8j6BQ7697
jn/dk+U8iTnA1WPL2le5
=sPcC
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

--===============1701574738934355856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1701574738934355856==--
