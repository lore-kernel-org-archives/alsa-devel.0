From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH 3/4] ASoC: max98373: Sort max98373_bde_gain_tlv in reverse
 order
Date: Wed, 10 Oct 2018 23:26:13 +0000
Message-ID: <20181010232222.52340-3-ryans.lee@maximintegrated.com>
References: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Sort 'max98373_bde_gain_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 1f5887b..e9c082c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -482,7 +482,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_limiter_thre=
sh_tlv,
 );
=20
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
-	0, 60, TLV_DB_SCALE_ITEM(0, -25, 0),
+	0, 60, TLV_DB_SCALE_ITEM(-1500, 25, 0),
 );
=20
 static bool max98373_readable_register(struct device *dev, unsigned int re=
g)
@@ -653,21 +653,21 @@ SOC_SINGLE("BDE Hold Time", MAX98373_R2090_BDE_LVL_HO=
LD, 0, 0xFF, 0),
 SOC_SINGLE("BDE Attack Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 4, 0xF=
, 0),
 SOC_SINGLE("BDE Release Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 0, 0x=
F, 0),
 SOC_SINGLE_TLV("BDE LVL1 Clip Thresh Volume", MAX98373_R20A9_BDE_L1_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Thresh Volume", MAX98373_R20AC_BDE_L2_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Thresh Volume", MAX98373_R20AF_BDE_L3_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Thresh Volume", MAX98373_R20B2_BDE_L4_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Clip Reduction Volume", MAX98373_R20AA_BDE_L1_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Reduction Volume", MAX98373_R20AD_BDE_L2_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX98373_R20B0_BDE_L3_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG=
_1,
 	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG=
_1,
--=20
2.7.4
