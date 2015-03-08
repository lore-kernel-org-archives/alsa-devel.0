From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 5/5] ALSA: hdalib: rename common header files as
	hdalib_*
Date: Sun,  8 Mar 2015 20:07:59 +0530
Message-ID: <1425825479-28780-6-git-send-email-vinod.koul@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 588D62604BC
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:35 +0100 (CET)
In-Reply-To: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Hardik T Shah <hardik.t.shah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Here we rename the common header files to hdalib. This is last big file move
patch. Here the files in sound/hda/ and sound/pci/hda are modified to use
new headers

TODO: fix other patch files and other code in sound/pci/hda

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/{hda_priv.h => hda_register.h}       |   10 +++-------
 .../{hda_auto_parser.h => hdalib_auto_parser.h}    |    6 +++---
 include/sound/{hda_beep.h => hdalib_beep.h}        |    6 +++---
 include/sound/{hda_codec.h => hdalib_codec.h}      |   13 ++++++-------
 .../{hda_controller.h => hdalib_controller.h}      |   11 ++++++-----
 include/sound/{hda_local.h => hdalib_controls.h}   |    6 +++---
 include/sound/{hda_generic.h => hdalib_generic.h}  |    6 +++---
 include/sound/{hda_hwdep.h => hdalib_hwdep.h}      |    4 ++--
 include/sound/{hda_jack.h => hdalib_jack.h}        |    6 +++---
 sound/hda/hdalib_auto_parser.c                     |    7 ++++---
 sound/hda/hdalib_beep.c                            |    6 ++++--
 sound/hda/hdalib_codec.c                           |   17 ++++++++---------
 sound/hda/hdalib_controller.c                      |   10 +++++++---
 sound/hda/hdalib_eld.c                             |    4 ++--
 sound/hda/hdalib_generic.c                         |   13 +++++++------
 sound/hda/hdalib_hwdep.c                           |    6 +++---
 sound/hda/hdalib_jack.c                            |    8 ++++----
 sound/hda/hdalib_proc.c                            |    5 +++--
 sound/hda/hdalib_sysfs.c                           |    6 +++---
 sound/pci/hda/hda_i915.c                           |    3 ++-
 sound/pci/hda/hda_intel.c                          |    7 ++++---
 sound/pci/hda/patch_hdmi.c                         |   10 +++++++++-
 sound/pci/hda/patch_realtek.c                      |   10 +++++++---
 23 files changed, 99 insertions(+), 81 deletions(-)
 rename include/sound/{hda_priv.h => hda_register.h} (98%)
 rename include/sound/{hda_auto_parser.h => hdalib_auto_parser.h} (96%)
 rename include/sound/{hda_beep.h => hdalib_beep.h} (95%)
 rename include/sound/{hda_codec.h => hdalib_codec.h} (98%)
 rename include/sound/{hda_controller.h => hdalib_controller.h} (90%)
 rename include/sound/{hda_local.h => hdalib_controls.h} (99%)
 rename include/sound/{hda_generic.h => hdalib_generic.h} (99%)
 rename include/sound/{hda_hwdep.h => hdalib_hwdep.h} (95%)
 rename include/sound/{hda_jack.h => hdalib_jack.h} (96%)

diff --git a/include/sound/hda_priv.h b/include/sound/hda_register.h
similarity index 98%
rename from include/sound/hda_priv.h
rename to include/sound/hda_register.h
index 166e3e84b963..9f8a37b19de7 100644
--- a/include/sound/hda_priv.h
+++ b/include/sound/hda_register.h
@@ -12,12 +12,8 @@
  *  more details.
  */
 
