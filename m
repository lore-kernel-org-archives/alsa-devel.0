From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 6/6] ASoC: hdac_hdmi: Use i915 component
	framework for PM
Date: Mon, 26 Oct 2015 10:07:53 +0900
Message-ID: <1445821673-4947-7-git-send-email-vinod.koul@intel.com>
References: <1445821673-4947-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6138D2604E4
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 02:08:56 +0100 (CET)
In-Reply-To: <1445821673-4947-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Use the component framework to keep the display on till the
playback in progress.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2ed4d342efd5..2d5dbfe630f1 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -25,6 +25,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/hda_i915.h>
 #include "../../hda/local.h"
 
 #define AMP_OUT_MUTE		0xb080
@@ -562,14 +563,26 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_bus *bus = hdac->bus;
+	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
+	/* controller may not have been initialized for the first time */
+	if (!bus)
+		return 0;
+
 	/* Power down afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
 			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
+
 	return 0;
 }
 
@@ -577,9 +590,21 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_bus *bus = hdac->bus;
+	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
+	/* controller may not have been initialized for the first time */
+	if (!bus)
+		return 0;
+
+	err = snd_hdac_display_power(bus, true);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
+
 	/* Power up afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
-- 
2.4.3
