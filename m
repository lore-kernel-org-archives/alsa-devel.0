From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: move the jack creation to
	Braswell machine driver
Date: Tue, 17 Mar 2015 10:23:31 +0800
Message-ID: <1426559011-8499-3-git-send-email-yao.jin@linux.intel.com>
References: <1426559011-8499-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7F8261A1D
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 03:17:35 +0100 (CET)
In-Reply-To: <1426559011-8499-1-git-send-email-yao.jin@linux.intel.com>
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, yao.jin@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The jack creation code was in rt5670 codec driver before due to the
jack resources (gpio/irq) were defined under the node of codec device
in ACPI on Braswell. We used the snd_soc_jack_new() to create a jack
instance.

But now snd_soc_jack_new() is removed from upstream and we can't
use snd_soc_card_jack_new() in codec driver, so we move the jack
creation code to machine driver and pass the jack instance to codec
driver for further processing.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index c41fae3..4204fc4 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -22,6 +22,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include "../codecs/rt5670.h"
 #include "sst-atom-controls.h"
 
@@ -29,6 +30,20 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5670-aif1"
 
+static struct snd_soc_jack cht_bsw_headset;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin cht_bsw_headset_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
 {
 	int i;
@@ -178,6 +193,15 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 				| RT5670_AD_MONO_L_FILTER
 				| RT5670_AD_MONO_R_FILTER,
 				RT5670_CLK_SEL_I2S1_ASRC);
+
+        ret = snd_soc_card_jack_new(runtime->card, "Headset",
+                SND_JACK_HEADSET | SND_JACK_BTN_0 |
+                SND_JACK_BTN_1 | SND_JACK_BTN_2, &cht_bsw_headset,
+                cht_bsw_headset_pins, ARRAY_SIZE(cht_bsw_headset_pins));
+        if (ret)
+                return ret;
+
+	rt5670_set_jack_detect(codec, &cht_bsw_headset);
 	return 0;
 }
 
-- 
1.9.1
