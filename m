From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] ASoC: Intel: bytcr_rt5651: Reporting
	button presses
Date: Thu,  5 Jul 2018 00:59:35 +0200
Message-ID: <20180704225935.7902-5-hdegoede@redhat.com>
References: <20180704225935.7902-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 20DC52670D7
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 00:59:45 +0200 (CEST)
In-Reply-To: <20180704225935.7902-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Enable reporting of button presses now that the codec driver recently has
gotten support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 2a8f86dfe4cb..b687043c8425 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/input.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/slab.h>
@@ -531,13 +532,17 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    SND_JACK_HEADSET, &priv->jack,
-				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
+				    SND_JACK_HEADSET | SND_JACK_BTN_0,
+				    &priv->jack, bytcr_jack_pins,
+				    ARRAY_SIZE(bytcr_jack_pins));
 		if (ret) {
 			dev_err(runtime->dev, "jack creation failed %d\n", ret);
 			return ret;
 		}
 
+		snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0,
+				 KEY_PLAYPAUSE);
+
 		ret = snd_soc_component_set_jack(codec, &priv->jack, NULL);
 		if (ret)
 			return ret;
-- 
2.17.1