-#ifndef __SOUND_HDA_PRIV_H
-#define __SOUND_HDA_PRIV_H
-
-#include <linux/clocksource.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
+#ifndef __SOUND_HDA_REGISTER_H
+#define __SOUND_HDA_REGISTER_H
 
 /*
  * registers
@@ -403,4 +399,4 @@ struct azx {
 #define azx_sd_readb(chip, dev, reg) \
 	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
 
-#endif /* __SOUND_HDA_PRIV_H */
+#endif /* __SOUND_HDA_REGISTER_H */
diff --git a/include/sound/hda_auto_parser.h b/include/sound/hdalib_auto_parser.h
similarity index 96%
rename from include/sound/hda_auto_parser.h
rename to include/sound/hdalib_auto_parser.h
index 2b8e29fd73e7..c011cbf50196 100644
--- a/include/sound/hda_auto_parser.h
+++ b/include/sound/hdalib_auto_parser.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef __SOUND_HDA_AUTO_PARSER_H
-#define __SOUND_HDA_AUTO_PARSER_H
+#ifndef __SOUND_HDALIB_AUTO_PARSER_H
+#define __SOUND_HDALIB_AUTO_PARSER_H
 
 /*
  * Helper for automatic pin configuration
@@ -116,4 +116,4 @@ static inline const hda_nid_t *auto_cfg_speaker_pins(const struct auto_pin_cfg *
 	       cfg->line_out_pins : cfg->speaker_pins;
 }
 
-#endif /* __SOUND_HDA_AUTO_PARSER_H */
+#endif /* __SOUND_HDALIB_AUTO_PARSER_H */
diff --git a/include/sound/hda_beep.h b/include/sound/hdalib_beep.h
similarity index 95%
rename from include/sound/hda_beep.h
rename to include/sound/hdalib_beep.h
index a63b5e077332..cb3ff5cab495 100644
--- a/include/sound/hda_beep.h
+++ b/include/sound/hdalib_beep.h
@@ -19,10 +19,10 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#ifndef __SOUND_HDA_BEEP_H
-#define __SOUND_HDA_BEEP_H
+#ifndef __SOUND_HDALIB_BEEP_H
+#define __SOUND_HDALIB_BEEP_H
 
-#include "hda_codec.h"
+#include "hdalib_codec.h"
 
 #define HDA_BEEP_MODE_OFF	0
 #define HDA_BEEP_MODE_ON	1
diff --git a/include/sound/hda_codec.h b/include/sound/hdalib_codec.h
similarity index 98%
rename from include/sound/hda_codec.h
rename to include/sound/hdalib_codec.h
index f5d7717dfca6..459ba6a182ef 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hdalib_codec.h
@@ -1,8 +1,11 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
+ * Copyright (c) 2014 Intel Corporation
  * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
  *
+ * Modified by: Lakshmi Vinnakota <lakshmi.n.vinnakota@intel.com>
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the Free
  *  Software Foundation; either version 2 of the License, or (at your option)
@@ -12,14 +15,10 @@
  *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  *  more details.
- *
- *  You should have received a copy of the GNU General Public License along with
- *  this program; if not, write to the Free Software Foundation, Inc., 59
- *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#ifndef __SOUND_HDA_CODEC_H
-#define __SOUND_HDA_CODEC_H
+#ifndef __SOUND_HDALIB_CODEC_H
+#define __SOUND_HDALIB_CODEC_H
 
 #include <sound/info.h>
 #include <sound/control.h>
@@ -687,4 +686,4 @@ snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
 				struct snd_dma_buffer *dmab) {}
 #endif
 
-#endif /* __SOUND_HDA_CODEC_H */
+#endif /* __SOUND_HDALIB_CODEC_H */
diff --git a/include/sound/hda_controller.h b/include/sound/hdalib_controller.h
similarity index 90%
rename from include/sound/hda_controller.h
rename to include/sound/hdalib_controller.h
index c90d10fd4d8f..d3e70f5d1a08 100644
--- a/include/sound/hda_controller.h
+++ b/include/sound/hdalib_controller.h
@@ -12,13 +12,14 @@
  *  more details.
  */
 
-#ifndef __SOUND_HDA_CONTROLLER_H
-#define __SOUND_HDA_CONTROLLER_H
+#ifndef __SOUND_HDALIB_CONTROLLER_H
+#define __SOUND_HDALIB_CONTROLLER_H
 
 #include <sound/core.h>
 #include <sound/initval.h>
-#include "hda_codec.h"
-#include "hda_priv.h"
+#include "hdalib_codec.h"
+#include "hdalib_controls.h"
+#include "hda_register.h"
 
 /* PCM setup */
 static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
