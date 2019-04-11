From: libin.yang@intel.com
Subject: [PATCH 12/12] ASoC: intel: skl_nau88l25_ssm4567 add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 17:34:59 +0800
Message-ID: <1554975299-25343-13-git-send-email-libin.yang@intel.com>
References: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48236F89726
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 11:51:17 +0200 (CEST)
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

This patch adds the device_link between skl_nau88l25_ssm4567 machine
device(consumer) and hdmi codec device (supplier) to make sure the sequence
is always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 8433c52..949f1eb 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -28,6 +28,7 @@
 #include <sound/pcm_params.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "hdac_hdmi_common.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_SSM_CODEC_DAI	"ssm4567-hifi"
@@ -46,6 +47,7 @@ struct skl_hdmi_pcm {
 
 struct skl_nau88125_private {
 	struct list_head hdmi_pcm_list;
+	struct device_link *link;
 };
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
@@ -232,7 +234,8 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
@@ -250,7 +253,8 @@ static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 
@@ -269,7 +273,8 @@ static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
@@ -719,8 +724,17 @@ static const struct platform_device_id skl_board_ids[] = {
 	{ }
 };
 
+static int skylake_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(card);
+
+	return hdac_hdmi_del_device_link(&ctx->link);
+}
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
+	.remove = skylake_audio_remove,
 	.driver = {
 		.name = "skl_n88l25_s4567",
 		.pm = &snd_soc_pm_ops,
-- 
2.7.4
