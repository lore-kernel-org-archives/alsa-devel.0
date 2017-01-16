From: jeeja.kp@intel.com
Subject: [PATCH 15/30] ASoC: hdac_hdmi: Handle MST pin jack
	detection at boot/resume
Date: Mon, 16 Jan 2017 23:27:42 +0530
Message-ID: <1484589477-7630-16-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AE7AD26720A
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:53 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The ELD notification can be received asynchronously from the graphics
side and this may happen just at the moment the sound driver is
initializing and notification will be missed. Similarly at system
resume, the notification is ignored as the  ELD and connection states
are updated in anyway at the end of the resume.
So check the jack status in boot/resume by querying the port presence
based on pin caps and report the jack status.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7397c4c..fda2c6c 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1550,15 +1550,38 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
 
+static void hdac_hdmi_present_sense_all_pins(struct hdac_ext_device *edev,
+			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
+{
+	int i;
+	struct hdac_hdmi_pin *pin;
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (detect_pin_caps) {
+
+			if (hdac_hdmi_get_port_len(edev, pin->nid)  == 0)
+				pin->mst_capable = false;
+			else
+				pin->mst_capable = true;
+		}
+
+		for (i = 0; i < pin->num_ports; i++) {
+			if (!pin->mst_capable && i > 0)
+				continue;
+
+			hdac_hdmi_present_sense(pin, &pin->ports[i]);
+		}
+	}
+}
+
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
 {
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
-	struct hdac_hdmi_pin *pin;
 	struct hdac_ext_link *hlink = NULL;
-	int ret, i;
+	int ret;
 
 	edev->scodec = codec;
 
@@ -1586,10 +1609,7 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	list_for_each_entry(pin, &hdmi->pin_list, head)
-		for (i = 0; i < pin->num_ports; i++)
-			hdac_hdmi_present_sense(pin, &pin->ports[i]);
-
+	hdac_hdmi_present_sense_all_pins(edev, hdmi, true);
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
 
@@ -1637,9 +1657,7 @@ static void hdmi_codec_complete(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
-	int i;
 
 	/* Power up afg */
 	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
@@ -1651,11 +1669,10 @@ static void hdmi_codec_complete(struct device *dev)
 	/*
 	 * As the ELD notify callback request is not entertained while the
 	 * device is in suspend state. Need to manually check detection of
-	 * all pins here.
+	 * all pins here. pin capablity change is not support, so use the
+	 * already set pin caps.
 	 */
-	list_for_each_entry(pin, &hdmi->pin_list, head)
-		for (i = 0; i < pin->num_ports; i++)
-			hdac_hdmi_present_sense(pin, &pin->ports[i]);
+	hdac_hdmi_present_sense_all_pins(edev, hdmi, false);
 
 	pm_runtime_put_sync(&edev->hdac.dev);
 }
-- 
2.5.0