@@ -53,4 +54,4 @@ int azx_init_stream(struct azx *chip);
 void azx_notifier_register(struct azx *chip);
 void azx_notifier_unregister(struct azx *chip);
 
-#endif /* __SOUND_HDA_CONTROLLER_H */
+#endif /* __SOUND_HDALIB_CONTROLLER_H */
diff --git a/include/sound/hda_local.h b/include/sound/hdalib_controls.h
similarity index 99%
rename from include/sound/hda_local.h
rename to include/sound/hdalib_controls.h
index d5aedd811806..9b3b35462884 100644
--- a/include/sound/hda_local.h
+++ b/include/sound/hdalib_controls.h
@@ -20,8 +20,8 @@
  *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#ifndef __SOUND_HDA_LOCAL_H
-#define __SOUND_HDA_LOCAL_H
+#ifndef __SOUND_HDALIB_CONTROLS_H
+#define __SOUND_HDALIB_CONTROLS_H
 
 /* We abuse kcontrol_new.subdev field to pass the NID corresponding to
  * the given new control.  If id.subdev has a bit flag HDA_SUBDEV_NID_FLAG,
@@ -805,4 +805,4 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen);
 #define codec_info(codec, fmt, args...) dev_info(&(codec)->dev, fmt, ##args)
 #define codec_dbg(codec, fmt, args...) dev_dbg(&(codec)->dev, fmt, ##args)
 
-#endif /* __SOUND_HDA_LOCAL_H */
+#endif /* __SOUND_HDALIB_CONTROLS_H */
diff --git a/include/sound/hda_generic.h b/include/sound/hdalib_generic.h
similarity index 99%
rename from include/sound/hda_generic.h
rename to include/sound/hdalib_generic.h
index 3d852660443a..4e4b455924b8 100644
--- a/include/sound/hda_generic.h
+++ b/include/sound/hdalib_generic.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef __SOUND_HDA_GENERIC_H
-#define __SOUND_HDA_GENERIC_H
+#ifndef __SOUND_HDALIB_GENERIC_H
+#define __SOUND_HDALIB_GENERIC_H
 
 /* table entry for multi-io paths */
 struct hda_multi_io {
@@ -341,4 +341,4 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 					   hda_nid_t nid,
 					   unsigned int power_state);
 
-#endif /* __SOUND_HDA_GENERIC_H */
+#endif /* __SOUND_HDALIB_GENERIC_H */
diff --git a/include/sound/hda_hwdep.h b/include/sound/hdalib_hwdep.h
similarity index 95%
rename from include/sound/hda_hwdep.h
rename to include/sound/hdalib_hwdep.h
index 1c0034e87f22..e54af1d24b5b 100644
--- a/include/sound/hda_hwdep.h
+++ b/include/sound/hdalib_hwdep.h
@@ -18,8 +18,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#ifndef __SOUND_HDA_HWDEP_H
-#define __SOUND_HDA_HWDEP_H
+#ifndef __SOUND_HDALIB_HWDEP_H
+#define __SOUND_HDALIB_HWDEP_H
 
 #define HDA_HWDEP_VERSION	((1 << 16) | (0 << 8) | (0 << 0)) /* 1.0.0 */
 
diff --git a/include/sound/hda_jack.h b/include/sound/hdalib_jack.h
similarity index 96%
rename from include/sound/hda_jack.h
rename to include/sound/hdalib_jack.h
index b279e327a23b..b9f874493343 100644
--- a/include/sound/hda_jack.h
+++ b/include/sound/hdalib_jack.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef __SOUND_HDA_JACK_H
-#define __SOUND_HDA_JACK_H
+#ifndef __SOUND_HDALIB_JACK_H
+#define __SOUND_HDALIB_JACK_H
 
 #include <linux/err.h>
 
@@ -95,4 +95,4 @@ void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res);
 
 void snd_hda_jack_poll_all(struct hda_codec *codec);
 
