From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Date: Tue, 19 Feb 2019 16:15:42 +0000
Message-ID: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: dannenberg@ti.com, m-stecklein@ti.com, afd@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/pcm186x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 809b7e9f03ca..7947279243f9 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -6,7 +6,6 @@
  *	Andreas Dannenberg <dannenberg@ti.com>
  *	Andrew F. Davis <afd@ti.com>
  */
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -42,7 +41,7 @@ struct pcm186x_priv {
 	bool is_master_mode;
 };
=20
-static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
+static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
=20
 static const struct snd_kcontrol_new pcm1863_snd_controls[] =3D {
 	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,
--=20
2.17.1
