From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: add support for
	suspend and resume
Date: Thu, 3 Oct 2013 14:22:55 +0100
Message-ID: <20131003132255.GQ27287@sirena.org.uk>
References: <1380631802-19498-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3489069352031635451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C00C260895
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 15:23:01 +0200 (CEST)
In-Reply-To: <1380631802-19498-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: marek.belisko@gmail.com, alsa-devel@alsa-project.org, s.neumann@raumfeld.com, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3489069352031635451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXoUnAu9pZeaHebo"
Content-Disposition: inline


--jXoUnAu9pZeaHebo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2013 at 02:50:02PM +0200, Daniel Mack wrote:
> When the system returns from suspend, it looses its configuration. Most
> of it is restored by running a normal audio stream startup, but the DAI
> format is left unset as that's configured on the audio device creation.

Applied, thanks.

--jXoUnAu9pZeaHebo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTW+sAAoJELSic+t+oim9OW0P/0ax17QqImWp/1pITmYlsTC5
i9u6qlGYyZxfBnbCye3wlcnmncT1j+vcYDGZYNtj9KzodTuuX7eWQpM/6cBHFx/E
6KbrKWWkSJJkntdn/Mfg2HjWqw85axkxlXL8Q16Ziun+fUKx5cF0S8o5OWslF+fu
xmcrLZoC8m8vLaq/keYu8QcbFAmuuRcsVUL+d6N3AjfBu4U5cI4S8gGIlED8XAB3
+MgKsG6m3sT4eRIwVZ1JW6ehXbMO/iAOnF+lCjXd7FwCRrNVHmdl1JIwN+z/PeAo
kgnWGJq1oZFbgfsnuSAL6xvUI583MgvFOC39Gr8CinWCIfjIl+rgbPYJ7+kzhviA
0m0Ka7T4ISZSuHLcA3br8DKKZxtjxvqPV7yczOi9ji7kUB+GJcH8E8qrP5QJYP6g
XYXxbl2si0IHBONGw1SvECs4boT7E8LjTEFgvWB9wEPdR5d5RKSYM9Np11mYo8DF
BvL8TrICD79XLVDR7MT1TXkjQfQGcEy9RyYxdFnWLP+3DL6HgERJfCNovePNDe5l
jjOWOtF1HaNG8jv5jWE5ku4yS39YSU4btg4Cb+DLq9IXcmKnzWFj8A76kSKzzfa7
+G5Po+eOwr+tWatnq7sWNiBXg64BFof5e0Mj33NQfP1YeRECqKXrifSmHMjwh3YY
ce3MYBQrlznZLgfI+n0I
=vmOu
-----END PGP SIGNATURE-----

--jXoUnAu9pZeaHebo--

--===============3489069352031635451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3489069352031635451==--