-#endif /* __SOUND_HDA_JACK_H */
+#endif /* __SOUND_HDALIB_JACK_H */
diff --git a/sound/hda/hdalib_auto_parser.c b/sound/hda/hdalib_auto_parser.c
index e518a74b3d66..e2d11d374040 100644
--- a/sound/hda/hdalib_auto_parser.c
+++ b/sound/hda/hdalib_auto_parser.c
@@ -9,13 +9,14 @@
  * (at your option) any later version.
  */
 
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/sort.h>
 #include <sound/core.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
-#include <sound/hda_auto_parser.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
 
 /*
  * Helper for automatic pin configuration
diff --git a/sound/hda/hdalib_beep.c b/sound/hda/hdalib_beep.c
index dda5b1b6ee1a..0fe9c224f90a 100644
--- a/sound/hda/hdalib_beep.c
+++ b/sound/hda/hdalib_beep.c
@@ -24,8 +24,10 @@
 #include <linux/workqueue.h>
 #include <linux/export.h>
 #include <sound/core.h>
-#include <sound/hda_beep.h>
-#include <sound/hda_local.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_beep.h>
 
 enum {
 	DIGBEEP_HZ_STEP = 46875,	/* 46.875 Hz */
diff --git a/sound/hda/hdalib_codec.c b/sound/hda/hdalib_codec.c
index 46eb8e14c884..df2cd7f00213 100644
--- a/sound/hda/hdalib_codec.c
+++ b/sound/hda/hdalib_codec.c
@@ -1,8 +1,10 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
+ * Copyright (c) 2014 Intel Corporation
  * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
  *
+ * Modified by: Lakshmi Vinnakota <lakshmi.n.vinnakota@intel.com>
  *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -13,10 +15,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
 #include <linux/mm.h>
@@ -27,15 +25,16 @@
 #include <linux/module.h>
 #include <linux/async.h>
 #include <sound/core.h>
-#include <sound/hda_codec.h>
 #include <sound/asoundef.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/jack.h>
-#include <sound/hda_local.h>
-#include <sound/hda_beep.h>
-#include <sound/hda_jack.h>
-#include <sound/hda_hwdep.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_beep.h>
+#include <sound/hdalib_jack.h>
+#include <sound/hdalib_hwdep.h>
 
 #define CREATE_TRACE_POINTS
 #include "hda_trace.h"
