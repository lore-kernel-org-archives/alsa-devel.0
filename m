From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ASoC: SOF: Intel: Add missing include file hdac_hda.h
Date: Fri, 9 Aug 2019 19:01:00 +0800
Message-ID: <20190809110100.71236-1-yuehaibing@huawei.com>
References: <20190809095550.71040-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809095550.71040-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

Building with SND_SOC_SOF_HDA_AUDIO_CODEC fails:

sound/soc/sof/intel/hda-bus.c: In function sof_hda_bus_init:
sound/soc/sof/intel/hda-bus.c:16:25: error: implicit declaration of function
 snd_soc_hdac_hda_get_ops; did you mean snd_soc_jack_add_gpiods? [-Werror=implicit-function-declaration]
 #define sof_hda_ext_ops snd_soc_hdac_hda_get_ops()

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Fixes: d4ff1b3917a5 ('ASoC: SOF: Intel: Initialize hdaudio bus properly")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unused include from hda.c
---
 sound/soc/sof/intel/hda-bus.c | 1 +
 sound/soc/sof/intel/hda.c     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index 0caec3a..1d2babd 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -13,6 +13,7 @@
 #include "hda.h"
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+#include "../../codecs/hdac_hda.h"
 #define sof_hda_ext_ops	snd_soc_hdac_hda_get_ops()
 #else
 #define sof_hda_ext_ops	NULL
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 368254b..ebf2777 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -23,9 +23,6 @@
 #include <sound/sof/xtensa.h>
 #include "../ops.h"
 #include "hda.h"
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-#include "../../codecs/hdac_hda.h"
-#endif
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 #include <sound/soc-acpi-intel-match.h>
-- 
2.7.4
