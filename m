From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH] ASoC: hdac_hdmi: Add documentation for power
	management
Date: Mon, 16 Jul 2018 15:32:34 +0530
Message-ID: <1531735354-13352-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D0E4826739D
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 12:06:52 +0200 (CEST)
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

Add documentation for power management of HDAC HDMI codec device for
various scenarios such as S0/S3, probe and playback use case.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a36e4b..30ccc902e5cf 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2103,6 +2103,75 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 }
 
 #ifdef CONFIG_PM
+/*
+ * Power management sequences
+ * ==========================
+ *
+ * The following explains the PM handling of HDAC HDMI with its parent
+ * device SKL and display power usage
+ *
+ * Probe
+ * -----
+ * In SKL probe,
+ * 1. skl_probe_work() powers up the display (refcount++ -> 1)
+ * 2. enumerates the codecs on the link
+ * 3. powers down the display  (refcount-- -> 0)
+ *
+ * In HDAC HDMI probe,
+ * 1. hdac_hdmi_dev_probe() powers up the display (refcount++ -> 1)
+ * 2. probe the codec
+ * 3. put the HDAC HDMI device to runtime suspend
+ * 4. hdac_hdmi_runtime_suspend() powers down the display (refcount-- -> 0)
+ *
+ * Once children are runtime suspended, SKL device also goes to runtime
+ * suspend
+ *
+ * HDMI Playback
+ * -------------
+ * Open HDMI device,
+ * 1. skl_runtime_resume() invoked
+ * 2. hdac_hdmi_runtime_resume() powers up the display (refcount++ -> 1)
+ *
+ * Close HDMI device,
+ * 1. hdac_hdmi_runtime_suspend() powers down the display (refcount-- -> 0)
+ * 2. skl_runtime_suspend() invoked
+ *
+ * S0/S3 Cycle with playback in progress
+ * -------------------------------------
+ * When the device is opened for playback, the device is runtime active
+ * already and the display refcount is 1 as explained above.
+ *
+ * Entering to S3,
+ * 1. hdmi_codec_prepare() invoke the runtime resume of codec which just
+ *    increments the PM runtime usage count of the codec since the device
+ *    is in use already
+ * 2. skl_suspend() powers down the display (refcount-- -> 0)
+ *
+ * Wakeup from S3,
+ * 1. skl_resume() powers up the display (refcount++ -> 1)
+ * 2. hdmi_codec_complete() invokes the runtime suspend of codec which just
+ *    decrements the PM runtime usage count of the codec since the device
+ *    is in use already
+ *
+ * Once playback is stopped, the display refcount is set to 0 as explained
+ * above in the HDMI playback sequence. The PM handlings are designed in
+ * such way that to balance the refcount of display power when the codec
+ * device put to S3 while playback is going on.
+ *
+ * S0/S3 Cycle without playback in progress
+ * ----------------------------------------
+ * Entering to S3,
+ * 1. hdmi_codec_prepare() invoke the runtime resume of codec
+ * 2. skl_runtime_resume() invoked
+ * 3. hdac_hdmi_runtime_resume() powers up the display (refcount++ -> 1)
+ * 4. skl_suspend() powers down the display (refcount-- -> 0)
+ *
+ * Wakeup from S3,
+ * 1. skl_resume() powers up the display (refcount++ -> 1)
+ * 2. hdmi_codec_complete() invokes the runtime suspend of codec
+ * 3. hdac_hdmi_runtime_suspend() powers down the display (refcount-- -> 0)
+ * 4. skl_runtime_suspend() invoked
+ */
 static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
-- 
2.7.4
