From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 13/15] ASoC: hdac_hdmi: Fix to keep display
	active while enumerating codec
Date: Tue,  8 Dec 2015 02:54:27 +0530
Message-ID: <1449523469-4395-13-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A342A2657A6
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:29 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

The display power reference count is decremented with the first
explicit call to pm_runtime_suspend. Otherwise the display power
reference count is balanced with runtime resume/suspend. Rest
of the time it is kept off.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e64e505..008a29f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1264,6 +1264,18 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
 	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
 
+	/*
+	 * Turned off in the runtime_suspend during the first explicit
+	 * pm_runtime_suspend call.
+	 */
+	ret = snd_hdac_display_power(edev->hdac.bus, true);
+	if (ret < 0) {
+		dev_err(&edev->hdac.dev,
+			"Cannot turn on display power on i915 err: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
 		dev_err(&codec->dev,
-- 
1.9.1
