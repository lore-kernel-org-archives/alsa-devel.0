From: libin.yang@intel.com
Subject: [PATCH 2/2] ASoC: add asoc hdmi audio trigger handler
Date: Mon,  7 Jan 2019 10:11:56 +0800
Message-ID: <1546827116-25269-2-git-send-email-libin.yang@intel.com>
References: <1546827116-25269-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B367D267AC8
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 03:23:27 +0100 (CET)
In-Reply-To: <1546827116-25269-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com, libin.yang@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

The flow of ASoC hdmi audio suspend when playback is:
hdmi_codec_prepare() =>
  snd_hdac_display_power(bus, hdev->addr, true)
  snd_hdac_display_power(bus, hdev->addr, false)
suspend =>
  trigger(suspend) =>
    snd_hdac_display_power(bus, hdev->addr + HDA_CODEC_RT, false)
now, all bitmasks are cleared and display power is turned off.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/hda_component.h |  1 +
 sound/soc/codecs/hdac_hdmi.c  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index 2ec31b3..c7136b1 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -9,6 +9,7 @@
 
 /* virtual idx for controller */
 #define HDA_CODEC_IDX_CONTROLLER	HDA_MAX_CODECS
+#define HDA_CODEC_RT		    (HDA_CODEC_IDX_CONTROLLER + 1)
 
 #ifdef CONFIG_SND_HDA_COMPONENT
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 782b323..908f83d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1383,11 +1383,43 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdev)
 
 }
 
+static int hdac_hdmi_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+				 struct snd_soc_dai *dai)
+{
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = hdmi->hdev;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/*
+		 * Maybe there is a better way to avoid using
+		 * 'hdev->addr + HDA_CODEC_RT' bitmask?
+		 */
+		snd_hdac_display_power(hdev->bus, hdev->addr + HDA_CODEC_RT,
+				       true);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		snd_hdac_display_power(hdev->bus, hdev->addr + HDA_CODEC_RT,
+				       false);
+		break;
+	default:
+		/* Nothing to do */
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup = hdac_hdmi_pcm_open,
 	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
 	.set_tdm_slot = hdac_hdmi_set_tdm_slot,
+	.trigger = hdac_hdmi_pcm_trigger,
 };
 
 /*
@@ -1895,6 +1927,11 @@ static int hdmi_codec_prepare(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 
+	/*
+	 * FIXME: maybe using suspend/resume instead of
+	 * using prepare/complete can make things simpler
+	 * and no need to use 'hdev->addr + HDA_CODEC_RT'?
+	 */
 	snd_hdac_display_power(hdev->bus, hdev->addr, true);
 
 	/*
-- 
2.7.4
