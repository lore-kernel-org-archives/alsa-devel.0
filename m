From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/19] ASoC: Intel: mfld_pcm: move stream
 handling to dai_ops
Date: Sat, 21 Jun 2014 11:43:01 +0100
Message-ID: <20140621104301.GC5099@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7124850105695161884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E612E265141
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:43:15 +0200 (CEST)
In-Reply-To: <1402662848-24534-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7124850105695161884==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FqaIGMzVeQkeDzz8"
Content-Disposition: inline


--FqaIGMzVeQkeDzz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 06:03:51PM +0530, Vinod Koul wrote:
> This helps us to handle pcm and compress ops seperately and per dai

Applied, thanks.

--FqaIGMzVeQkeDzz8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpWGyAAoJELSic+t+oim9M+4P/jC8emnBCtT0lFpFBqIKoqqE
eb9WjwPrOfQuJm1Vp1Ijj9vOAG4S/m05YhHwjLk9xI4u3SgVST2znWIO6PGpZ3hC
mh4TngqKUoaBjrZqCMAzJKXJrsQGdXAi6R7FziNQOl0jHrRgqhaUhzGaxgICdCEN
1hb6LM1o4Hwe5fMub4hBqxbbjBreGnzpdDrOrVp5GVUSbkjl+GfUYZsUdr/toJcS
sqsp1HmaX2UfRCqvJ4DtwwmKxFxHoDQWlGH65QQRUkxUz+N+jYmdyyJzuPD31Dg9
HE7wUSPXrriWn6uuM/pEVBwgvMzVxxkzm0SsJFRsFGcT2Onebrv2DVNM2Z/Pejo3
65eOuUciKY8u0jiZ0qWfR2AYiXSUPHy7pQoD2JqdhpK7LZ5Q22SKC1JntR1lcOiS
GwLD/nx0uMlhDgWnZSoGaIWmBbhCXdn1EBdjFDbsG32mXQ5XzGhfwE0KsKvexxNa
AjdvRovYNF/HcG7iCGqUlRe96Veh5LCtXxcqQa7ycAjA+yyQZbwx+20yKsrk95S9
cX6aj6I4LQ5iPgo6JF94w7U8Wf4pGYg0PeCVcMGrxlwgr3FhhygQGaDEyfTiuSMb
SLxySuRx2jC9k9MpY6rKQMO+LUJZxgNBDbsG3yJs1qEEFGLlb5708Sv4PjOVldLM
17YD4u8q/bETnXivs3Xw
=+udI
-----END PGP SIGNATURE-----

--FqaIGMzVeQkeDzz8--

--===============7124850105695161884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7124850105695161884==--
