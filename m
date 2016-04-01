From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/3] ASoC: hdac_hdmi: Fix codec power state in
	S3 during playback
Date: Fri,  1 Apr 2016 13:36:26 +0530
Message-ID: <1459497987-28979-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C5642651C7
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 10:07:05 +0200 (CEST)
In-Reply-To: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

If the system enters S3 during a playback, codec power needs to
be turned OFF during suspend and restored during resume. With
this patch the AFG node is set to D3 and codec power is turned
OFF during controller suspend call.

During resume, the codec power is left in ON state if the
playback was in progress while suspending.

Also setting power state for AFG node is optimized. With this the
loop with timeout is removed and codec_read is used instead.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 83 ++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index da3432c..aaa038f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1420,32 +1420,39 @@ static int hdmi_codec_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
+static int hdmi_codec_prepare(struct device *dev)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dev);
+	struct hdac_device *hdac = &edev->hdac;
+
+	pm_runtime_get_sync(&edev->hdac.dev);
+
+	/*
+	 * Power down afg.
+	 * codec_read is preferred over codec_write to set the power state.
+	 * This way verb is send to set the power state and response
+	 * is received. So setting power state is ensured without using loop
+	 * to read the state.
+	 */
+	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
+							AC_PWRST_D3);
+
+	return 0;
+}
+
 static void hdmi_codec_complete(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
-	struct hdac_bus *bus = hdac->bus;
-	int err;
-	unsigned long timeout;
-
-	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
-	hdac_hdmi_skl_enable_dp12(&edev->hdac);
 
 	/* Power up afg */
-	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0)) {
-
-		snd_hdac_codec_write(hdac, hdac->afg, 0,
-			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
+							AC_PWRST_D0);
 
-		/* Wait till power state is set to D0 */
-		timeout = jiffies + msecs_to_jiffies(1000);
-		while (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0)
-				&& time_before(jiffies, timeout)) {
-			msleep(50);
-		}
-	}
+	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
+	hdac_hdmi_skl_enable_dp12(&edev->hdac);
 
 	/*
 	 * As the ELD notify callback request is not entertained while the
@@ -1455,18 +1462,10 @@ static void hdmi_codec_complete(struct device *dev)
 	list_for_each_entry(pin, &hdmi->pin_list, head)
 		hdac_hdmi_present_sense(pin, 1);
 
-	/*
-	 * Codec power is turned ON during controller resume.
-	 * Turn it OFF here
-	 */
-	err = snd_hdac_display_power(bus, false);
-	if (err < 0) {
-		dev_err(bus->dev,
-			"Cannot turn OFF display power on i915, err: %d\n",
-			err);
-	}
+	pm_runtime_put_sync(&edev->hdac.dev);
 }
 #else
+#define hdmi_codec_prepare NULL
 #define hdmi_codec_complete NULL
 #endif
 
@@ -1557,7 +1556,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
-	unsigned long timeout;
 	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -1566,20 +1564,15 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	if (!bus)
 		return 0;
 
-	/* Power down afg */
-	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)) {
-		snd_hdac_codec_write(hdac, hdac->afg, 0,
-			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-
-		/* Wait till power state is set to D3 */
-		timeout = jiffies + msecs_to_jiffies(1000);
-		while (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)
-				&& time_before(jiffies, timeout)) {
-
-			msleep(50);
-		}
-	}
-
+	/*
+	 * Power down afg.
+	 * codec_read is preferred over codec_write to set the power state.
+	 * This way verb is send to set the power state and response
+	 * is received. So setting power state is ensured without using loop
+	 * to read the state.
+	 */
+	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
+							AC_PWRST_D3);
 	err = snd_hdac_display_power(bus, false);
 	if (err < 0) {
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
@@ -1612,9 +1605,8 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	hdac_hdmi_skl_enable_dp12(&edev->hdac);
 
 	/* Power up afg */
-	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
-		snd_hdac_codec_write(hdac, hdac->afg, 0,
-			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
+							AC_PWRST_D0);
 
 	return 0;
 }
@@ -1625,6 +1617,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops hdac_hdmi_pm = {
 	SET_RUNTIME_PM_OPS(hdac_hdmi_runtime_suspend, hdac_hdmi_runtime_resume, NULL)
+	.prepare = hdmi_codec_prepare,
 	.complete = hdmi_codec_complete,
 };
 
-- 
1.9.1
