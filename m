From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH 4/4] ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order
Date: Wed, 10 Oct 2018 23:26:17 +0000
Message-ID: <20181010232222.52340-4-ryans.lee@maximintegrated.com>
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
 Changes : Sort 'max98373_dht_spkgain_min_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index e9c082c..e75c212 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -470,12 +470,12 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_spkgai=
n_min_tlv,
 	0, 9, TLV_DB_SCALE_ITEM(800, 100, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation_point_tlv,
-	0, 1, TLV_DB_SCALE_ITEM(-50, -50, 0),
-	2, 7, TLV_DB_SCALE_ITEM(-200, -100, 0),
-	8, 9, TLV_DB_SCALE_ITEM(-1000, -200, 0),
-	10, 11, TLV_DB_SCALE_ITEM(-1500, -300, 0),
-	12, 13, TLV_DB_SCALE_ITEM(-2000, -200, 0),
-	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
+	0, 1, TLV_DB_SCALE_ITEM(-3000, 500, 0),
+	2, 4, TLV_DB_SCALE_ITEM(-2200, 200, 0),
+	5, 6, TLV_DB_SCALE_ITEM(-1500, 300, 0),
+	7, 9, TLV_DB_SCALE_ITEM(-1000, 200, 0),
+	10, 13, TLV_DB_SCALE_ITEM(-500, 100, 0),
+	14, 15, TLV_DB_SCALE_ITEM(-100, 50, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
@@ -616,7 +616,7 @@ SOC_SINGLE("DHT Switch", MAX98373_R20D4_DHT_EN,
 SOC_SINGLE_TLV("DHT Min Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
 SOC_SINGLE_TLV("DHT Rot Pnt Volume", MAX98373_R20D1_DHT_CFG,
-	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
+	MAX98373_DHT_ROT_PNT_SHIFT, 15, 1, max98373_dht_rotation_point_tlv),
 SOC_SINGLE_TLV("DHT Attack Step Volume", MAX98373_R20D2_DHT_ATTACK_CFG,
 	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
 SOC_SINGLE_TLV("DHT Release Step Volume", MAX98373_R20D3_DHT_RELEASE_CFG,
--=20
2.7.4
