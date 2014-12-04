From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Augment existing card DAPM routes in
 snd_soc_of_parse_audio_routing
Date: Thu, 4 Dec 2014 22:40:33 +0000
Message-ID: <20141204224033.GA11764@sirena.org.uk>
References: <1417122162-8122-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2399775774910823256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DB6260440
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 23:40:46 +0100 (CET)
In-Reply-To: <1417122162-8122-1-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2399775774910823256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 10:02:42PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>=20
> If a snd_soc_card has any DAPM routes when it calls
> snd_soc_of_parse_audio_routing, those are clobbered without this change.

Applied, thanks.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOLgAAoJECTWi3JdVIfQadgH/Ai1BfqxhLKxGP30YZKWYsyf
K2bhZgCRxkeqiT0wJ4YGbS2jICu5We5Yfqym/sUQfpUoeUsUv/IYIiQ5ysnJD1uY
JuojkpbanP08vpuQnWRbtF+Rfy8OZZTeMVLHEFTGQoKg3f69kDI2zJPgJFfJj8YT
6S4rZMHxV086XytpLsOj6ARFSH8q+B+IDuzVhQmpc6qX/LF+vkR0t2Mc+h7Xgx2M
voRmApbUPddYawLa9c3ykXAGgAzyPLg7LVOmVtcW+Hl4Iz9cxNkh3L11B0UJ+tEL
w2NyGcSJ9X/zvZoRlR+Dist5++uqvCQRgj+9w2TDczNTdN/zKfJoapwokNElDDk=
=9w5l
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============2399775774910823256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2399775774910823256==--
