From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH v2] ASoC: wm8991: Remove unused pointer in
	wm8991_probe()
Date: Fri, 7 Feb 2014 19:43:19 +0100
Message-ID: <20140207194319.74f6099f@spike>
References: <20140204212059.51b9a904@spike>
 <20140207133948.GO32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6113232290181801569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B6F5265454
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 19:43:25 +0100 (CET)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx101) with ESMTPSA
 (Nemesis) id 0MNdxu-1WAClq3nII-007CUB for
 <alsa-devel@alsa-project.org>; Fri, 07 Feb 2014 19:43:25 +0100
In-Reply-To: <20140207133948.GO32298@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Graeme.Gregory@wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--===============6113232290181801569==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/67kUxzQFJ5HV.lL0gPoyHK8"; protocol="application/pgp-signature"

--Sig_/67kUxzQFJ5HV.lL0gPoyHK8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove unused pointer 'wm8991' in function wm8991_probe(). The last user
vanished with a86652e5 (ASoC: wm8991: Convert to direct regmap API usage)

Detected by Coverity: CID 1162831

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
v2: Resend after input by Mark Brown

   * Added ASoC maintainer CC.
   * Added driver maintainer CC.
   * Verified that the patch applies against v3.14-rc1 as well as branch
     for-next in git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
   * Fixed a typo in the summary phrase.
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

--Sig_/67kUxzQFJ5HV.lL0gPoyHK8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS9SlHAAoJEKssnEpaPQKE+SoQAKX49SWErWPau6fUXfAs9PJ9
qYTTS9TrhGlW4O0Y1tENDw6N60xGqi7qUTprIJSL0iUMUlL/ImYxc3PddyEXCH+j
BaQg/JwkltCWvkOMCZLaQRFAQM+uY15kOcLBPyUPesbGEfKQTrh/p/daogWG1LYO
dh6B7EJ/OUhIKBYfgQV4zveB0PY69tXpBfg1vo4kkRwT2gmr1W2Stybu2STIYYr+
6ZKxvwpjCyBRVCbUsp7/IV5PeCHgermfhGOEv845TOnd7XYOObhgPC7B9dmqfs+7
+LtKjYefxq4/LRicbqoQE8I57a+ovJQL+FL5BXHuuu5RbxQTyUHH/rQCmdL+xOQu
eJWkg9zuIv7KEql/I2Jbz/EOQZ0tk+Lo7pN+8Rv8xPBQCe/wEXAukpu515IgOr+Q
GaKV8lqZmEPg7vH14SX6lDx/3JOWnamypWpXQcjRpUd1gnj6meRoaWeD54ZN01ea
St5S1mKCahbrfCqVyVWGM3Do6/gAQQAVHRlor9tFbBNSYQpFUa6hjcHwi7suiAZK
YDToscf+MU26IEroUqDykzWA+0frOn60HcgK6gOpEIocQjltVqb75UmRd2M3xu4j
Qq371CWDWuPPVlpoM8fTHCnImWG8zbBDuwrT1BjxJI1o0q0g72m3syk0Dgwb84JY
bFeFJznkw5L4VE7Zqqfj
=akEX
-----END PGP SIGNATURE-----

--Sig_/67kUxzQFJ5HV.lL0gPoyHK8--

--===============6113232290181801569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6113232290181801569==--
