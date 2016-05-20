From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] ASoC: simple_card: add support for hw_params_rules
Date: Fri, 20 May 2016 12:30:45 +0000
Message-ID: <1463747445-14167-3-git-send-email-kernel@martin.sperl.org>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463747445-14167-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add support for hw_params_rules to simple_card.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt |  1 +
 sound/soc/generic/simple-card.c                         | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cf3979e..2cfed39 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -31,6 +31,7 @@ Optional subnodes:
 					  omitted when the card has only one
 					  DAI link. See the examples and the
 					  section bellow.
+- hw-params-rules			: Please refer to hw-params-rules.txt.
 
 Dai-link subnode properties and subnodes:
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2389ab4..6b95ea1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -8,6 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include "hw-params-rules.h"
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
@@ -33,6 +34,7 @@ struct simple_card_data {
 	int gpio_hp_det_invert;
 	int gpio_mic_det;
 	int gpio_mic_det_invert;
+	struct list_head hw_params_rules;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -51,7 +53,7 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 	ret = clk_prepare_enable(dai_props->cpu_dai.clk);
 	if (ret)
 		return ret;
-	
+
 	ret = clk_prepare_enable(dai_props->codec_dai.clk);
 	if (ret)
 		clk_disable_unprepare(dai_props->cpu_dai.clk);
@@ -99,7 +101,9 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 	}
-	return 0;
+
+	return asoc_generic_hw_params_process_rules(
+		&priv->hw_params_rules, substream, params);
 err:
 	return ret;
 }
@@ -509,7 +513,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (!priv->snd_card.name)
 		priv->snd_card.name = priv->snd_card.dai_link->name;
 
-	return 0;
+	return asoc_generic_hw_params_rules_parse_of(
+		dev, node, &priv->hw_params_rules);
 }
 
 /* Decrease the reference count of the device nodes */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
