From: libin.yang@intel.com
Subject: [RFC PATCH 4/4] ASoC: hdac_hdmi: fix some coding style
	issue
Date: Mon, 27 May 2019 17:07:27 +0800
Message-ID: <1558948047-18930-5-git-send-email-libin.yang@intel.com>
References: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E164DF8065A
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 11:27:38 +0200 (CEST)
In-Reply-To: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch fixes some coding style issue

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index ed267fa..a52d236 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -477,8 +477,8 @@ static int hdac_hdmi_query_port_connlist(struct hdac_device *hdev,
 {
 	if (!(get_wcaps(hdev, pin->nid) & AC_WCAP_CONN_LIST)) {
 		dev_warn(&hdev->dev,
-			"HDMI: pin %d wcaps %#x does not support connection list\n",
-			pin->nid, get_wcaps(hdev, pin->nid));
+			 "HDMI: pin %d wcaps %#x does not support connection list\n",
+			 pin->nid, get_wcaps(hdev, pin->nid));
 		return -EINVAL;
 	}
 
@@ -489,11 +489,11 @@ static int hdac_hdmi_query_port_connlist(struct hdac_device *hdev,
 			port->mux_nids, HDA_MAX_CONNECTIONS);
 	if (port->num_mux_nids == 0)
 		dev_warn(&hdev->dev,
-			"No connections found for pin:port %d:%d\n",
-						pin->nid, port->id);
+			 "No connections found for pin:port %d:%d\n",
+			 pin->nid, port->id);
 
 	dev_dbg(&hdev->dev, "num_mux_nids %d for pin:port %d:%d\n",
-			port->num_mux_nids, pin->nid, port->id);
+		port->num_mux_nids, pin->nid, port->id);
 
 	return port->num_mux_nids;
 }
@@ -572,9 +572,9 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 			(!port->eld.eld_valid)) {
 
 		dev_warn(&hdev->dev,
-			"Failed: present?:%d ELD valid?:%d pin:port: %d:%d\n",
-			port->eld.monitor_present, port->eld.eld_valid,
-			port->pin->nid, port->id);
+			 "Failed: present?:%d ELD valid?:%d pin:port: %d:%d\n",
+			 port->eld.monitor_present, port->eld.eld_valid,
+			 port->pin->nid, port->id);
 
 		return 0;
 	}
@@ -734,7 +734,7 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 	struct hdac_hdmi_pcm *pcm;
 
 	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
-			__func__, w->name, event);
+		__func__, w->name, event);
 
 	pcm = hdac_hdmi_get_pcm(hdev, port);
 	if (!pcm)
@@ -780,7 +780,7 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
 	struct hdac_hdmi_pcm *pcm;
 
 	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
-			__func__, w->name, event);
+		__func__, w->name, event);
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, cvt);
 	if (!pcm)
@@ -826,7 +826,7 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 	int mux_idx;
 
 	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
-			__func__, w->name, event);
+		__func__, w->name, event);
 
 	if (!kc)
 		kc  = w->kcontrols[0];
@@ -1142,7 +1142,7 @@ static int hdac_hdmi_init_dai_map(struct hdac_device *hdev)
 
 		if (dai_id == HDA_MAX_CVTS) {
 			dev_warn(&hdev->dev,
-				"Max dais supported: %d\n", dai_id);
+				 "Max dais supported: %d\n", dai_id);
 			break;
 		}
 	}
@@ -1242,8 +1242,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	pcm = hdac_hdmi_get_pcm(hdev, port);
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
-		dev_err(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
-						__func__, pin->nid, port->id);
+		dev_info(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
+			 __func__, pin->nid, port->id);
 		hdac_hdmi_jack_report(port, false);
 		mutex_unlock(&hdmi->pin_mutex);
 		return;
@@ -1281,6 +1281,7 @@ static int hdac_hdmi_add_ports(struct hdac_device *hdev,
 	}
 	pin->ports = ports;
 	pin->num_ports = max_ports;
+
 	return 0;
 }
 
@@ -1544,7 +1545,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 	}
 
 	dev_dbg(&hdev->dev, "%s: for pin:%d port=%d\n", __func__,
-							pin_nid, pipe);
+		pin_nid, pipe);
 
 	/*
 	 * skip notification during system suspend (but not in runtime PM);
-- 
2.7.4
