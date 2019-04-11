From: libin.yang@intel.com
Subject: [PATCH 01/12] ASoC: intel: skl_hda_dsp_generic: add
	device_link to HDMI audio
Date: Thu, 11 Apr 2019 17:34:48 +0800
Message-ID: <1554975299-25343-2-git-send-email-libin.yang@intel.com>
References: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A863F89625
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 11:51:02 +0200 (CEST)
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

This patch adds the device_link between cAVS generic machine device
(consumer) and hdmi codec device (supplier) to make sure the sequence is
always correct.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 22 ++++++++++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 12 ++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 3fdbf23..9144e38 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -17,6 +17,25 @@
 
 #define NAME_SIZE	32
 
+static int skl_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	/*
+	 * Setup a device_link between machine device and HDMI codec device.
+	 * The machine device is the consumer and the HDMI codec device is
+	 * the supplier. With this setting, we can make sure that the audio
+	 * domain in display power will be always turned on before operating
+	 * on the HDMI audio codec registers.
+	 */
+	if (!ctx->link)
+		ctx->link = device_link_add(rtd->card->dev, dai->dev,
+					    DL_FLAG_RPM_ACTIVE);
+
+	return 0;
+}
+
 int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
 {
 	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
@@ -48,6 +67,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
+		.init = skl_hdmi_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
@@ -57,6 +77,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.cpu_dai_name = "iDisp2 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi2",
+		.init = skl_hdmi_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
@@ -66,6 +87,7 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
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
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index b9a21e6..ceca11e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -166,8 +166,20 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &hda_soc_card);
 }
 
+static int skl_hda_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->link)
+		device_link_del(ctx->link);
+
+	return 0;
+}
+
 static struct platform_driver skl_hda_audio = {
 	.probe = skl_hda_audio_probe,
+	.remove = skl_hda_audio_remove,
 	.driver = {
 		.name = "skl_hda_dsp_generic",
 		.pm = &snd_soc_pm_ops,
-- 
2.7.4
