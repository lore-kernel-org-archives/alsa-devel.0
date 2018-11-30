From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [V3] ASoC: max98373: Added max98373_reset for stable amp reset
Date: Fri, 30 Nov 2018 03:21:09 +0000
Message-ID: <20181130031831.7813-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch added max98373_reset function to avoid amp software reset failur=
e and code duplication.
Reset verification step has been added for stable amp reset and it repeats =
verification maximum 3 times when it is failed.
Chip revision ID is available when the amp is in the idle state which means=
 software reset is completed well.
Additional 10ms delay was added for every retrial and maximum 30ms delay ca=
n be applied.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---

Changes since v2:
- Added commit message.
Changes since v1:
- Removed unusual repeat for amp software reset and verification.
- Amp software reset will be performed once and it repeats verification max=
imum 3 times if it is failed.
- Wait 10ms before every verification trial. Maximum 30ms delay will be app=
lied to wait AMP idle state.
Changes:
- Created max98373_reset function to minimize code duplication.
- Changed regmap_write to regmap_update_bits. Other bits except LSB need to=
 be masked.
- Added reset verification step to make sure software reset is completed we=
ll. Software reset is done in 10ms in normal case.
- Revision ID is available when the amp is in the idle state which means so=
ftware reset is completed.
- Software reset will be performed maximum 3 times to avoid amp reset failu=
re. Generally it is done in the first trial.
- sleep time after software reset is increased + 30ms for every retrial. Ma=
ximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

 sound/soc/codecs/max98373.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d013..9c8616a 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,39 @@ static struct snd_soc_dai_driver max98373_dai[] =3D {
 	}
 };
=20
+static void max98373_reset(struct max98373_priv *max98373, struct device *=
dev)
+{
+	int ret, reg, count;
+
+	/* Software Reset */
+	ret =3D regmap_update_bits(max98373->regmap,
+		MAX98373_R2000_SW_RESET,
+		MAX98373_SOFT_RESET,
+		MAX98373_SOFT_RESET);
+	if (ret)
+		dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+	count =3D 0;
+	while (count < 3) {
+		usleep_range(10000, 11000);
+		/* Software Reset Verification */
+		ret =3D regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			return;
+		}
+		count++;
+	}
+	dev_err(dev, "Reset failed. (ret:%d)\n", ret);
+}
+
 static int max98373_probe(struct snd_soc_component *component)
 {
 	struct max98373_priv *max98373 =3D snd_soc_component_get_drvdata(componen=
t);
=20
 	/* Software Reset */
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, component->dev);
=20
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,9 +843,7 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 =3D dev_get_drvdata(dev);
=20
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
--=20
2.7.4
