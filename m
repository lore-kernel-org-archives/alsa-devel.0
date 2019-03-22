From: libin.yang@intel.com
Subject: [PATCH V2] ASoC: fix hdmi codec driver contest in S3
Date: Fri, 22 Mar 2019 14:24:56 +0800
Message-ID: <1553235896-8185-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8775EF8076F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 07:41:21 +0100 (CET)
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
Cc: libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

In S3, there is a contest between dapm event and getting display power.

When resume, the sequence is:

hdac_hdmi_runtime_resume()
  => snd_hdac_display_power()
hdac_hdmi_xxx_widget_event()

The hdac_hdmi_xxx_widget_event() are based on the power being on.
Otherwise, the operation on the codec register will fail.

However, in snd_hdac_display_power(), it may sleep because of the
mutex_lock() in display driver. In this case, hdac_hdmi_xxx_widget_event()
will be called before the power is on.

Let's not operate the registers and wait for the power in
hdac_hdmi_xxx_widget_event()

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..3c5c122 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -144,6 +144,7 @@ struct hdac_hdmi_priv {
 	int num_pin;
 	int num_cvt;
 	int num_ports;
+	int display_power;	/* 0: power off; 1 power on */
 	struct mutex pin_mutex;
 	struct hdac_chmap chmap;
 	struct hdac_hdmi_drv_data *drv_data;
@@ -742,12 +743,27 @@ static void hdac_hdmi_set_amp(struct hdac_device *hdev,
 					AC_VERB_SET_AMP_GAIN_MUTE, val);
 }
 
+static int wait_for_display_power(struct hdac_hdmi_priv *hdmi)
+{
+	int i = 0;
+
+	/* sleep for totally 80ms ~ 200ms should be enough */
+	while (i < 40) {
+		if (!hdmi->display_power)
+			usleep_range(2000, 5000);
+		else
+			return 0;
+		i++;
+	}
+	return -EAGAIN;
+}
 
 static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *kc, int event)
 {
 	struct hdac_hdmi_port *port = w->priv;
 	struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm;
 
 	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
@@ -757,6 +773,11 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 	if (!pcm)
 		return -EIO;
 
+	if (wait_for_display_power(hdmi)) {
+		dev_err(&hdev->dev, "%s: hdmi power is not ready\n", __func__);
+		return -EAGAIN;
+	}
+
 	/* set the device if pin is mst_capable */
 	if (hdac_hdmi_port_select_set(hdev, port) < 0)
 		return -EIO;
@@ -803,6 +824,11 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
 	if (!pcm)
 		return -EIO;
 
+	if (wait_for_display_power(hdmi)) {
+		dev_err(&hdev->dev, "%s: hdmi power is not ready\n", __func__);
+		return -EAGAIN;
+	}
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D0);
@@ -840,6 +866,7 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 {
 	struct hdac_hdmi_port *port = w->priv;
 	struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	int mux_idx;
 
 	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
@@ -850,6 +877,11 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 
 	mux_idx = dapm_kcontrol_get_value(kc);
 
+	if (wait_for_display_power(hdmi)) {
+		dev_err(&hdev->dev, "%s: hdmi power is not ready\n", __func__);
+		return -EAGAIN;
+	}
+
 	/* set the device if pin is mst_capable */
 	if (hdac_hdmi_port_select_set(hdev, port) < 0)
 		return -EIO;
@@ -2068,6 +2100,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_ext_link *hlink = NULL;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -2095,6 +2128,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
 	snd_hdac_display_power(bus, hdev->addr, false);
+	hdmi->display_power = 0;
 
 	return 0;
 }
@@ -2102,6 +2136,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 static int hdac_hdmi_runtime_resume(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_bus *bus = hdev->bus;
 	struct hdac_ext_link *hlink = NULL;
 
@@ -2128,6 +2163,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
 
+	hdmi->display_power = 1;
 	return 0;
 }
 #else
-- 
2.7.4
