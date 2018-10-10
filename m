From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH 2/4] ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse
 order
Date: Wed, 10 Oct 2018 23:26:10 +0000
Message-ID: <20181010232222.52340-2-ryans.lee@maximintegrated.com>
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
 Changes : Sort 'max98373_limiter_thresh_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index bb5ef52..1f5887b 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -478,7 +478,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation=
_point_tlv,
 	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
-	0, 15, TLV_DB_SCALE_ITEM(0, -100, 0),
+	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
 );
=20
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
@@ -669,13 +669,13 @@ SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX9=
8373_R20B0_BDE_L3_CFG_3,
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG=
_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Limiter Thresh Volume", MAX98373_R20AE_BDE_L3_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Limiter Thresh Volume", MAX98373_R20B1_BDE_L4_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 /* Limiter */
 SOC_SINGLE("Limiter Switch", MAX98373_R20E2_LIMITER_EN,
 	MAX98373_LIMITER_EN_SHIFT, 1, 0),
--=20
2.7.4
