From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH] ASoC: codec: hdac_hdmi: fix pin connections at
	cvt enable
Date: Wed, 12 Jun 2019 14:55:09 +0300
Message-ID: <20190612115509.3400-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2CB1F80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 13:59:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

In display codecs supported by hdac_hdmi, the connection indices are
shared by all converters. At boot and resume from suspend,
the connection state may be reset to default values.

In case of multiple connected pins (multiple monitors connected
with audio capability), routing and mute status of pins that
are not connected to any PCM, may interfere with other pins.
E.g. after resume from S3 with multiple monitors, unless
all converters are in active use, playback to some PCMs may
be muted due to the default settings of unrelated converters.

Avoid this by ensuring all pin:cvt selections are correct
in codec whenever a converter is enabled for playback.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 660e0587f3999..bb87240d2fb22 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -546,6 +546,39 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 	return NULL;
 }
 
+/**
+ * Go through all converters and ensure connection is set to
+ * the correct pin as set via kcontrols.
+ */
+static void hdac_hdmi_verify_connect_sel_all_pins(struct hdac_device *hdev)
+{
+	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+	struct hdac_hdmi_cvt *cvt;
+	int cvt_idx = 0;
+	int curr;
+
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		port = hdac_hdmi_get_port_from_cvt(hdev, hdmi, cvt);
+		if (port && port->pin) {
+			curr = snd_hdac_codec_read(hdev, port->pin->nid,
+						   0, AC_VERB_GET_CONNECT_SEL,
+						   0);
+			if (curr != cvt_idx) {
+				snd_hdac_codec_write(hdev,
+						     port->pin->nid, 0,
+						     AC_VERB_SET_CONNECT_SEL,
+						     cvt_idx);
+				dev_dbg(&hdev->dev,
+					"%s: %s set connect %d -> %d\n",
+					__func__, cvt->name, port->pin->nid,
+					cvt_idx);
+			}
+		}
+		++cvt_idx;
+	}
+}
+
 /*
  * This tries to get a valid pin and set the HW constraints based on the
  * ELD. Even if a valid pin is not found return success so that device open
@@ -806,6 +839,14 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
 				AC_VERB_SET_CHANNEL_STREAMID, pcm->stream_tag);
 		snd_hdac_codec_write(hdev, cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, pcm->format);
+
+		/**
+		 * The connection indices are shared by all converters and
+		 * may interfere with each other. Ensure correct
+		 * routing for all converters at stream start.
+		 */
+		hdac_hdmi_verify_connect_sel_all_pins(hdev);
+
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-- 
2.17.1
