From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/3] ASoC: hdac_hdmi: Fix to use dev_pm ops
	instead soc pm
Date: Fri,  1 Apr 2016 13:36:25 +0530
Message-ID: <1459497987-28979-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 75512265189
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 10:07:04 +0200 (CEST)
In-Reply-To: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
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

Use dev_pm ops feature instead of soc pm as core assumes system
is capable of direct complete. Register with complete callback
instead of resume to synchronize with Jack notification from
display driver. This ensures correct Jack notification to user
space.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 26f9459..da3432c 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1420,9 +1420,9 @@ static int hdmi_codec_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int hdmi_codec_resume(struct snd_soc_codec *codec)
+static void hdmi_codec_complete(struct device *dev)
 {
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
@@ -1464,19 +1464,15 @@ static int hdmi_codec_resume(struct snd_soc_codec *codec)
 		dev_err(bus->dev,
 			"Cannot turn OFF display power on i915, err: %d\n",
 			err);
-		return err;
 	}
-
-	return 0;
 }
 #else
-#define hdmi_codec_resume NULL
+#define hdmi_codec_complete NULL
 #endif
 
 static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.probe		= hdmi_codec_probe,
 	.remove		= hdmi_codec_remove,
-	.resume		= hdmi_codec_resume,
 	.idle_bias_off	= true,
 };
 
@@ -1629,6 +1625,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops hdac_hdmi_pm = {
 	SET_RUNTIME_PM_OPS(hdac_hdmi_runtime_suspend, hdac_hdmi_runtime_resume, NULL)
+	.complete = hdmi_codec_complete,
 };
 
 static const struct hda_device_id hdmi_list[] = {
-- 
1.9.1
