From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 15/15] ASoC: hdac_hdmi: Fix to wait for D3
	before powering off codec
Date: Fri, 12 Feb 2016 07:46:15 +0530
Message-ID: <1455243375-16067-16-git-send-email-subhransu.s.prusty@intel.com>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D875265B5B
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 03:15:49 +0100 (CET)
In-Reply-To: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
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

Powering off codec immediately after sending D3 verb may not set
the node to D3 state. So wait for a confirmation response before
shutting down codec.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0baf504..a4cf0b9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1551,6 +1551,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
+	unsigned long timeout;
 	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -1560,10 +1561,19 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 		return 0;
 
 	/* Power down afg */
-	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3))
+	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)) {
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
 			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
+		/* Wait till power state is set to D3 */
+		timeout = jiffies + msecs_to_jiffies(1000);
+		while(!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)
+				&& time_before(jiffies, timeout)) {
+
+			msleep(50);
+		}
+	}
+
 	err = snd_hdac_display_power(bus, false);
 	if (err < 0) {
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-- 
1.9.1
