From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 13/15] ASoC: hdac_hdmi: Fix to keep codec
	power active during enumeration.
Date: Fri, 12 Feb 2016 07:46:13 +0530
Message-ID: <1455243375-16067-14-git-send-email-subhransu.s.prusty@intel.com>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E614265AF3
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 03:15:42 +0100 (CET)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Codec power is turned OFF in the first explicit call to
pm_runtime_suspend, thus keeping the refcount balanced. For any
other communication with codec, the power is turned ON/OFF in
runtime PM handlers.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 9b7e058..8371b76 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1491,6 +1491,18 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	INIT_LIST_HEAD(&hdmi_priv->pcm_list);
 	mutex_init(&hdmi_priv->pin_mutex);
 
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
