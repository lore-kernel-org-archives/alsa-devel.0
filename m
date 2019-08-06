From: <shumingf@realtek.com>
Subject: [PATCH] ASoC: rt1011: Add a flag for the R0
	calibration test
Date: Tue, 6 Aug 2019 17:14:59 +0800
Message-ID: <20190806091459.14382-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7EF1F804CB
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 11:15:07 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, Shuming Fan <shumingf@realtek.com>, derek.fang@realtek.com, frankbozar@google.com, sathya.prakash.m.r@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The factory test needs to know whether the calibration completed.
This flag helps to confirm the calibration completed or not.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 14 +++++++++++++-
 sound/soc/codecs/rt1011.h |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index b25b4c1127ca..638abcaf52b3 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1225,7 +1225,10 @@ static int rt1011_bq_drc_info(struct snd_kcontrol *kcontrol,
 static int rt1011_r0_cali_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = 0;
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1011_priv *rt1011 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = rt1011->cali_done;
 
 	return 0;
 }
@@ -1239,6 +1242,7 @@ static int rt1011_r0_cali_put(struct snd_kcontrol *kcontrol,
 	if (!component->card->instantiated)
 		return 0;
 
+	rt1011->cali_done = 0;
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF &&
 		ucontrol->value.integer.value[0])
 		rt1011_calibrate(rt1011, 1);
@@ -2135,6 +2139,7 @@ static int rt1011_calibrate(struct rt1011_priv *rt1011, unsigned char cali_flag)
 			r0_factor = ((format / r0[0] * 100) / 128)
 							- (r0_integer * 100);
 			rt1011->r0_reg = r0[0];
+			rt1011->cali_done = 1;
 			dev_info(dev,	"r0 resistance about %d.%02d ohm, reg=0x%X\n",
 				r0_integer, r0_factor, r0[0]);
 		}
@@ -2185,6 +2190,13 @@ static void rt1011_calibration_work(struct work_struct *work)
 
 	rt1011_calibrate(rt1011, 1);
 
+	/*
+	 * This flag should reset after booting.
+	 * The factory test will do calibration again and use this flag to check
+	 * whether the calibration completed
+	 */
+	rt1011->cali_done = 0;
+
 	/* initial */
 	rt1011_reg_init(component);
 }
diff --git a/sound/soc/codecs/rt1011.h b/sound/soc/codecs/rt1011.h
index 5d431d7f1d16..2d65983f3d0f 100644
--- a/sound/soc/codecs/rt1011.h
+++ b/sound/soc/codecs/rt1011.h
@@ -666,7 +666,7 @@ struct rt1011_priv {
 	int pll_out;
 
 	int bq_drc_set;
-	unsigned int r0_reg;
+	unsigned int r0_reg, cali_done;
 	int recv_spk_mode;
 };
 
-- 
2.22.0
