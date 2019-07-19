From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v6 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Date: Fri, 19 Jul 2019 10:05:35 +0000
Message-ID: <20190719100524.23300-6-oleksandr.suvorov@toradex.com>
References: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

To enable "zero cross detect" for ADC/HP, change
HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index b65232521ea8..23f4ae2f0723 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1453,6 +1453,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 =3D snd_soc_component_get_drvdata(componen=
t);
+	unsigned int zcd_mask =3D SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
=20
 	/* power up sgtl5000 */
 	ret =3D sgtl5000_set_power_regs(component);
@@ -1480,9 +1481,8 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
=20
-	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
-			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		zcd_mask, zcd_mask);
=20
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
--=20
2.20.1
