From: libin.yang@intel.com
Subject: [PATCH v3 02/12] ASoC: intel: skl_hda_dsp_generic: add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 22:19:50 +0800
Message-ID: <1554992400-28777-3-git-send-email-libin.yang@intel.com>
References: <1554992400-28777-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AB39F808F6
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 16:36:04 +0200 (CEST)
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

This patch adds the device_link between cAVS generic machine device
(consumer) and hdmi codec device (supplier) to make sure the sequence is
always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/skl_hda_dsp_common.c | 13 +++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 3fdbf23..2a66ac8 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -14,9 +14,19 @@
 #include "../../codecs/hdac_hdmi.h"
 #include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
+#include "hdac_hdmi_common.h"
 
 #define NAME_SIZE	32
 
+static int skl_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	/* Setup a device_link between machine device and HDMI codec device. */
+	return hdac_hdmi_add_device_link(rtd->card->dev, dai->dev, &ctx->link);
+}
+
 int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
 {
 	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
@@ -48,6 +58,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
+		.init = skl_hdmi_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
@@ -57,6 +68,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.cpu_dai_name = "iDisp2 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi2",
+		.init = skl_hdmi_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
@@ -66,6 +78,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.cpu_dai_name = "iDisp3 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi3",
+		.init = skl_hdmi_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
index 87c50af..df5cc6b 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -29,6 +29,7 @@ struct skl_hda_private {
 	int pcm_count;
 	int dai_index;
 	const char *platform_name;
+	struct device_link *link;
 };
 
 extern struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS];
-- 
2.7.4
