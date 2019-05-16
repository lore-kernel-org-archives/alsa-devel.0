From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] ASoC: cs42xx8: Add regcache mask dirty
Date: Thu, 16 May 2019 06:04:29 +0000
Message-ID: <e6fb6598dd863b74241e10d14652d12fe701845d.1557986478.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <A4BAEF50433E494E9F020FFAEEF925DD@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Add regcache_mark_dirty before regcache_sync for power
of codec may be lost at suspend, then all the register
need to be reconfigured.

Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver
support for CS42448/CS42888")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/cs42xx8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index ebb9e0cf8364..28a4ac36c4f8 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -558,6 +558,7 @@ static int cs42xx8_runtime_resume(struct device *dev)
 	msleep(5);
=20
 	regcache_cache_only(cs42xx8->regmap, false);
+	regcache_mark_dirty(cs42xx8->regmap);
=20
 	ret =3D regcache_sync(cs42xx8->regmap);
 	if (ret) {
--=20
2.21.0
