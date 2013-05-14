From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Move
 snd_soc_set_runtime_hwparams() to soc-pcm.c
Date: Tue, 14 May 2013 16:53:13 +0400
Message-ID: <20130514125313.GB20930@sirena.org.uk>
References: <1368522332-15624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3619695285409886368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D09402650A0
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 14:53:18 +0200 (CEST)
In-Reply-To: <1368522332-15624-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3619695285409886368==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 11:05:30AM +0200, Lars-Peter Clausen wrote:
> snd_soc_set_runtime_hwparams() is the only PCM related function that lives in
> soc-core.c. All other PCM related functions live in soc-pcm.c, so move
> snd_soc_set_runtime_hwparams() over as well for a bit more consistency.

Applied all, thanks.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkjOwAAoJELSic+t+oim96a4P/2Tc5ISl5Pu+h318/isBVO6T
vDHLh+prKI2oN0x1v+qmv7QTxFfgu8uAmt8vPYut0+pajBCw6xOuzKqqB9AtF2Ow
cy0M+m8F7Hbjfx7e5JhS2XX2+rOMbl72BSJhD9bsYlt6TOJUMa74YXXW0YObIEX9
+NoDDUG2CgFwYdXxJXHe8Ye/Routex0PPewQXkZvX2+Aj+Xs0xhj8x40A3XHZjvL
+lYmt8fNDvh8xwBabCH19lktRCnpR4MvR3gDyOUisEGnLnqSrshsNmf+246cLYNp
5MyJjYOwHtaXaNpLPdliCPDhOoH6SU9SuCI09FkjecfIQCpUXsHiZcU7TVdkPcWZ
mffPicc3sTrG80UyUIoEvbSLmVQ53Zv/l5v0ZwUuM3RbBZ578AraQxQWnhWvPKLG
5clyZ/BuOYnF5VMux0/p1bTWe/Be/uQniBxdDXMeZIz3g0OKV9342zL5tN2G9PY1
zGFJancsIUwRWb7Mr1dwp/dV28FQJjAn5r7pwMvNsDI7lrfP+R+xT4Zp6Pyu6UIB
gisOjEU85n1j0pzIhNcgMMSvCJ/ZzDkaUMXHECJ+pB1E/KEzn08N4DV6etRBxc5N
bUsuM8XQb7VbzqFZ/GD6UXi+oxIj7+KImuO+xMgZBCeGqrn8DFlAIbchh/YlHM95
QGRL9DpY2FS82k8zMzLa
=pf71
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

--===============3619695285409886368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3619695285409886368==--
