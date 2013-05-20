From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ALSA: pxa2xx-ac97: Remove redundant
 platform_set_drvdata()
Date: Mon, 20 May 2013 13:46:46 -0500
Message-ID: <20130520184646.GZ1627@sirena.org.uk>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8546055611916296600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B6F261AA0
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 19:27:15 +0200 (CEST)
In-Reply-To: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8546055611916296600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5iovQLtJQXc0+Hs"
Content-Disposition: inline


--q5iovQLtJQXc0+Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2013 at 02:08:34PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Always CC maintainers on patches...

--q5iovQLtJQXc0+Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRmm+TAAoJELSic+t+oim9gkIP/0YkHy5uRot4BorRHGvquUIs
Jdxm6R6Z0TWj1OZsPlVSR9XQgGRpX/XbldQIqjUlBplyU5/Sz+8e2HPRrTkjkOBF
waGXXLQRTvst/MxkxPLgX11mX8XR1BOPz4Zkk4o1Jqsp3nzhsYF+Ogf0/goCxbOR
JCxZkfXVIBwRtcKj7rEQldJiSKstXakwLqzOE0lwS/gpTnXG8KZbWoJEv47TTeov
7zPXcXWlcfrkVf1SqvxT5rba4oqREgEbuIwEYqJQfMfE0ANB3L2biU+V4UXh0L3c
xO9OBAzsGY62sknSBBx04Z/o+OO1rMK6atfwI/aZdXrxDSLXnT9iB/Odd+1xh6Lh
9h7ccqWdAA72Nahaf8obUBhDfBFxeM1xY55KyrxT8bb35jsK+f5huCkzGfLpeL2a
INBOWvOW4jEumsZJ1iq8N+5a581q8BZ9fBHeCSKn07t/oqifYQcKvCr+meNVqUlb
TISb8wE+uZrXbqOfDvUgCOCgyA0fH00m30i7JWMWrStpb/FSI/nN867z9TIXvBSd
FY8JTqlFMqrsPB7MaSP0UfLa+EDVNRcN9IeDr3UHgxJMtXhuX78yRMgYlbPyTWk5
5j4k3IY8oZT2MIcSMeB0A45xBV+fKeyBaBacysfDJG7kBb0l/JJxtuZzW4GU4oLw
vLtJj7CnvBnQsNA6pIs5
=B1rq
-----END PGP SIGNATURE-----

--q5iovQLtJQXc0+Hs--

--===============8546055611916296600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8546055611916296600==--
