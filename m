From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Date: Tue, 19 Feb 2019 16:15:45 +0000
Message-ID: <20190219161518.1331-2-codrin.ciubotariu@microchip.com>
References: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: dannenberg@ti.com, m-stecklein@ti.com, afd@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The ADCs are sleeping when the SLEEP bit is set and running when it's
cleared, so the bit should be inverted.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/pcm186x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 7947279243f9..4477d678797f 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -157,7 +157,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_wi=
dgets[] =3D {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
 };
=20
 static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] =3D {
@@ -183,8 +183,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_wi=
dgets[] =3D {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
-	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
+	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
 };
=20
 static const struct snd_soc_dapm_route pcm1863_dapm_routes[] =3D {
--=20
2.17.1
