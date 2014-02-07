From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: wm8995: Remove unused pointer in
	hp_supply_event()
Date: Fri, 7 Feb 2014 23:37:16 +0100
Message-ID: <20140207233716.394de04b@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6532629168528135764=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id CAFC12654C7
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 23:37:17 +0100 (CET)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx101) with ESMTPSA
 (Nemesis) id 0MfAog-1Vsc6Q2Ask-00Os4V for
 <alsa-devel@alsa-project.org>; Fri, 07 Feb 2014 23:37:17 +0100
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============6532629168528135764==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/znhD/4_BKyy9.5LGNlxDS9C"; protocol="application/pgp-signature"

--Sig_/znhD/4_BKyy9.5LGNlxDS9C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove unused driver data pointer 'wm8995' in function hp_supply_event().

Detected by Coverity: CID 141181.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Applies against v3.14-rc1 as well as branch for-next in tree
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
---
 sound/soc/codecs/wm8995.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 4300caf..403e1db 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -561,10 +561,8 @@ static int hp_supply_event(struct snd_soc_dapm_widget =
*w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec;
-	struct wm8995_priv *wm8995;
=20
 	codec =3D w->codec;
-	wm8995 =3D snd_soc_codec_get_drvdata(codec);
=20
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
--=20
1.8.3.2

--Sig_/znhD/4_BKyy9.5LGNlxDS9C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIbBAEBAgAGBQJS9WAcAAoJEKssnEpaPQKEWosP+KQeScVd/ktHR3VzwQeNYDoD
aJ6HZQMOHslkelnpD4GJZkv+s0xf06ywhPf2+G3l6ACm+35b7Wj6INE2C7Tz4Z5Q
q54+k1kKoIzey8LVsSV7QJLUdibpVUXV/JlqBbI56rgOQPhXw5KGyTnLfWw/BjJv
MK7vQJ6DwpyNcfvXgqnpoNJ6xgw8yRnADc0aapfjoA5ppWsoqJgFKGWugEv74jyK
egf6oFP8lDkdBXzyPasqC+lJ93skNQm7Ox788Y+5QvHz9yolvm6KcaBqiPzkse6M
8JCaO4QPf67+s+T1/7d2StyM3+LsTbGKcp+R8UXfNG/FLHOlUXyo1Y2KBKAJoY3I
A8Uw8/8lWNhpga8LRdkcAGKs4Bl4f6yjUh1evvmCNs4CIVOYG5w1vFG7+ieH0BWG
HKQ//915M1wn2dnTHNWJwvzoqU6ost5GveBA0k+X0/3ijBsFbavamP0wWz8lsnbk
J6LYA7HHS0pvc2SQlD3b2gs6/gFKUJbVHpp4M3Hcs4MEqVAbO42LSmMkeJQ4wcsf
v/W6tR9UbPJnTyXJZ+XcnMT2a2DdJtJgiDgqnIbOjl4LY6pLPjcgwegg/nvX34Or
bGcSbf6oFi8fJXjs8yTh4jiaJMxbIgAh8NvHrDKZ1FKz7zyMfkTSI6rf4nHSa5ut
dDer6+mNqgAcNxo0wd4=
=RIUp
-----END PGP SIGNATURE-----

--Sig_/znhD/4_BKyy9.5LGNlxDS9C--

--===============6532629168528135764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6532629168528135764==--
