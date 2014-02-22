From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: wm8993: Remove unused pointer in wm8993_remove()
Date: Sat, 22 Feb 2014 16:00:16 +0100
Message-ID: <20140222160016.372a3683@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/PgqqabPoqGeDFBsi337eJmh"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--Sig_/PgqqabPoqGeDFBsi337eJmh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Commit 88b5bdfd (ASoC: wm8993: drop regulator_bulk_free of devm_ allocated
data) eliminated the last user of driver data pointer 'wm8993' in function
wm8993_remove() - Thus remove it. Detected by Coverity: CID 1186208.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Applies against branch for-next in tree
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
---
 sound/soc/codecs/wm8993.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 2ee23a3..f7978b3 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1559,8 +1559,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
=20
 static int wm8993_remove(struct snd_soc_codec *codec)
 {
-	struct wm8993_priv *wm8993 =3D snd_soc_codec_get_drvdata(codec);
-
 	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
--=20
1.8.3.2

--Sig_/PgqqabPoqGeDFBsi337eJmh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTCLuAAAoJEKssnEpaPQKEgJoQAJiyVGX3Wa2n7PKRFsQBOTn6
wDcW/IqrglJX2Z4JEjmMXg+hkp/McS0yad6wel7zs0AdhrmwCii3GAwWCXh+kZes
f+GZSOdhReYHcc9p8xrYBT2d/aOQJpM0swyh45f6VtQ4rKsfLm2dQy58tezE/oeP
ZF4MJxtDTpr8u5MBHQx1dfm4fNYWM/kFBrRwglJXS2cubIP0pYoeWpWrtiWODYaC
CpRgmUuSwkTZ8H3ahm5JckjiaCNNbByihsTmXPn1bnGX7XZFPRK86zsekqThoR9M
J5nuv1q+DR6B0VsvVm1dPUHlTeqbJ/2I0iHxdOkM3ygB60CyVJOnFOLYuaUd5bOS
6wNcXIVZnUhc+zXYLVpT8W7n6l7SDR4DyTZVOmk+OvLPLKfnXLCFRm1fg9AVW92W
DuTgTqb37MxqcbOikpUDm8b5drCLEZvO7utszBG4OSgIT5YFc72kBj4WLnWSlbCl
MVF7iuCRvCTXmNsEk9gO/M2d5PutBsBdndGqnlrRk9cqNJLvxbh6srac35Wwaz9R
QkS2zBuphiIrCllFiCfDVpJi9V9GKN1/sjfk+fePtb+c46GOfwrngYRjPv6h/AWF
o2Jic3p4Q/p+B4hObs3aq3UA9inrtZKEZMYlrYp37JG0l+mmaCYmQria0wynBeHp
4nmQcuYpvHQfTTaQHSa/
=vnzG
-----END PGP SIGNATURE-----

--Sig_/PgqqabPoqGeDFBsi337eJmh--
