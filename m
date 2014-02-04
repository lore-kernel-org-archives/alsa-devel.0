From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] SoC: wm8991: Remove unused pointer in
	wm8991_probe()
Date: Tue, 4 Feb 2014 21:20:59 +0100
Message-ID: <20140204212059.51b9a904@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3292832311488429200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE89261A8B
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 21:21:06 +0100 (CET)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx101) with ESMTPSA
 (Nemesis) id 0MSq5p-1VlB1L0Uzd-00Rt92 for
 <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 21:21:06 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3292832311488429200==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/wpJtFXc=o+fQ.qk/auEHGvl"; protocol="application/pgp-signature"

--Sig_/wpJtFXc=o+fQ.qk/auEHGvl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove unused pointer 'wm8991' in function wm8991_probe(). The last user
vanished with a86652e5 (ASoC: wm8991: Convert to direct regmap API usage)

Detected by Coverity: CID 1162831

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 sound/soc/codecs/wm8991.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index dba0306..244eb09 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1251,11 +1251,8 @@ static int wm8991_remove(struct snd_soc_codec *codec)
=20
 static int wm8991_probe(struct snd_soc_codec *codec)
 {
-	struct wm8991_priv *wm8991;
 	int ret;
=20
-	wm8991 =3D snd_soc_codec_get_drvdata(codec);
-
 	ret =3D snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
--=20
1.8.3.2

--Sig_/wpJtFXc=o+fQ.qk/auEHGvl
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS8UurAAoJEKssnEpaPQKEd5QP/1DMoAb9+plYuczhElZad6OU
ktfhvDPOj4rMZNplp2nBCVLmxSoTKTKFX6aDpMzJj06n50KRF6dABSVTqPw5C1W6
p/ZEA83QnUJcJoDEd5TcB6lxx3nEuI/2Yo1MHc36ZffqfBWVB5ak+tetgtQuB5j/
O5MB7t3QiPEfhfDuJxfF0LRZOKMdfBiADT3yNygcflfx/TbNlFIXwJK7C5T4wQNJ
Ow9kbqeWSONkNeOj+5g4rPwq/FOU+HWahOS4RnOmmLfVBmL/K9arnVL1Dv67CRYM
SpOsaUfsxUXXrIUO5+NuaI14gs5LPfzzUnk3dbFg/Amk3ykIL68Df/ygJFKfiEVV
lqWXGq+n+wCdrWrMHggNpsCTXcY3PQf3Np+4KGaW0SClrCqjWYHPppQkMFKb20Sa
vawVPJYljA72RF/X5vWMHqr3576b9iomjsKobtJov1GAPaI4I8kkXN/dOjaqgow+
iHl0bm4D3c3Mk0iOLkziohKulXpvC0u0BjE3klfap1WV1OIg7Qtihp0v8KMkkwCQ
F7VerXnM8BbddBiGo7h7dFJs+CHaGVUGsqkOEKR2180BGwgpCvVElrm9QrunfKnK
Wy/L5BzgYK8sZMSyx+3F5AMF6M+JFX0TJnJ3Z6Kv8V7OCHZeEYjbBGXz5XXUKg6v
zI1WClI6lcPL5zT1MAp+
=3U/G
-----END PGP SIGNATURE-----

--Sig_/wpJtFXc=o+fQ.qk/auEHGvl--

--===============3292832311488429200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3292832311488429200==--
