From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Samsung: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 10:34:08 +0100
Message-ID: <20130503093408.GI4945@sirena.org.uk>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8858445884195331994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 502BA2652BD
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:34:24 +0200 (CEST)
In-Reply-To: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8858445884195331994==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 02:39:19PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Applied, thanks.

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4SNAAoJELSic+t+oim9SrMP/iaBxeug347tVGuqBbMQVSxX
dbcTWxr+waagf9Iy91Lkqtnvd4iNtrrXFeKPg+HzuTSVy5BLm9PAT5PX6reahkwF
xyMYVbsuYoHukFm3zfvmnOoMfiDaXwXJvWGmPgpcXTODrlZ0DBu0QrfMNJ3WN5pB
bX4OEaSH4d63H5pbv3nV8ydgIenuY7T/UkY+Y3dv87OBTjs+84aNcAyFjqitxRrx
tb7FXzX3TZyXrr+cc6NG3BgsHdLmpx239044z85UJ3IY8G/6mgODSHik6ARSZyv+
TdQbTyyn31zgxuN24f/TgDaJztN0WvgE54MkZQb2xTyXu+g2wh6k5Gfubjh7CIWx
nTgl/kTFqfOAZY9Ov8ffyuxuQ4upsaUXSnIqqT4GLDMS9RyOVti4tvhL0ynb4zvN
KpRDel61FnQUPIKFE1qPj0wPbEGc84isIQcmVDp/ggP7YUZHuZHH0xk/KlLm6SsU
YVUQhNelDqMQTd78UoHkva5pZRVbHP64Gd5xzphzYG5cy7JiTrTfZaKhRY4mntE7
RakngS4i0p3XyR1O+T7zmwgE32d/a4Z7mz3CDOSJuYPQZ+xpzQNqX60+7uxyyhlv
bVdBr+NPwG+Lt7P4JhMeNa5bNI39rcctt3dGIxLOeVBenPI05ezYyjeSQs4Sk3hz
LomMH4xs4jcoOnu6X1BJ
=tlt8
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--

--===============8858445884195331994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8858445884195331994==--
