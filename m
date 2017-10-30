From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: remove unexisting route on new
	rt5645
Date: Mon, 30 Oct 2017 15:26:05 +0800
Message-ID: <1509348365-16840-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 00957266A0C
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 08:26:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

"SPOL MIX DAC R1 Switch" and "SPOL MIX SPKVOL R Switch" are only
exist in the early version of rt5645.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e34f278..b7eef6a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -432,6 +432,7 @@ struct rt5645_priv {
 	int jack_type;
 	bool en_button_func;
 	bool hp_on;
+	int v_id;
 };
 
 static int rt5645_reset(struct snd_soc_codec *codec)
@@ -2516,9 +2517,7 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "SPKVOL L", "Switch", "SPK MIXL" },
 	{ "SPKVOL R", "Switch", "SPK MIXR" },
 
-	{ "SPOL MIX", "DAC R1 Switch", "DAC R1" },
 	{ "SPOL MIX", "DAC L1 Switch", "DAC L1" },
-	{ "SPOL MIX", "SPKVOL R Switch", "SPKVOL R" },
 	{ "SPOL MIX", "SPKVOL L Switch", "SPKVOL L" },
 	{ "SPOR MIX", "DAC R1 Switch", "DAC R1" },
 	{ "SPOR MIX", "SPKVOL R Switch", "SPKVOL R" },
@@ -2707,6 +2706,11 @@ static const struct snd_soc_dapm_route rt5645_specific_dapm_routes[] = {
 	{ "DAC R2 Mux", "IF1 DAC", "RT5645 IF1 DAC2 R Mux" },
 };
 
+static const struct snd_soc_dapm_route rt5645_old_dapm_routes[] = {
+	{ "SPOL MIX", "DAC R1 Switch", "DAC R1" },
+	{ "SPOL MIX", "SPKVOL R Switch", "SPKVOL R" },
+};
+
 static int rt5645_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -3363,6 +3367,11 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_add_routes(dapm,
 			rt5645_specific_dapm_routes,
 			ARRAY_SIZE(rt5645_specific_dapm_routes));
+		if (rt5645->v_id < 3) {
+			snd_soc_dapm_add_routes(dapm,
+				rt5645_old_dapm_routes,
+				ARRAY_SIZE(rt5645_old_dapm_routes));
+		}
 		break;
 	case CODEC_TYPE_RT5650:
 		snd_soc_dapm_new_controls(dapm,
@@ -3803,6 +3812,9 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
 
+	regmap_read(regmap, RT5645_VENDOR_ID, &val);
+	rt5645->v_id = val & 0xff;
+
 	ret = regmap_register_patch(rt5645->regmap, init_list,
 				    ARRAY_SIZE(init_list));
 	if (ret != 0)
-- 
2.7.4
