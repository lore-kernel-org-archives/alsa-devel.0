From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/19] ASoC: rt5640: Allow specifying dmic data
	pins through device-properties
Date: Tue,  8 May 2018 17:35:50 +0200
Message-ID: <20180508153604.23711-6-hdegoede@redhat.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E56F82676CC
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:15 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Allow specifying dmic data pins through device-properties / dt. This will
allow us to stop exporting rt5640_dmic_enable() once all callers of it have
been converted to setting device-properties for this instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5640.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 265a0786851d..d7c7b207f3cc 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2097,6 +2097,10 @@ static int rt5640_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+	u32 dmic1_data_pin = 0;
+	u32 dmic2_data_pin = 0;
+	bool dmic_en = false;
+	u32 val;
 
 	/* Check if MCLK provided */
 	rt5640->mclk = devm_clk_get(component->dev, "mclk");
@@ -2157,6 +2161,21 @@ static int rt5640_probe(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, RT5640_IN1_IN2,
 					      RT5640_IN_DF2, RT5640_IN_DF2);
 
+	if (device_property_read_u32(component->dev, "realtek,dmic1-data-pin",
+				     &val) == 0 && val) {
+		dmic1_data_pin = val - 1;
+		dmic_en = true;
+	}
+
+	if (device_property_read_u32(component->dev, "realtek,dmic2-data-pin",
+				     &val) == 0 && val) {
+		dmic2_data_pin = val - 1;
+		dmic_en = true;
+	}
+
+	if (dmic_en)
+		rt5640_dmic_enable(component, dmic1_data_pin, dmic2_data_pin);
+
 	return 0;
 }
 
-- 
2.17.0
