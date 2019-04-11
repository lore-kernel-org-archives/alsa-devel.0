From: libin.yang@intel.com
Subject: [PATCH v3 08/12] ASoC: intel: kbl_rt5660: add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 22:19:56 +0800
Message-ID: <1554992400-28777-9-git-send-email-libin.yang@intel.com>
References: <1554992400-28777-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3854F8971E
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 16:36:12 +0200 (CEST)
In-Reply-To: <1554992400-28777-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

In resume from S3, HDAC HDMI codec driver dapm event callback may be
operated before HDMI codec driver turns on the display audio power
domain because of the contest between display driver and hdmi codec driver.

This patch adds the device_link between kbl_rt5660 machine device
(consumer) and hdmi codec device (supplier) to make sure the sequence is
always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/kbl_rt5660.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 3255e00..e681984 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -23,6 +23,7 @@
 
 #include "../../codecs/hdac_hdmi.h"
 #include "../../codecs/rt5660.h"
+#include "hdac_hdmi_common.h"
 
 #define KBL_RT5660_CODEC_DAI "rt5660-aif1"
 #define DUAL_CHANNEL 2
@@ -41,6 +42,7 @@ struct kbl_hdmi_pcm {
 struct kbl_codec_private {
 	struct gpio_desc *gpio_lo_mute;
 	struct list_head hdmi_pcm_list;
+	struct device_link *link;
 };
 
 enum {
@@ -222,7 +224,8 @@ static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.7.4
