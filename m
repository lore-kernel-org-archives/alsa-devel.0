From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 02/11] wss_lib: rename cs4231.h into wss.h
Date: Thu, 31 Jul 2008 21:02:42 +0200
Message-ID: <20080731210242.3c000571.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 9BEDE24456
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 20:57:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Rename file include/sound/cs4231.h
into include/sound/wss.h

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Acked-by: Rene Herman <rene.herman@gmail.com>
---

This patch has not been changed since previous posting.

diff --git a/include/sound/cs4231.h b/include/sound/cs4231.h
deleted file mode 100644
index f0785f9..0000000
--- a/include/sound/cs4231.h
+++ /dev/null
@@ -1,175 +0,0 @@
-#ifndef __SOUND_CS4231_H
-#define __SOUND_CS4231_H
-
-/*
- *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
- *  Definitions for CS4231 & InterWave chips & compatible chips
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#include "control.h"
-#include "pcm.h"
-#include "timer.h"
-
-#include "cs4231-regs.h"
-
-/* defines for codec.mode */
-
-#define CS4231_MODE_NONE	0x0000
-#define CS4231_MODE_PLAY	0x0001
-#define CS4231_MODE_RECORD	0x0002
-#define CS4231_MODE_TIMER	0x0004
-#define CS4231_MODE_OPEN	(CS4231_MODE_PLAY|CS4231_MODE_RECORD|CS4231_MODE_TIMER)
-
-/* defines for codec.hardware */
-
-#define CS4231_HW_DETECT        0x0000	/* let CS4231 driver detect chip */
-#define CS4231_HW_DETECT3	0x0001	/* allow mode 3 */
-#define CS4231_HW_TYPE_MASK	0xff00	/* type mask */
-#define CS4231_HW_CS4231_MASK   0x0100	/* CS4231 serie */
-#define CS4231_HW_CS4231        0x0100	/* CS4231 chip */
-#define CS4231_HW_CS4231A       0x0101	/* CS4231A chip */
-#define CS4231_HW_AD1845	0x0102	/* AD1845 chip */
-#define CS4231_HW_CS4232_MASK   0x0200	/* CS4232 serie (has control ports) */
-#define CS4231_HW_CS4232        0x0200	/* CS4232 */
-#define CS4231_HW_CS4232A       0x0201	/* CS4232A */
-#define CS4231_HW_CS4236	0x0202	/* CS4236 */
-#define CS4231_HW_CS4236B_MASK	0x0400	/* CS4236B serie (has extended control regs) */
-#define CS4231_HW_CS4235	0x0400	/* CS4235 - Crystal Clear (tm) stereo enhancement */
-#define CS4231_HW_CS4236B       0x0401	/* CS4236B */
-#define CS4231_HW_CS4237B       0x0402	/* CS4237B - SRS 3D */
-#define CS4231_HW_CS4238B	0x0403	/* CS4238B - QSOUND 3D */
-#define CS4231_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
-/* compatible, but clones */
-#define CS4231_HW_INTERWAVE     0x1000	/* InterWave chip */
-#define CS4231_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
-#define CS4231_HW_OPTI93X 	0x1102	/* Opti 930/931/933 */
-
-/* defines for codec.hwshare */
-#define CS4231_HWSHARE_IRQ	(1<<0)
-#define CS4231_HWSHARE_DMA1	(1<<1)
-#define CS4231_HWSHARE_DMA2	(1<<2)
-
-struct snd_cs4231 {
-	unsigned long port;		/* base i/o port */
-	struct resource *res_port;
-	unsigned long cport;		/* control base i/o port (CS4236) */
-	struct resource *res_cport;
-	int irq;			/* IRQ line */
-	int dma1;			/* playback DMA */
-	int dma2;			/* record DMA */
-	unsigned short version;		/* version of CODEC chip */
-	unsigned short mode;		/* see to CS4231_MODE_XXXX */
-	unsigned short hardware;	/* see to CS4231_HW_XXXX */
-	unsigned short hwshare;		/* shared resources */
-	unsigned short single_dma:1,	/* forced single DMA mode (GUS 16-bit daughter board) or dma1 == dma2 */
-		       ebus_flag:1;	/* SPARC: EBUS present */
-
-	struct snd_card *card;
-	struct snd_pcm *pcm;
-	struct snd_pcm_substream *playback_substream;
-	struct snd_pcm_substream *capture_substream;
-	struct snd_timer *timer;
-
-	unsigned char image[32];	/* registers image */
-	unsigned char eimage[32];	/* extended registers image */
-	unsigned char cimage[16];	/* control registers image */
-	int mce_bit;
-	int calibrate_mute;
-	int sw_3d_bit;
-	unsigned int p_dma_size;
-	unsigned int c_dma_size;
-
-	spinlock_t reg_lock;
-	struct mutex mce_mutex;
-	struct mutex open_mutex;
-
-	int (*rate_constraint) (struct snd_pcm_runtime *runtime);
-	void (*set_playback_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char pdfr);
-	void (*set_capture_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char cdfr);
-	void (*trigger) (struct snd_cs4231 *chip, unsigned int what, int start);
-#ifdef CONFIG_PM
-	void (*suspend) (struct snd_cs4231 *chip);
-	void (*resume) (struct snd_cs4231 *chip);
-#endif
-	void *dma_private_data;
-	int (*claim_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
-	int (*release_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
-};
-
-/* exported functions */
-
-void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
-unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg);
-void snd_cs4236_ext_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
-unsigned char snd_cs4236_ext_in(struct snd_cs4231 *chip, unsigned char reg);
-void snd_cs4231_mce_up(struct snd_cs4231 *chip);
-void snd_cs4231_mce_down(struct snd_cs4231 *chip);
-
-void snd_cs4231_overrange(struct snd_cs4231 *chip);
-
-irqreturn_t snd_cs4231_interrupt(int irq, void *dev_id);
-
-const char *snd_cs4231_chip_id(struct snd_cs4231 *chip);
-
-int snd_cs4231_create(struct snd_card *card,
-		      unsigned long port,
-		      unsigned long cport,
-		      int irq, int dma1, int dma2,
-		      unsigned short hardware,
-		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip);
-int snd_cs4231_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
-int snd_cs4231_timer(struct snd_cs4231 * chip, int device, struct snd_timer **rtimer);
-int snd_cs4231_mixer(struct snd_cs4231 * chip);
-
-int snd_cs4236_create(struct snd_card *card,
-		      unsigned long port,
-		      unsigned long cport,
-		      int irq, int dma1, int dma2,
-		      unsigned short hardware,
-		      unsigned short hwshare,
-		      struct snd_cs4231 ** rchip);
-int snd_cs4236_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
-int snd_cs4236_mixer(struct snd_cs4231 * chip);
-
-/*
- *  mixer library
- */
-
-#define CS4231_SINGLE(xname, xindex, reg, shift, mask, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_single, \
-  .get = snd_cs4231_get_single, .put = snd_cs4231_put_single, \
-  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
-
-int snd_cs4231_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
-int snd_cs4231_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-int snd_cs4231_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-
-#define CS4231_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_cs4231_info_double, \
-  .get = snd_cs4231_get_double, .put = snd_cs4231_put_double, \
-  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
-
-int snd_cs4231_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
-int snd_cs4231_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-int snd_cs4231_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
-
-#endif /* __SOUND_CS4231_H */
diff --git a/include/sound/snd_wavefront.h b/include/sound/snd_wavefront.h
index 9688d4b..fa149ca 100644
--- a/include/sound/snd_wavefront.h
+++ b/include/sound/snd_wavefront.h
@@ -1,7 +1,6 @@
 #ifndef __SOUND_SND_WAVEFRONT_H__
 #define __SOUND_SND_WAVEFRONT_H__
 
-#include "cs4231.h"
 #include "mpu401.h"
 #include "hwdep.h"
 #include "rawmidi.h"
diff --git a/include/sound/wss.h b/include/sound/wss.h
new file mode 100644
index 0000000..f0785f9
--- /dev/null
+++ b/include/sound/wss.h
@@ -0,0 +1,175 @@
+#ifndef __SOUND_CS4231_H
+#define __SOUND_CS4231_H
+
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
+ *  Definitions for CS4231 & InterWave chips & compatible chips
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include "control.h"
+#include "pcm.h"
+#include "timer.h"
+
+#include "cs4231-regs.h"
+
+/* defines for codec.mode */
+
+#define CS4231_MODE_NONE	0x0000
+#define CS4231_MODE_PLAY	0x0001
+#define CS4231_MODE_RECORD	0x0002
+#define CS4231_MODE_TIMER	0x0004
+#define CS4231_MODE_OPEN	(CS4231_MODE_PLAY|CS4231_MODE_RECORD|CS4231_MODE_TIMER)
+
+/* defines for codec.hardware */
+
+#define CS4231_HW_DETECT        0x0000	/* let CS4231 driver detect chip */
+#define CS4231_HW_DETECT3	0x0001	/* allow mode 3 */
+#define CS4231_HW_TYPE_MASK	0xff00	/* type mask */
+#define CS4231_HW_CS4231_MASK   0x0100	/* CS4231 serie */
+#define CS4231_HW_CS4231        0x0100	/* CS4231 chip */
+#define CS4231_HW_CS4231A       0x0101	/* CS4231A chip */
+#define CS4231_HW_AD1845	0x0102	/* AD1845 chip */
+#define CS4231_HW_CS4232_MASK   0x0200	/* CS4232 serie (has control ports) */
+#define CS4231_HW_CS4232        0x0200	/* CS4232 */
+#define CS4231_HW_CS4232A       0x0201	/* CS4232A */
+#define CS4231_HW_CS4236	0x0202	/* CS4236 */
+#define CS4231_HW_CS4236B_MASK	0x0400	/* CS4236B serie (has extended control regs) */
+#define CS4231_HW_CS4235	0x0400	/* CS4235 - Crystal Clear (tm) stereo enhancement */
+#define CS4231_HW_CS4236B       0x0401	/* CS4236B */
+#define CS4231_HW_CS4237B       0x0402	/* CS4237B - SRS 3D */
+#define CS4231_HW_CS4238B	0x0403	/* CS4238B - QSOUND 3D */
+#define CS4231_HW_CS4239	0x0404	/* CS4239 - Crystal Clear (tm) stereo enhancement */
+/* compatible, but clones */
+#define CS4231_HW_INTERWAVE     0x1000	/* InterWave chip */
+#define CS4231_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
+#define CS4231_HW_OPTI93X 	0x1102	/* Opti 930/931/933 */
+
+/* defines for codec.hwshare */
+#define CS4231_HWSHARE_IRQ	(1<<0)
+#define CS4231_HWSHARE_DMA1	(1<<1)
+#define CS4231_HWSHARE_DMA2	(1<<2)
+
+struct snd_cs4231 {
+	unsigned long port;		/* base i/o port */
+	struct resource *res_port;
+	unsigned long cport;		/* control base i/o port (CS4236) */
+	struct resource *res_cport;
+	int irq;			/* IRQ line */
+	int dma1;			/* playback DMA */
+	int dma2;			/* record DMA */
+	unsigned short version;		/* version of CODEC chip */
+	unsigned short mode;		/* see to CS4231_MODE_XXXX */
+	unsigned short hardware;	/* see to CS4231_HW_XXXX */
+	unsigned short hwshare;		/* shared resources */
+	unsigned short single_dma:1,	/* forced single DMA mode (GUS 16-bit daughter board) or dma1 == dma2 */
+		       ebus_flag:1;	/* SPARC: EBUS present */
+
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+	struct snd_timer *timer;
+
+	unsigned char image[32];	/* registers image */
+	unsigned char eimage[32];	/* extended registers image */
+	unsigned char cimage[16];	/* control registers image */
+	int mce_bit;
+	int calibrate_mute;
+	int sw_3d_bit;
+	unsigned int p_dma_size;
+	unsigned int c_dma_size;
+
+	spinlock_t reg_lock;
+	struct mutex mce_mutex;
+	struct mutex open_mutex;
+
+	int (*rate_constraint) (struct snd_pcm_runtime *runtime);
+	void (*set_playback_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char pdfr);
+	void (*set_capture_format) (struct snd_cs4231 *chip, struct snd_pcm_hw_params *hw_params, unsigned char cdfr);
+	void (*trigger) (struct snd_cs4231 *chip, unsigned int what, int start);
+#ifdef CONFIG_PM
+	void (*suspend) (struct snd_cs4231 *chip);
+	void (*resume) (struct snd_cs4231 *chip);
+#endif
+	void *dma_private_data;
+	int (*claim_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
+	int (*release_dma) (struct snd_cs4231 *chip, void *dma_private_data, int dma);
+};
+
+/* exported functions */
+
+void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
+unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg);
+void snd_cs4236_ext_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char val);
+unsigned char snd_cs4236_ext_in(struct snd_cs4231 *chip, unsigned char reg);
+void snd_cs4231_mce_up(struct snd_cs4231 *chip);
+void snd_cs4231_mce_down(struct snd_cs4231 *chip);
+
+void snd_cs4231_overrange(struct snd_cs4231 *chip);
+
+irqreturn_t snd_cs4231_interrupt(int irq, void *dev_id);
+
+const char *snd_cs4231_chip_id(struct snd_cs4231 *chip);
+
+int snd_cs4231_create(struct snd_card *card,
+		      unsigned long port,
+		      unsigned long cport,
+		      int irq, int dma1, int dma2,
+		      unsigned short hardware,
+		      unsigned short hwshare,
+		      struct snd_cs4231 ** rchip);
+int snd_cs4231_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
+int snd_cs4231_timer(struct snd_cs4231 * chip, int device, struct snd_timer **rtimer);
+int snd_cs4231_mixer(struct snd_cs4231 * chip);
+
+int snd_cs4236_create(struct snd_card *card,
+		      unsigned long port,
+		      unsigned long cport,
+		      int irq, int dma1, int dma2,
+		      unsigned short hardware,
+		      unsigned short hwshare,
+		      struct snd_cs4231 ** rchip);
+int snd_cs4236_pcm(struct snd_cs4231 * chip, int device, struct snd_pcm **rpcm);
+int snd_cs4236_mixer(struct snd_cs4231 * chip);
+
+/*
+ *  mixer library
+ */
+
+#define CS4231_SINGLE(xname, xindex, reg, shift, mask, invert) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .info = snd_cs4231_info_single, \
+  .get = snd_cs4231_get_single, .put = snd_cs4231_put_single, \
+  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
+
+int snd_cs4231_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
+int snd_cs4231_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int snd_cs4231_put_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+
+#define CS4231_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .info = snd_cs4231_info_double, \
+  .get = snd_cs4231_get_double, .put = snd_cs4231_put_double, \
+  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
+
+int snd_cs4231_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
+int snd_cs4231_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int snd_cs4231_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+
+#endif /* __SOUND_CS4231_H */
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 154e728..a24db09 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -38,7 +38,7 @@
 #include <linux/moduleparam.h>
 #include <sound/core.h>
 #include <sound/initval.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index e9462b9..7da28e7 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -27,7 +27,7 @@
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index dbe63db..7b9a3cc 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -26,7 +26,7 @@
 #include <linux/pnp.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 #include <sound/initval.h>
diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index de71910..eb227d8 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -85,7 +85,7 @@
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/asoundef.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index f87c623..cd82891 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -28,7 +28,7 @@
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/gus.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index ca0d7ac..eac8cc7 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -32,7 +32,7 @@
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/gus.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #ifdef SNDRV_STB
 #include <sound/tea6330t.h>
 #endif
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 854a9f7..e81cbe8 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -28,7 +28,7 @@
 #include <linux/pnp.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 #include <sound/initval.h>
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 2a1e2f5..59f7c55 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/opl4.h>
 #include <sound/control.h>
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 0797ca4..93a03d9 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -34,7 +34,7 @@
 #include <asm/dma.h>
 #include <sound/core.h>
 #if defined(CS4231) || defined(OPTi93X)
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #else
 #include <sound/ad1848.h>
 #endif	/* CS4231 */
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 06ad786..1dc4224 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -31,7 +31,7 @@
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/hwdep.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 3a6c6fe..2fb058b 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -29,6 +29,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/opl3.h>
+#include <sound/wss.h>
 #include <sound/snd_wavefront.h>
 
 MODULE_AUTHOR("Paul Barton-Davis <pbd@op.net>");
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index c5795f3..549e6ab 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -31,7 +31,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
-#include <sound/cs4231.h>
+#include <sound/wss.h>
 #include <sound/pcm_params.h>
 
 #include <asm/io.h>
-- 
1.5.5


----------------------------------------------------------------------
Partyjka w Chinczyka?
Graj >>> http://link.interia.pl/f1e67
