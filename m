From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Power down links before turning
	off display audio power" to the asoc tree
Date: Tue, 13 Nov 2018 19:46:47 +0000 (GMT)
Message-ID: <20181113194647.860B4440078@finisterre.ee.mobilebroadband>
References: <20181109193923.30977-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C838B267A61
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 20:46:58 +0100 (CET)
In-Reply-To: <20181109193923.30977-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Sriram Periyasamy <sriramx.periyasamy@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Power down links before turning off display audio power

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4c10473d6ddf12ec124c9ff71a5d23bb5388478b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 9 Nov 2018 13:39:23 -0600
Subject: [PATCH] ASoC: Intel: Power down links before turning off display
 audio power

On certain platforms, Display HDMI HDA codec was not going to sleep state
after the use when links are powered down after turning off the display
power. As per the HW recommendation, links are powered down before turning
off the display power to ensure that the codec goes to sleep state.

This patch was updated from an earlier version submitted upstream [1]
which conflicted with the changes merged for HDaudio codec support
with the Intel DSP.

[1] https://patchwork.kernel.org/patch/10540213/

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c  | 11 +++++------
 sound/soc/intel/skylake/skl.c | 12 ++++++------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e9854889a95..e63d6e33df48 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2187,11 +2187,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	 */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D3);
-	err = snd_hdac_display_power(bus, false);
-	if (err < 0) {
-		dev_err(dev, "Cannot turn on display power on i915\n");
-		return err;
-	}
 
 	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
 	if (!hlink) {
@@ -2201,7 +2196,11 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	return 0;
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0)
+		dev_err(dev, "Cannot turn off display power on i915\n");
+
+	return err;
 }
 
 static int hdac_hdmi_runtime_resume(struct device *dev)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 29225623b4b4..1586c97d9450 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -815,6 +815,12 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * we are done probing so decrement link counts
+	 */
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(bus, hlink);
+
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
 		if (err < 0) {
@@ -824,12 +830,6 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
-	/*
-	 * we are done probing so decrement link counts
-	 */
-	list_for_each_entry(hlink, &bus->hlink_list, list)
-		snd_hdac_ext_bus_link_put(bus, hlink);
-
 	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
-- 
2.19.1
