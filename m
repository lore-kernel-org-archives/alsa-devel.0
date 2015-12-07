From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 12/15] ASoC: hdac_hdmi: Add codec
	suspend/resume handler
Date: Tue,  8 Dec 2015 02:54:26 +0530
Message-ID: <1449523469-4395-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E0D2654F2
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:26 +0100 (CET)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Need to add enabling of all pins and DP1.2 feature again after
resume. Also during the device in suspended state ELD notify
callback is not processed. So add ELD check for all pins here.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 32d1938..e64e505 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1214,9 +1214,34 @@ static int hdmi_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int hdmi_codec_resume(struct snd_soc_codec *codec)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+
+	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
+	hdac_hdmi_skl_enable_dp12(&edev->hdac);
+
+	/*
+	 * As the ELD notify callback request is not entertained while the
+	 * device is in suspend state. Need to manually check detection of
+	 * all pins here.
+	 */
+	list_for_each_entry(pin, &hdmi->pin_list, head)
+		hdac_hdmi_present_sense(pin, 1);
+
+	return 0;
+}
+#else
+#define hdmi_codec_resume NULL
+#endif
+
 static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.probe		= hdmi_codec_probe,
 	.remove		= hdmi_codec_remove,
+	.resume		= hdmi_codec_resume,
 	.idle_bias_off	= true,
 };
 
-- 
1.9.1
