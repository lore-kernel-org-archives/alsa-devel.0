From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Power down links before turning
	off display audio power
Date: Fri,  9 Nov 2018 11:37:12 -0600
Message-ID: <20181109173712.26925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 88AFC2677E4
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 18:37:20 +0100 (CET)
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
Cc: tiwai@suse.de, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/hdac_hdmi.c  | 13 +++++++------
 sound/soc/intel/skylake/skl.c | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e9854889a95..e0fe682cea04 100644
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
@@ -2201,7 +2196,13 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	return 0;
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0) {
+		dev_err(dev, "Cannot turn off display power on i915\n");
+		return err;
+	}
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
2.17.1
