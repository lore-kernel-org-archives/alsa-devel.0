From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH 1/4] ASoC: max98373: Sort Digital Volume in reverse order
Date: Wed, 10 Oct 2018 23:26:06 +0000
Message-ID: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Sort 'max98373_digital_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 1093f76..bb5ef52 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -454,7 +454,7 @@ SND_SOC_DAPM_SIGGEN("IMON"),
 SND_SOC_DAPM_SIGGEN("FBMON"),
 };
=20
-static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, 0, -50, 0);
+static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, -6350, 50, 1);
 static const DECLARE_TLV_DB_RANGE(max98373_spk_tlv,
 	0, 8, TLV_DB_SCALE_ITEM(0, 50, 0),
 	9, 10, TLV_DB_SCALE_ITEM(500, 100, 0),
@@ -604,7 +604,7 @@ SOC_SINGLE("Dither Switch", MAX98373_R203F_AMP_DSP_CFG,
 SOC_SINGLE("DC Blocker Switch", MAX98373_R203F_AMP_DSP_CFG,
 	MAX98373_AMP_DSP_CFG_DCBLK_SHIFT, 1, 0),
 SOC_SINGLE_TLV("Digital Volume", MAX98373_R203D_AMP_DIG_VOL_CTRL,
-	0, 0x7F, 0, max98373_digital_tlv),
+	0, 0x7F, 1, max98373_digital_tlv),
 SOC_SINGLE_TLV("Speaker Volume", MAX98373_R203E_AMP_PATH_GAIN,
 	MAX98373_SPK_DIGI_GAIN_SHIFT, 10, 0, max98373_spk_tlv),
 SOC_SINGLE_TLV("FS Max Volume", MAX98373_R203E_AMP_PATH_GAIN,
--=20
2.7.4
