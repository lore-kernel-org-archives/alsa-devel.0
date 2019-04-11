From: libin.yang@intel.com
Subject: [PATCH 05/12] ASoC: intel: glk_rt5682_max98357a: add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 17:34:52 +0800
Message-ID: <1554975299-25343-6-git-send-email-libin.yang@intel.com>
References: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD5C7F8971A
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 11:51:07 +0200 (CEST)
In-Reply-To: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, libin.yang@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

In resume from S3, HDAC HDMI codec driver dapm event callback may be
operated before HDMI codec driver turns on the display audio power
domain because of the contest between display driver and hdmi codec driver.

This patch adds the device_link between glk_rt5682_max98357a machine device
(consumer) and hdmi codec device (supplier) to make sure the sequence is
always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index d17126f..f35ea41 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -20,6 +20,7 @@
 #include "../skylake/skl.h"
 #include "../../codecs/rt5682.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "hdac_hdmi_common.h"
 
 /* The platform clock outputs 19.2Mhz clock to codec as I2S MCLK */
 #define GLK_PLAT_CLK_FREQ 19200000
@@ -42,6 +43,7 @@ struct glk_hdmi_pcm {
 struct glk_card_private {
 	struct snd_soc_jack geminilake_headset;
 	struct list_head hdmi_pcm_list;
+	struct device_link *link;
 };
 
 enum {
@@ -218,7 +220,8 @@ static int geminilake_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int geminilake_rt5682_fe_init(struct snd_soc_pcm_runtime *rtd)
@@ -607,8 +610,17 @@ static const struct platform_device_id glk_board_ids[] = {
 	{ }
 };
 
+static int geminilake_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct glk_card_private *ctx = snd_soc_card_get_drvdata(card);
+
+	return hdac_hdmi_del_device_link(&ctx->link);
+}
+
 static struct platform_driver geminilake_audio = {
 	.probe = geminilake_audio_probe,
+	.remove = geminilake_audio_remove,
 	.driver = {
 		.name = "glk_rt5682_max98357a",
 		.pm = &snd_soc_pm_ops,
-- 
2.7.4
