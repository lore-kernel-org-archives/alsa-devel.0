From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 06/12] ASoC: hdac_hdmi: use get_edev helper
	from core
Date: Mon, 29 Aug 2016 11:53:20 +0530
Message-ID: <1472451806-10605-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 89178266E3C
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:43 +0200 (CEST)
In-Reply-To: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e181b2..7ab63bd 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -31,6 +31,7 @@
 #include <sound/pcm_drm_eld.h>
 #include <sound/hda_chmap.h>
 #include "../../hda/local.h"
+#include "../../hda/ext/hdac_codec.h"
 #include "hdac_hdmi.h"
 
 #define NAME_SIZE	32
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
