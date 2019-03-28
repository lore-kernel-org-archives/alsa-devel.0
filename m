From: libin.yang@intel.com
Subject: [PATCH] ASoC: hdmi: implement component supsend/resume
	callback
Date: Thu, 28 Mar 2019 16:40:05 +0800
Message-ID: <1553762405-19897-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7715EF80C16
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 09:56:27 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org
Cc: libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Implement the hdmi codec component driver's suspend/resume callback.
This can make sure that the dapm event is triggered after the display
audio power domain is turned on if bus_control is set.

Also this patch removes the codec device PM suspend/resume.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 51 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..478c6f2 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1873,36 +1873,27 @@ static void hdmi_codec_remove(struct snd_soc_component *component)
 	pm_runtime_disable(&hdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int hdmi_codec_resume(struct device *dev)
+static int hdmi_component_suspend(struct snd_soc_component *component)
 {
-	struct hdac_device *hdev = dev_to_hdac_dev(dev);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	int ret;
+	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+	struct hdac_device *hdev = hdmi->hdev;
 
-	ret = pm_runtime_force_resume(dev);
-	if (ret < 0)
-		return ret;
-	/*
-	 * As the ELD notify callback request is not entertained while the
-	 * device is in suspend state. Need to manually check detection of
-	 * all pins here. pin capablity change is not support, so use the
-	 * already set pin caps.
-	 *
-	 * NOTE: this is safe to call even if the codec doesn't actually resume.
-	 * The pin check involves only with DRM audio component hooks, so it
-	 * works even if the HD-audio side is still dreaming peacefully.
-	 */
-	hdac_hdmi_present_sense_all_pins(hdev, hdmi, false);
-	return 0;
+	return pm_runtime_force_suspend(&hdev->dev);
+}
+
+static int hdmi_component_resume(struct snd_soc_component *component)
+{
+	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+	struct hdac_device *hdev = hdmi->hdev;
+
+	return pm_runtime_force_resume(&hdev->dev);
 }
-#else
-#define hdmi_codec_resume NULL
-#endif
 
 static const struct snd_soc_component_driver hdmi_hda_codec = {
 	.probe			= hdmi_codec_probe,
 	.remove			= hdmi_codec_remove,
+	.suspend		= hdmi_component_suspend,
+	.resume			= hdmi_component_resume,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
 	.non_legacy_dai_naming	= 1,
@@ -2104,6 +2095,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
 	struct hdac_ext_link *hlink = NULL;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
@@ -2128,6 +2120,18 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
 
+	/*
+	 * As the ELD notify callback request is not entertained while the
+	 * device is in suspend state. Need to manually check detection of
+	 * all pins here. pin capablity change is not support, so use the
+	 * already set pin caps.
+	 *
+	 * NOTE: this is safe to call even if the codec doesn't actually resume.
+	 * The pin check involves only with DRM audio component hooks, so it
+	 * works even if the HD-audio side is still dreaming peacefully.
+	 */
+	hdac_hdmi_present_sense_all_pins(hdev, hdmi, false);
+
 	return 0;
 }
 #else
@@ -2137,7 +2141,6 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops hdac_hdmi_pm = {
 	SET_RUNTIME_PM_OPS(hdac_hdmi_runtime_suspend, hdac_hdmi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, hdmi_codec_resume)
 };
 
 static const struct hda_device_id hdmi_list[] = {
-- 
2.7.4
