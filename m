From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/21] ASoC: rt5651: fix boolean assignments
Date: Fri,  4 Jan 2019 20:02:42 -0600
Message-ID: <20190105020249.8639-15-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
sound/soc/codecs/rt5651.c:750:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:754:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:2192:1-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index b7ba64350a07..3882e238ff99 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -747,11 +747,11 @@ static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
 			RT5651_HP_CP_PD | RT5651_HP_SG_EN);
 		regmap_update_bits(rt5651->regmap, RT5651_PR_BASE +
 			RT5651_CHPUMP_INT_REG1, 0x0700, 0x0400);
-		rt5651->hp_mute = 0;
+		rt5651->hp_mute = false;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		rt5651->hp_mute = 1;
+		rt5651->hp_mute = true;
 		usleep_range(70000, 75000);
 		break;
 
@@ -2189,7 +2189,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
 	rt5651->irq = i2c->irq;
-	rt5651->hp_mute = 1;
+	rt5651->hp_mute = true;
 
 	INIT_DELAYED_WORK(&rt5651->bp_work, rt5651_button_press_work);
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
-- 
2.17.1
