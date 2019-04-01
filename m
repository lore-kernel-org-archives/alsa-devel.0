From: libin.yang@intel.com
Subject: [PATCH V2] ASoC: hdac_hdmi: add device PM dependency
Date: Mon,  1 Apr 2019 12:50:51 +0800
Message-ID: <1554094251-25910-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B970F8075C
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 07:07:05 +0200 (CEST)
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

HDMI audio codec register operation depends on the display audio power
domain. The hdmi audio codec dapm event callback must be called after
display audio power is turned on.

Add hdac_hdmi_device_link_add() in HDMI audio codec driver. The customer
audio driver, such as cAVS/SST and SOF audio driver, can call the function
to set the audio power dependency.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 sound/soc/codecs/hdac_hdmi.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..c991407 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1792,6 +1792,18 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
 
+struct device_link *
+hdac_hdmi_device_link_add(struct device *consumer,
+			  struct snd_soc_component *component,
+			  u32 flags)
+{
+	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+	struct hdac_device *hdev = hdmi->hdev;
+
+	return device_link_add(consumer, &hdev->dev, flags);
+}
+EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_add);
+
 static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
 			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
 {
diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
index 4fa2fc9..9239c6b 100644
--- a/sound/soc/codecs/hdac_hdmi.h
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -7,4 +7,10 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
 
 int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
 			struct snd_soc_dapm_context *dapm);
+
+struct device_link *
+hdac_hdmi_device_link_add(struct device *consumer,
+			  struct snd_soc_component *component,
+			  u32 flags);
+
 #endif /* __HDAC_HDMI_H__ */
-- 
2.7.4