diff --git a/sound/hda/hdalib_controller.c b/sound/hda/hdalib_controller.c
index 5ae5fcb9b8a9..b4fc5423925c 100644
--- a/sound/hda/hdalib_controller.c
+++ b/sound/hda/hdalib_controller.c
@@ -1,12 +1,15 @@
 /*
  *
- *  Implementation of primary alsa driver code base for Intel HD Audio.
+ *  Implementation of Common HDA driver funcitons for Intel HD Audio.
  *
+ *  Copyright (c) 2014 Intel Corporation
  *  Copyright(c) 2004 Intel Corporation. All rights reserved.
  *
  *  Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
  *                     PeiSen Hou <pshou@realtek.com.tw>
  *
+ *  Modified by: KP Jeeja <jeeja.kp@intel.com>
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the Free
  *  Software Foundation; either version 2 of the License, or (at your option)
@@ -30,8 +33,9 @@
 #include <linux/reboot.h>
 #include <sound/core.h>
 #include <sound/initval.h>
-#include <sound/hda_priv.h>
-#include <sound/hda_controller.h>
+#include <sound/hdalib_controller.h>
+#include <sound/hda_register.h>
+
 
 #define CREATE_TRACE_POINTS
 #include "hda_intel_trace.h"
diff --git a/sound/hda/hdalib_eld.c b/sound/hda/hdalib_eld.c
index f1b6493c65d9..f5622c8a5286 100644
--- a/sound/hda/hdalib_eld.c
+++ b/sound/hda/hdalib_eld.c
@@ -26,8 +26,8 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <asm/unaligned.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
 
 enum eld_versions {
 	ELD_VER_CEA_861D	= 2,
diff --git a/sound/hda/hdalib_generic.c b/sound/hda/hdalib_generic.c
index bac07550f7be..a2c0fccc0cc9 100644
--- a/sound/hda/hdalib_generic.c
+++ b/sound/hda/hdalib_generic.c
@@ -32,12 +32,13 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/tlv.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
-#include <sound/hda_auto_parser.h>
-#include <sound/hda_jack.h>
-#include <sound/hda_beep.h>
-#include <sound/hda_generic.h>
+#include <sound/control.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_beep.h>
+#include <sound/hdalib_jack.h>
+#include <sound/hdalib_generic.h>
 
 
 /**
diff --git a/sound/hda/hdalib_hwdep.c b/sound/hda/hdalib_hwdep.c
index 8b17ad1cbb1b..4afa6f803cb9 100644
--- a/sound/hda/hdalib_hwdep.c
+++ b/sound/hda/hdalib_hwdep.c
@@ -22,9 +22,9 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <sound/core.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
-#include <sound/hda_hwdep.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_hwdep.h>
 #include <sound/minors.h>
 
 /*
diff --git a/sound/hda/hdalib_jack.c b/sound/hda/hdalib_jack.c
index bcaee91e655e..7c061f18c373 100644
--- a/sound/hda/hdalib_jack.c
+++ b/sound/hda/hdalib_jack.c
@@ -15,10 +15,10 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/jack.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
-#include <sound/hda_auto_parser.h>
-#include <sound/hda_jack.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_jack.h>
 
 /**
  * is_jack_detectable - Check whether the given pin is jack-detectable
diff --git a/sound/hda/hdalib_proc.c b/sound/hda/hdalib_proc.c
index 0f4992f93bf8..5bf040d38ffe 100644
--- a/sound/hda/hdalib_proc.c
+++ b/sound/hda/hdalib_proc.c
@@ -25,8 +25,9 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <linux/module.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_auto_parser.h>
 
 static int dump_coef = -1;
 module_param(dump_coef, int, 0644);
diff --git a/sound/hda/hdalib_sysfs.c b/sound/hda/hdalib_sysfs.c
index b25001cc3f83..07d24cad0c3d 100644
--- a/sound/hda/hdalib_sysfs.c
+++ b/sound/hda/hdalib_sysfs.c
@@ -14,10 +14,10 @@
 #include <linux/string.h>
 #include <linux/export.h>
 #include <sound/core.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_local.h>
-#include <sound/hda_hwdep.h>
 #include <sound/minors.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_hwdep.h>
+#include <sound/hdalib_controls.h>
 
 /* hint string pair */
 struct hda_hint {
diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index ca15d465c8b0..4e614490bdd8 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -20,7 +20,8 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <drm/i915_powerwell.h>
-#include <sound/hda_priv.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hda_register.h>
 #include "hda_i915.h"
 
 /* Intel HSW/BDW display HDA controller Extended Mode registers.
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 70606016843b..89f3a7654170 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -60,9 +60,10 @@
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
-#include <sound/hda_codec.h>
-#include <sound/hda_controller.h>
-#include <sound/hda_priv.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_controller.h>
+#include <sound/hda_register.h>
 #include "hda_i915.h"
 
 /* position fix mode */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b422e406a9cb..99efc88f3d36 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -37,9 +37,17 @@
 #include <sound/jack.h>
 #include <sound/asoundef.h>
 #include <sound/tlv.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_bus.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_jack.h>
+#include <sound/hdalib_generic.h>
+#include <sound/hdalib_hdmi.h>
 #include "hda_codec.h"
+#include "hda_generic.h"
+#include "hda_bus.h"
 #include "hda_local.h"
-#include "hda_jack.h"
 
 static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 65f1f4e18ea5..9058d206dd58 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -31,11 +31,15 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
+#include <sound/hdalib_codec.h>
+#include <sound/hdalib_bus.h>
+#include <sound/hdalib_auto_parser.h>
+#include <sound/hdalib_controls.h>
+#include <sound/hdalib_jack.h>
+#include <sound/hdalib_generic.h>
 #include "hda_codec.h"
-#include "hda_local.h"
-#include "hda_auto_parser.h"
-#include "hda_jack.h"
 #include "hda_generic.h"
+#include "hda_bus.h"
 
 /* keep halting ALC5505 DSP, for power saving */
 #define HALT_REALTEK_ALC5505
-- 
1.7.9.5
