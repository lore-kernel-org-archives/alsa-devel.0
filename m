From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v8 2/2] ASoC: hdac_hdmi: Add PM support
Date: Sun, 21 Feb 2016 11:30:44 +0530
Message-ID: <1456034444-10606-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1456034444-10606-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 45ACF260569
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 06:59:57 +0100 (CET)
In-Reply-To: <1456034444-10606-1-git-send-email-subhransu.s.prusty@intel.com>
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

The codec registers are reset during S3. So need to reconfigure
all pins and DP1.2 feature again after resume from S3. Also
reprogram the required registers if the S3 was triggered during
playback.

In suspended state ELD notify callback is not processed, So add
ELD check for all pins as well.

Also turn the codec power domain OFF which is kept ON during
controller resequencing and codec reenumeration.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index aa953a5..ab75b4b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -601,6 +601,26 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 				pin->eld.eld_buffer);
 }
 
+static int hdac_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
+{
+	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	int ret;
+
+	dai_map = &hdmi->dai_map[dai->id];
+	if (cmd == SNDRV_PCM_TRIGGER_RESUME) {
+		ret = hdac_hdmi_enable_pin(hdac, dai_map);
+		if (ret < 0)
+			return ret;
+
+		return hdac_hdmi_playback_prepare(substream, dai);
+	}
+
+	return 0;
+}
+
 static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -1154,6 +1174,7 @@ static struct snd_soc_dai_ops hdmi_dai_ops = {
 	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
 	.prepare = hdac_hdmi_playback_prepare,
+	.trigger = hdac_hdmi_trigger,
 	.hw_free = hdac_hdmi_playback_cleanup,
 };
 
@@ -1399,9 +1420,49 @@ static int hdmi_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int hdmi_codec_resume(struct snd_soc_codec *codec)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_bus *bus = hdac->bus;
+	int err;
+
+	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
+	hdac_hdmi_skl_enable_dp12(&edev->hdac);
+
+	/* Power up afg */
+	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
+		snd_hdac_codec_write(hdac, hdac->afg, 0,
+			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+	/*
+	 * As the ELD notify callback request is not entertained while the
+	 * device is in suspend state. Need to manually check detection of
+	 * all pins here.
+	 */
+	list_for_each_entry(pin, &hdmi->pin_list, head)
+		hdac_hdmi_present_sense(pin, 1);
+
+	/* Codec power is turned ON during controller resume */
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
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
