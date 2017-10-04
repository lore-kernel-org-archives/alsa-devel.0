From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: img-i2s-in: Add runtime PM
Date: Wed, 4 Oct 2017 11:38:12 +0100
Message-ID: <20171004103812.vma6qmbfncnskhdw@sirena.co.uk>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
 <1506938333-550-3-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0259900604238159828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A77F266B20
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 12:38:14 +0200 (CEST)
In-Reply-To: <1506938333-550-3-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0259900604238159828==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="crwfxmehsli4a7bz"
Content-Disposition: inline


--crwfxmehsli4a7bz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2017 at 10:58:53AM +0100, Ed Blake wrote:

> +	pm_runtime_get_sync(i2s->dev);

There is no error checking here, you shouldn't just ignore the error.

--crwfxmehsli4a7bz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnUuhQACgkQJNaLcl1U
h9DJ/wf/ZoQsNDuCmhM7ibCWCFvZBWC2wF95NGkH3csa1h0u4EniYg1FrwQxZ2t+
CRlKZJpV4arVheWULhtPnWRgBWg6r37RS2fcC9NIByQlWCtd/UZ2Lihmh9rpJW9J
3O8l0iT01VyhjZEFskmlkb+d8Z2ZWpFbqeAZkvqqP9PRF2cn2aOkC7ZhhvaqGpF3
TYpCn5WyrT8an+5jKMqJLD/niaOkg/0zASwy9wm2fOFBe+WUGhin0Mr78SwLTOF5
54Qp9guCP3Hs3a43HePhT7A/7Bg/ge6RcEzo+Boz3Rahr3QE2DL8Y4+AVuenEsoB
e/mfo6WkUlcGOsrVVZwDj1a+t0J3ag==
=bPY9
-----END PGP SIGNATURE-----

--crwfxmehsli4a7bz--

--===============0259900604238159828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0259900604238159828==--
