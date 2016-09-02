From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 04/11] ALSA: hdac: Move 'to_hda_ext_device'
	helper to core
Date: Fri,  2 Sep 2016 16:34:53 +0530
Message-ID: <1472814300-5629-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id F302E26779A
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:46 +0200 (CEST)
In-Reply-To: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This helper is also useful for generic codec framework. So moving
this to core for reuse.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h  | 8 ++++++++
 sound/soc/codecs/hdac_hdmi.c | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 5be7a59..2113765 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -256,6 +256,14 @@ struct hdac_ext_dma_params {
 };
 #define to_ehdac_device(dev) (container_of((dev), \
 				 struct hdac_ext_device, hdac))
+
+static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
+{
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
+
+	return to_ehdac_device(hdac);
+}
+
 /*
  * HD-audio codec base driver
  */
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e181b2..8a9a5f8 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -30,6 +30,7 @@
 #include <sound/hda_i915.h>
 #include <sound/pcm_drm_eld.h>
 #include <sound/hda_chmap.h>
+#include <sound/hdaudio_ext.h>
 #include "../../hda/local.h"
 #include "hdac_hdmi.h"
 
@@ -127,13 +128,6 @@ static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 	return NULL;
 }
 
-static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
-{
-	struct hdac_device *hdac = dev_to_hdac_dev(dev);
-
-	return to_ehdac_device(hdac);
-}
-
 static unsigned int sad_format(const u8 *sad)
 {
 	return ((sad[0] >> 0x3) & 0x1f);
-- 
1.9.1
