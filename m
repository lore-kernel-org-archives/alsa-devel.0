From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add PM support for HDMI" to
	the asoc tree
Date: Sat, 21 Nov 2015 14:01:11 +0000
Message-ID: <E1a08j1-0001Ar-Bx@finisterre>
References: <1447161130-24889-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4632261A8E
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:01:31 +0100 (CET)
In-Reply-To: <1447161130-24889-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add PM support for HDMI

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e342ac08d0d57be81e5defb131f014b4ce27b107 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 10 Nov 2015 18:42:07 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add PM support for HDMI

Power up/down the AFG node during runtime resume/suspend.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d37d688..45dfc4f 100644
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
2.6.1
