From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v12 2/6] sound/core: add DRM ELD helper
Date: Fri, 8 May 2015 10:01:05 +0200
Message-ID: <df470448c18aed3eff448c5d7289e70d6447b691.1431083916.git.moinejf@free.fr>
References: <cover.1431083916.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431083916.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>

Add a helper for the EDID like data structure, which is typically passed
from a HDMI adapter to its associated audio driver.  This informs the
audio driver of the capabilities of the attached HDMI sink.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 include/sound/pcm_drm_eld.h |  6 +++
 sound/core/Kconfig          |  3 ++
 sound/core/Makefile         |  1 +
 sound/core/pcm_drm_eld.c    | 92 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 include/sound/pcm_drm_eld.h
 create mode 100644 sound/core/pcm_drm_eld.c

diff --git a/include/sound/pcm_drm_eld.h b/include/sound/pcm_drm_eld.h
new file mode 100644
index 0000000..93357b2
--- /dev/null
+++ b/include/sound/pcm_drm_eld.h
@@ -0,0 +1,6 @@
+#ifndef __SOUND_PCM_DRM_ELD_H
+#define __SOUND_PCM_DRM_ELD_H
+
+int snd_pcm_hw_constraint_eld(struct snd_pcm_runtime *runtime, void *eld);
+
+#endif
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 313f22e..b534c8a 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -6,6 +6,9 @@ config SND_PCM
 	tristate
 	select SND_TIMER
 
+config SND_PCM_ELD
+	bool
+
 config SND_DMAENGINE_PCM
 	tristate
 
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 4daf2f5..591b491 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -13,6 +13,7 @@ snd-$(CONFIG_SND_JACK)	  += jack.o
 snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o memalloc.o
 snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
+snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
 
 # for trace-points
 CFLAGS_pcm_lib.o := -I$(src)
diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
new file mode 100644
index 0000000..47d9b60
--- /dev/null
+++ b/sound/core/pcm_drm_eld.c
@@ -0,0 +1,92 @@
+/*
+ *  PCM DRM helpers
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License version 2 as
+ *   published by the Free Software Foundation.
+ */
+#include <linux/export.h>
+#include <drm/drm_edid.h>
+#include <sound/pcm.h>
+#include <sound/pcm_drm_eld.h>
+
+static const unsigned int eld_rates[] = {
+	32000,
+	44100,
+	48000,
+	88200,
+	96000,
+	176400,
+	192000,
+};
+
+static int eld_limit_rates(struct snd_pcm_hw_params *params,
+			   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, rule->var);
+	struct snd_interval *c;
+	unsigned int rate_mask = 7, i;
+	const u8 *sad, *eld = rule->private;
+
+	sad = drm_eld_sad(eld);
+	if (sad) {
+		c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+
+		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
+			unsigned channels = 1 + (sad[0] & 7);
+
+			/*
+			 * Exclude SADs which do not include the
+			 * requested number of channels.
+			 */
+			if (c->min <= channels)
+				rate_mask |= sad[1];
+		}
+printk("%s: r %d-%d c %d-%d m %x\n", __func__, r->min, r->max, c->min, c->max, rate_mask);
+	}
+
+	return snd_interval_list(r, ARRAY_SIZE(eld_rates), eld_rates,
+				 rate_mask);
+}
+
+static int eld_limit_channels(struct snd_pcm_hw_params *params,
+			      struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *var = hw_param_interval(params, rule->var);
+	struct snd_interval t = { .min = 1, .max = 2, .integer = 1, };
+	unsigned int i;
+	const u8 *sad, *eld = rule->private;
+
+	sad = drm_eld_sad(eld);
+	if (sad) {
+		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
+			switch (sad[0] & 0x78) {
+			case 0x08:
+				t.max = max(t.max, (sad[0] & 7) + 1u);
+				break;
+			}
+		}
+	}
+
+	return snd_interval_refine(var, &t);
+}
+
+int snd_pcm_hw_constraint_eld(struct snd_pcm_runtime *runtime, void *eld)
+{
+	int ret;
+
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  eld_limit_rates, eld,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  eld_limit_channels, eld,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_hw_constraint_eld);
-- 
2.1.4
