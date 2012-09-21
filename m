From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: core: Configure pin muxing via pinctrl
	when registering a DAI
Date: Fri, 21 Sep 2012 10:54:26 +0300
Message-ID: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
 [74.125.149.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 453D02615BD
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 09:53:36 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so2863763obb.38
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 00:53:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pinctrl framework now becoming widely available for SoCs to configure pin
multiplexing.
Instead of adding the same code to all dai drivers the core can take care
of this transparently.
Do not make too much noise if pinctrl is not provided via DT for the dai
but just use dev_info().

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark, Liam,

I was about to add the pinctrl support for OMAP dais (McBSP/McPDM/DMIC/HDMI)
when I realized that I just kept duplicating the same code all over.
It is better to leave this to the core.

Regards,
Peter

 sound/soc/soc-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9a6daf9..37464c5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -33,6 +33,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <sound/ac97_codec.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -3686,6 +3687,19 @@ static inline char *fmt_multiple_name(struct device *dev,
 	return kstrdup(dai_drv->name, GFP_KERNEL);
 }
 
+/*
+ * Simple function to be used in snd_soc_dai_register_dai/s to set the default
+ * pinmuxing for the dai.
+ */
+static inline void snd_soc_configure_dai_pins(struct device *dev)
+{
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(dev);
+	if (IS_ERR(pinctrl))
+		dev_info(dev, "pins are not configured for the DAI\n");
+}
+
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
@@ -3734,6 +3748,8 @@ int snd_soc_register_dai(struct device *dev,
 
 	mutex_unlock(&client_mutex);
 
+	snd_soc_configure_dai_pins(dev);
+
 	pr_debug("Registered DAI '%s'\n", dai->name);
 
 	return 0;
@@ -3828,6 +3844,8 @@ int snd_soc_register_dais(struct device *dev,
 		pr_debug("Registered DAI '%s'\n", dai->name);
 	}
 
+	snd_soc_configure_dai_pins(dev);
+
 	return 0;
 
 err:
-- 
1.7.12
