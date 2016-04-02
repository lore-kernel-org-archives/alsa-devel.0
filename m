From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix codec power state in S3
	during playback" to the asoc tree
Date: Sat, 02 Apr 2016 09:39:20 -0700
Message-ID: <E1amOa0-0002Bx-4q@finisterre>
References: <1459497987-28979-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EB342619D0
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 18:39:27 +0200 (CEST)
In-Reply-To: <1459497987-28979-3-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: hdac_hdmi: Fix codec power state in S3 during playback

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

>From 1b377ccddd14cd04df4b9523a426b34f928002bc Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 1 Apr 2016 13:36:26 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix codec power state in S3 during playback

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 83 ++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index da3432c9f64d..aaa038ffc8a5 100644
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
2.8.0.rc3
