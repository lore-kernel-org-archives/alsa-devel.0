From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v2] ASoC: Add external amplifier controls for
	Visstrim_M10.
Date: Fri, 20 Jan 2012 10:16:57 +0100
Message-ID: <1327051017-14903-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5C5B424630
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2012 10:17:07 +0100 (CET)
Received: by wera13 with SMTP id a13so233650wer.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2012 01:17:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, Javier Martin <javier.martin@vista-silicon.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Visstrim_M10 has an external class D amplifier.
This patch provides support for controlling the 4
possible gain levels and per channel muting.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 Changes since v1:
  - Specify amplifier gains using tlv array.
  - Check range values in amplifier controls.

---
 sound/soc/imx/mx27vis-aic32x4.c |   80 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index d37e23c..155899c 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -25,16 +25,37 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 #include <asm/mach-types.h>
 #include <mach/audmux.h>
+#include <mach/iomux-mx27.h>
 
 #include "../codecs/tlv320aic32x4.h"
 #include "imx-ssi.h"
 
+#define MX27VIS_AMP_GAIN	0
+#define MX27VIS_AMP_MUTE	1
+
+#define MX27VIS_PIN_G0		(GPIO_PORTF + 9)
+#define MX27VIS_PIN_G1		(GPIO_PORTF + 8)
+#define MX27VIS_PIN_SDL		(GPIO_PORTE + 5)
+#define MX27VIS_PIN_SDR		(GPIO_PORTF + 7)
+
+static int mx27vis_amp_gain;
+static int mx27vis_amp_mute;
+
+static const int mx27vis_amp_pins[] = {
+	MX27VIS_PIN_G0 | GPIO_GPIO | GPIO_OUT,
+	MX27VIS_PIN_G1 | GPIO_GPIO | GPIO_OUT,
+	MX27VIS_PIN_SDL | GPIO_GPIO | GPIO_OUT,
+	MX27VIS_PIN_SDR | GPIO_GPIO | GPIO_OUT,
+};
+
 static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
@@ -74,8 +95,60 @@ static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
 	.hw_params	= mx27vis_aic32x4_hw_params,
 };
 
+static int mx27vis_amp_set(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value = ucontrol->value.integer.value[0];
+	unsigned int reg = mc->reg;
+	int max = mc->max;
+
+	if (value > max)
+		return -EINVAL;
+
+	switch (reg) {
+	case MX27VIS_AMP_GAIN:
+		gpio_set_value(MX27VIS_PIN_G0, value & 1);
+		gpio_set_value(MX27VIS_PIN_G1, value >> 1);
+		mx27vis_amp_gain = value;
+		break;
+	case MX27VIS_AMP_MUTE:
+		gpio_set_value(MX27VIS_PIN_SDL, value & 1);
+		gpio_set_value(MX27VIS_PIN_SDR, value >> 1);
+		mx27vis_amp_mute = value;
+		break;
+	}
+	return 0;
+}
+
+static int mx27vis_amp_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+
+	switch (reg) {
+	case MX27VIS_AMP_GAIN:
+		ucontrol->value.integer.value[0] = mx27vis_amp_gain;
+		break;
+	case MX27VIS_AMP_MUTE:
+		ucontrol->value.integer.value[0] = mx27vis_amp_mute;
+		break;
+	}
+	return 0;
+}
+
+/* From 6dB to 24dB in steps of 6dB */
+static const DECLARE_TLV_DB_SCALE(mx27vis_amp_tlv, 600, 600, 0);
+
 static const struct snd_kcontrol_new mx27vis_aic32x4_controls[] = {
 	SOC_DAPM_PIN_SWITCH("External Mic"),
+	SOC_SINGLE_EXT_TLV("LO Ext Boost", MX27VIS_AMP_GAIN, 0, 3, 0,
+		       mx27vis_amp_get, mx27vis_amp_set, mx27vis_amp_tlv),
+	SOC_DOUBLE_EXT("LO Ext Mute Switch", MX27VIS_AMP_MUTE, 0, 1, 1, 0,
+		       mx27vis_amp_get, mx27vis_amp_set),
 };
 
 static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
@@ -146,6 +219,13 @@ static int __init mx27vis_aic32x4_init(void)
 			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
 	);
 
+	ret = mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
+			ARRAY_SIZE(mx27vis_amp_pins), "MX27VIS_AMP");
+	if (ret) {
+		printk(KERN_ERR "ASoC: unable to setup gpios\n");
+		platform_device_put(mx27vis_aic32x4_snd_device);
+	}
+
 	return ret;
 }
 
-- 
1.7.0.4
