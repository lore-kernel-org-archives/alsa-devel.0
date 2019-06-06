From: <shumingf@realtek.com>
Subject: [PATCH] ASoC: rt1011: fix warning reported by kbuild
	test robot and minor issue
Date: Thu, 6 Jun 2019 14:22:32 +0800
Message-ID: <20190606062232.3753-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15758F896CE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 08:22:45 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, derek.fang@realtek.com, Shuming Fan <shumingf@realtek.com>, mingjane_hsieh@realtek.com, flove@realtek.com, hychao@google.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

This patch fixes following issues:
- warning: this decimal constant is unsigned only in ISO C90
- sparse: incorrect type in assignment
- check if value.integer.value is zero for "R0 Load Mode" control

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 349d6db7ecd4..5605b660f4bf 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1145,8 +1145,8 @@ static int rt1011_bq_drc_coeff_get(struct snd_kcontrol *kcontrol,
 	bq_drc_info = rt1011->bq_drc_params[mode_idx];
 
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
-		params[i].reg = cpu_to_le16(bq_drc_info[i].reg);
-		params[i].val = cpu_to_le16(bq_drc_info[i].val);
+		params[i].reg = bq_drc_info[i].reg;
+		params[i].val = bq_drc_info[i].val;
 	}
 
 	return 0;
@@ -1187,8 +1187,8 @@ static int rt1011_bq_drc_coeff_put(struct snd_kcontrol *kcontrol,
 	pr_info("%s, id.name=%s, mode_idx=%d\n", __func__,
 		ucontrol->id.name, mode_idx);
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
-		bq_drc_info[i].reg =	le16_to_cpu(params[i].reg);
-		bq_drc_info[i].val =	le16_to_cpu(params[i].val);
+		bq_drc_info[i].reg = params[i].reg;
+		bq_drc_info[i].val = params[i].val;
 	}
 
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
@@ -1284,11 +1284,14 @@ static int rt1011_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	if (!component->card->instantiated)
 		return 0;
 
+	if (ucontrol->value.integer.value[0] == 0)
+		return -EINVAL;
+
 	dev = regmap_get_device(rt1011->regmap);
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 		rt1011->r0_reg = ucontrol->value.integer.value[0];
 
-		format = 2147483648; /* 2^24 * 128 */
+		format = 2147483648U; /* 2^24 * 128 */
 		r0_integer = format / rt1011->r0_reg / 128;
 		r0_factor = ((format / rt1011->r0_reg * 100) / 128)
 						- (r0_integer * 100);
@@ -2120,7 +2123,7 @@ static int rt1011_calibrate(struct rt1011_priv *rt1011, unsigned char cali_flag)
 			dev_err(dev,	"Calibrate R0 Failure\n");
 			ret = -EAGAIN;
 		} else {
-			format = 2147483648; /* 2^24 * 128 */
+			format = 2147483648U; /* 2^24 * 128 */
 			r0_integer = format / r0[0] / 128;
 			r0_factor = ((format / r0[0] * 100) / 128)
 							- (r0_integer * 100);
-- 
2.21.0
