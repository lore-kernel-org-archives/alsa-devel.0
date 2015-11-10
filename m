From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 3/6] ASoC: hdac_hdmi: Add PM support for HDMI
Date: Tue, 10 Nov 2015 18:42:07 +0530
Message-ID: <1447161130-24889-4-git-send-email-vinod.koul@intel.com>
References: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 33AE526513A
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 14:08:55 +0100 (CET)
In-Reply-To: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Power up/down the AFG node during runtime resume/suspend.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d37d688fa40a..45dfc4f608e5 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -60,6 +60,13 @@ struct hdac_hdmi_priv {
 	struct hdac_hdmi_dai_pin_map dai_map[3];
 };
 
+static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
+{
+	struct hdac_device *hdac = container_of(dev, struct hdac_device, dev);
+
+	return container_of(hdac, struct hdac_ext_device, hdac);
+}
+
 static int
 hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 {
@@ -250,11 +257,28 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
 
+	/*
+	 * hdac_device core already sets the state to active and calls
+	 * get_noresume. So enable runtime and set the device to suspend.
+	 */
+	pm_runtime_enable(&edev->hdac.dev);
+	pm_runtime_put(&edev->hdac.dev);
+	pm_runtime_suspend(&edev->hdac.dev);
+
+	return 0;
+}
+
+static int hdmi_codec_remove(struct snd_soc_codec *codec)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+
+	pm_runtime_disable(&edev->hdac.dev);
 	return 0;
 }
 
 static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.probe		= hdmi_codec_probe,
+	.remove		= hdmi_codec_remove,
 	.idle_bias_off	= true,
 };
 
@@ -307,6 +331,45 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int hdac_hdmi_runtime_suspend(struct device *dev)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dev);
+	struct hdac_device *hdac = &edev->hdac;
+
+	dev_dbg(dev, "Enter: %s\n", __func__);
+
+	/* Power down afg */
+	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3))
+		snd_hdac_codec_write(hdac, hdac->afg, 0,
+			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+
+	return 0;
+}
+
+static int hdac_hdmi_runtime_resume(struct device *dev)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dev);
+	struct hdac_device *hdac = &edev->hdac;
+
+	dev_dbg(dev, "Enter: %s\n", __func__);
+
+	/* Power up afg */
+	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
+		snd_hdac_codec_write(hdac, hdac->afg, 0,
+			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+	return 0;
+}
+#else
+#define hdac_hdmi_runtime_suspend NULL
+#define hdac_hdmi_runtime_resume NULL
+#endif
+
+static const struct dev_pm_ops hdac_hdmi_pm = {
+	SET_RUNTIME_PM_OPS(hdac_hdmi_runtime_suspend, hdac_hdmi_runtime_resume, NULL)
+};
+
 static const struct hda_device_id hdmi_list[] = {
 	HDA_CODEC_EXT_ENTRY(0x80862809, 0x100000, "Skylake HDMI", 0),
 	{}
@@ -318,6 +381,7 @@ static struct hdac_ext_driver hdmi_driver = {
 	. hdac = {
 		.driver = {
 			.name   = "HDMI HDA Codec",
+			.pm = &hdac_hdmi_pm,
 		},
 		.id_table       = hdmi_list,
 	},
-- 
1.9.1
