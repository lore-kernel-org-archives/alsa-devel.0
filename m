From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH] ASoC: Intel: Power down links before turning
	off display audio power
Date: Fri, 22 Jun 2018 14:55:51 +0530
Message-ID: <1529659551-22902-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D2F2676C7
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:37:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On certain platforms, Display HDMI HDA codec was not going to sleep state
after the use when links are powered down after turning off the display
power. As per the HW recommendation, links are powered down before turning
off the display power to ensure that the codec goes to sleep state.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c  | 12 +++++-------
 sound/soc/intel/skylake/skl.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a36e4b..b78fd84bf591 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2127,12 +2127,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	 */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D3);
-	err = snd_hdac_display_power(bus, false);
-	if (err < 0) {
-		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-		return err;
-	}
-
 	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
 	if (!hlink) {
 		dev_err(dev, "hdac link not found\n");
@@ -2141,7 +2135,11 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(ebus, hlink);
 
-	return 0;
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0)
+		dev_err(bus->dev, "Cannot turn off display power on i915\n");
+
+	return err;
 }
 
 static int hdac_hdmi_runtime_resume(struct device *dev)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 670ff9aaca55..c62e474717ff 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -762,6 +762,12 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * we are done probing so decrement link counts
+	 */
+	list_for_each_entry(hlink, &ebus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(ebus, hlink);
+
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
 		if (err < 0) {
@@ -771,11 +777,6 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
-	/*
-	 * we are done probing so decrement link counts
-	 */
-	list_for_each_entry(hlink, &ebus->hlink_list, list)
-		snd_hdac_ext_bus_link_put(ebus, hlink);
 
 	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
-- 
2.7.4
