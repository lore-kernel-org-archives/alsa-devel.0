From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Implement runtime PM for WM8994
Date: Fri, 26 Nov 2010 17:23:43 +0000
Message-ID: <1290792224-21758-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 709E7243E7
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 18:23:50 +0100 (CET)
In-Reply-To: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This allows us to communicate our power management state back to the
parent device, allowing it to do a full power down when the device is
idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5f203c5..bfd4cf4 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -1803,6 +1804,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			pm_runtime_get_sync(codec->dev);
+
 			/* Tweak DC servo and DSP configuration for
 			 * improved performance. */
 			if (control->type == WM8994 && wm8994->revision < 4) {
@@ -1878,6 +1881,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_STARTUP_BIAS_ENA |
 					    WM8994_VMID_BUF_ENA |
 					    WM8994_VMID_RAMP_MASK, 0);
+
+			pm_runtime_put(codec->dev);
 		}
 		break;
 	}
@@ -2780,6 +2785,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
 	wm8994->codec = codec;
 
+	pm_runtime_enable(codec->dev);
+	pm_runtime_resume(codec->dev);
+
 	/* Read our current status back from the chip - we don't want to
 	 * reset as this may interfere with the GPIO or LDO operation. */
 	for (i = 0; i < WM8994_CACHE_SIZE; i++) {
@@ -2995,6 +3003,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
+	pm_runtime_disable(codec->dev);
+
 	switch (control->type) {
 	case WM8994:
 		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT,
-- 
1.7.1
