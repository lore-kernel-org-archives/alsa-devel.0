From: libin.yang@intel.com
Subject: [PATCH v3 11/12] ASoC: intel: skl_nau88l25_max98357a
	add device_link to HDMI audio
Date: Thu, 11 Apr 2019 22:19:59 +0800
Message-ID: <1554992400-28777-12-git-send-email-libin.yang@intel.com>
References: <1554992400-28777-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D187F89727
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 16:36:16 +0200 (CEST)
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

This patch adds the device_link between skl_nau88l25_max98357a machine
device(consumer) and hdmi codec device (supplier) to make sure the sequence
is always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 0922106..8685a5b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -24,6 +24,7 @@
 #include <sound/soc-acpi.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "hdac_hdmi_common.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_MAXIM_CODEC_DAI "HiFi"
@@ -42,6 +43,7 @@ struct skl_hdmi_pcm {
 
 struct skl_nau8825_private {
 	struct list_head hdmi_pcm_list;
+	struct device_link *link;
 };
 
 enum {
@@ -202,7 +204,8 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
@@ -220,7 +223,8 @@ static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
@@ -238,7 +242,8 @@ static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.7.4
