From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: fsl_ssi: Use devm_ functions
Date: Wed, 17 Jul 2013 11:05:11 +0100
Message-ID: <20130717100511.GI22506@sirena.org.uk>
References: <1374037239-16984-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7803616335972487194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BF7B7265375
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 12:05:19 +0200 (CEST)
In-Reply-To: <1374037239-16984-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7803616335972487194==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rG+KBTClKkGekJUE"
Content-Disposition: inline


--rG+KBTClKkGekJUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2013 at 02:00:38AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_ functions can make the code cleaner and smaller.

Applied both, thanks (assuming Timur is still in the process of moving
here).

--rG+KBTClKkGekJUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5mxUAAoJELSic+t+oim9n7MP/1BRrwYm0HKFKV7s8HFAbJSc
7XobGFM8PPhASi3DU4TE0quhOWjj7Wzt72J7hScjGssBzXfkW44oKeC4eypShPy/
/jFW+V62SnSPw9V/uIjOg2ja0CUA8jNOTxXmiEzEHbLBe68ZInXYsebQG/YoFmON
pfALKKYO7b7J+JvlSCNflKenD2D/+QIBU2hOoEJrR1sIlE20tgVXU4414vcI/ppc
dJ9/+wdTxzKCcdoi7cOXykjvhWYu8sD6qF407vYyS+crF7F+CnSBiGyS+pJ+/bvD
vz28tSoktUwXVFVOmQ7OCyGePBf0FFe5/UynEyKj/jzLKiyggpI2TA8ejJJrfi2M
tJjHEWQVy3plq9TESzPVl2Iq6//rr8koxkItiR/PV8p8NVRUeqZiDMj99lxvM8YT
1AJ5V/U+YRUQCpUTAk3VhDf9vnpGqznRU8Kak3sO2pXam8KMGe/KjAm0+gUlqW6v
b57ycwnDPP+hxa1k+yy+tuLY1N4uThre4BaGgVRLQROpeO+ogx2oYEfseaPKa8XE
kwxPqnKrR7Ch3/Wcd3RRl7TXH6YTlqvGGK46Q9rHljX47h6Ho1jY72y+rDlAIlN7
bsgtJRrtnjUVkBPPtdk5DmqAz1v0QTKu3Ta8PYpAgbJVVxuYi/TZbAc50C3lorUl
qVQiIYcygxV3KrHuMVuc
=aMnP
-----END PGP SIGNATURE-----

--rG+KBTClKkGekJUE--

--===============7803616335972487194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7803616335972487194==--
