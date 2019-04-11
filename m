From: libin.yang@intel.com
Subject: [PATCH 07/12] ASoC: intel: kbl_da7219_max98927: add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 17:34:54 +0800
Message-ID: <1554975299-25343-8-git-send-email-libin.yang@intel.com>
References: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 772D4F89636
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 11:51:10 +0200 (CEST)
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

This patch adds the device_link between kbl_da7219_max98927 machine device
(consumer) and hdmi codec device (supplier) to make sure the sequence is
always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index f72a7bf..5ae6ddb 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -21,6 +21,7 @@
 #include "../../codecs/hdac_hdmi.h"
 #include "../skylake/skl.h"
 #include "../../codecs/da7219-aad.h"
+#include "hdac_hdmi_common.h"
 
 #define KBL_DIALOG_CODEC_DAI	"da7219-hifi"
 #define MAX98927_CODEC_DAI	"max98927-aif1"
@@ -48,6 +49,7 @@ struct kbl_hdmi_pcm {
 struct kbl_codec_private {
 	struct snd_soc_jack kabylake_headset;
 	struct list_head hdmi_pcm_list;
+	struct device_link *link;
 };
 
 enum {
@@ -339,7 +341,8 @@ static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return 0;
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
 }
 
 static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
@@ -1113,8 +1116,17 @@ static const struct platform_device_id kbl_board_ids[] = {
 	{ }
 };
 
+static int kabylake_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
+
+	return hdac_hdmi_del_device_link(&ctx->link);
+}
+
 static struct platform_driver kabylake_audio = {
 	.probe = kabylake_audio_probe,
+	.remove = kabylake_audio_remove,
 	.driver = {
 		.name = "kbl_da7219_max98_927_373",
 		.pm = &snd_soc_pm_ops,
-- 
2.7.4
