From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v11 2/2] ASoC: rockchip: Use bus_type to
	distinguish rt5514 dsp from rt5514 codec
Date: Mon, 18 Sep 2017 19:14:35 +0800
Message-ID: <20170918111435.11411-2-jeffy.chen@rock-chips.com>
References: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CAE4266AF8
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 13:14:43 +0200 (CEST)
In-Reply-To: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, briannorris@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, dianders@chromium.org, linux-rockchip@lists.infradead.org, broonie@kernel.org, Takashi Iwai <tiwai@suse.com>, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
Use bus_type to distinguish rt5514 dsp from rt5514 codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v11: None
Changes in v10: None
Changes in v9: None

 sound/soc/rockchip/rk3399_gru_sound.c | 57 +++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 0513fe480353..f8028f1f3266 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -23,6 +23,7 @@
 #include <linux/of_gpio.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -329,15 +330,6 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
-static const char * const dailink_compat[] = {
-	[DAILINK_CDNDP] = "rockchip,rk3399-cdn-dp",
-	[DAILINK_DA7219] = "dlg,da7219",
-	[DAILINK_DMIC] = "dmic-codec",
-	[DAILINK_MAX98357A] = "maxim,max98357a",
-	[DAILINK_RT5514] = "realtek,rt5514-i2c",
-	[DAILINK_RT5514_DSP] = "realtek,rt5514-spi",
-};
-
 static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
@@ -391,13 +383,54 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	},
 };
 
+struct dailink_match_data {
+	const char *compatible;
+	struct bus_type *bus_type;
+};
+
+static const struct dailink_match_data dailink_match[] = {
+	[DAILINK_CDNDP] = {
+		.compatible = "rockchip,rk3399-cdn-dp",
+	},
+	[DAILINK_DA7219] = {
+		.compatible = "dlg,da7219",
+	},
+	[DAILINK_DMIC] = {
+		.compatible = "dmic-codec",
+	},
+	[DAILINK_MAX98357A] = {
+		.compatible = "maxim,max98357a",
+	},
+	[DAILINK_RT5514] = {
+		.compatible = "realtek,rt5514",
+		.bus_type = &i2c_bus_type,
+	},
+	[DAILINK_RT5514_DSP] = {
+		.compatible = "realtek,rt5514",
+		.bus_type = &spi_bus_type,
+	},
+};
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
 static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dailink_compat); i++) {
-		if (of_device_is_compatible(np_codec, dailink_compat[i]))
-			return i;
+	for (i = 0; i < ARRAY_SIZE(dailink_match); i++) {
+		if (!of_device_is_compatible(np_codec,
+					     dailink_match[i].compatible))
+			continue;
+
+		if (dailink_match[i].bus_type
+		    && !bus_find_device(dailink_match[i].bus_type,
+					NULL, np_codec, of_dev_node_match))
+			continue;
+
+		return i;
 	}
 	return -1;
 }
-- 
2.11.0
