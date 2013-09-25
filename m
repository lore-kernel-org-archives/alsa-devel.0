From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Wed, 25 Sep 2013 12:31:03 +0100
Message-ID: <20130925113103.GN3226@sirena.org.uk>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4344344248016511054=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DA1F26535C
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 13:31:06 +0200 (CEST)
In-Reply-To: <20130925111954.GG5132@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4344344248016511054==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2013 at 12:19:54PM +0100, Lee Jones wrote:

> I assume this is okay to go in via the MFD tree.

> I've applied it until you say otherwise.

Can you please put it on a branch I can pull into ASoC in case we manage
to get rid of all the other users this cycle?

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQsl0AAoJELSic+t+oim9ZtIP/1I6ytcttm8Vceu5BU8ZbDCn
CLqVG04DCEP0fcKivqZph+5vxLgCzGJ/adZKi3EDgDiyOgMKsDHLvBHPg2KTcFci
YMlVHyBYOIvDhYrUTR9Ib5LmJl/JXy7m1N8yUMOJRvA+iakkSEvCfvqAxYu3Nofp
+JXKXINcij9kSt0DBLMTRU8qia9n7Kt8pKRLHXIyxWXzKQCim+6P0M4mzO+r1Lnk
uoVDUPqYeS3OG15ru8O9AWZFi9sCJiIf1+KllbYzce4B2l++/8b34LGt83zctilV
7FjLNxkxccof5itlm3cHyyaJejiUuoWmrPdp6yUR8AxdH4cs5jF0wgkicN8tCVkA
t8kTfC1ErtF7TN1ng5w7K9Hw2nOTjI0Lhxnmy2/om9TGjV9LJMSd2S/QjeqTLIrb
wMQ9YD6xV6a7pEYdR1p1tDZJprHgYgKDzyl/I/TwMFP0F3/uhP6YRqI4h6Pm3EJl
oG9sQbBzf4CPTS3RY/02vaDcgx5rGfVkgJ58a7lPOx054qMTghojGWUJZ2ATGY+S
qnJDtWQyx2K/mYWqccRNhE4DIdHsRkwgp3Kk5xuHtmpi0LEWnfKDHh9Rw4XPPxxX
IvGUxeNm8mIra76dCjXyigpB9rbE2KmK/gT3uWb8UuA2PkotN7VaI8k43QhpK+H3
a+eOROx2FRAcdRUrZUbF
=MCe5
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--

--===============4344344248016511054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4344344248016511054==--
