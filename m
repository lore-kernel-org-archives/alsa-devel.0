From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 3/6] ASoC: hdac_hdmi: Add PM support for HDMI
Date: Tue, 27 Oct 2015 16:42:14 +0900
Message-ID: <1445931737-30393-4-git-send-email-vinod.koul@intel.com>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C9362260499
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 08:42:51 +0100 (CET)
In-Reply-To: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Power up/down the AFG node during runtime resume/suspend.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bda91a31f839..bc50030e16d7 100644
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
 static int hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 {
 	int err;
@@ -254,11 +261,28 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
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
 
@@ -312,6 +336,45 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
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
@@ -323,6 +386,7 @@ static struct hdac_ext_driver hdmi_driver = {
 	. hdac = {
 		.driver = {
 			.name   = "HDMI HDA Codec",
+			.pm = &hdac_hdmi_pm,
 		},
 		.id_table       = hdmi_list,
 	},
-- 
2.4.3
