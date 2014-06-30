From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4265: Change return values to
	boolean.
Date: Mon, 30 Jun 2014 11:12:22 +0100
Message-ID: <20140630101222.GW23300@sirena.org.uk>
References: <1403973265-19787-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2602963794086970631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF6882608E8
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:12:40 +0200 (CEST)
In-Reply-To: <1403973265-19787-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: alsa-devel@alsa-project.org, brian.austin@cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2602963794086970631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Stxnv0JS2q2nyCF"
Content-Disposition: inline


--2Stxnv0JS2q2nyCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 28, 2014 at 11:34:25AM -0500, Paul Handrigan wrote:
> The cs4265_volatile_register reutrns a bool. The function now returns
> true or false vs 1 and 0.

Applied, thanks.

--2Stxnv0JS2q2nyCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsTgDAAoJELSic+t+oim93LMQAIpUWDcCHi5kGQEolwdseZp0
6L/lqGT4zkuNvA8au8p7z0/DRysMjAYu3+fgdfU2ZkIxzS/ZU97NT2QCWsum9x+X
IHg0rqi4SuIfG/eCHt+b0c3j+T1mxubGZm3leHZGOczgjR1Om8NH9PLSGb6MeSBu
pmvmBICdjWI/eUKX+v6WDYV2GGHuwcuQ07COdkLwlU3TW96Ft0CNGHrXwMd4qWzj
ZubLAGU2m7Yvr3hE+m5kPZYOBKgIV5410N6gOgUNln3H0qWEtn5k7Gxhgvw3UiH0
z3rOBqqWaY4RcvwFBGRmp2oiN4H7OPTjdFBkwXxj1R02407xShzWRSf51P2DvMkf
Ly41sy1WpQojwDMRdWO3cGJFa+soEcZdbbd0E6h7DjkOGEj2hEJ/apaSqSqseRWh
c9wwI8w0XEtkFbW1ps/cMlojT3jHmLbudCmMXjQNRNe56JFIz7Oq3jain6K11tvh
LmXOO6ynOg7Kph2i1XQ+5DQwMysNlD49CkSyE2gD9Uj8/T4DcPHORrE5+96M3Fey
wYFbivgZLj5RcyjVo6+SQL86RLYJX/5dex6JXgmHHOLMCPQf9JeN5ys20jUGigcI
kAWfWZXij0WTFjBLB5+6ju2/l1x+KwjNK/Xlgn+aOmEtQYHAcUDWdg1oalSPb98L
oiImgJlvO6JjbPAlaCQ5
=kVMX
-----END PGP SIGNATURE-----

--2Stxnv0JS2q2nyCF--

--===============2602963794086970631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2602963794086970631==--
