From: jeeja.kp@intel.com
Subject: [RFC 08/16] ASoC: hdac_hdmi: Add support to handle MST
	capable pin
Date: Tue, 20 Sep 2016 19:16:12 +0530
Message-ID: <1474379180-7132-9-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A762666AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:06 +0200 (CEST)
In-Reply-To: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
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

To handle Jack event and Configure the Pin widget for MST capable pin,
this patch adds:
1. Flag to identify the pin is MST capable.
2. In notify callback(), based on the pipe and port information marks
   if the port is mst_capable. In case of Non MST, port is defaulted to
   zero.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 88d6dae..c9f4d4a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -81,6 +81,7 @@ struct hdac_hdmi_eld {
 struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
+	bool is_mst_capable;
 	struct hdac_hdmi_port *ports;
 	int num_ports;
 	struct hdac_ext_device *edev;
@@ -1057,6 +1058,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
 	int size = 0;
+	int port_id;
 
 	if (!hdmi)
 		return;
@@ -1064,7 +1066,9 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	mutex_lock(&hdmi->pin_mutex);
 	port->eld.monitor_present = false;
 
-	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, -1,
+	port_id = (pin->is_mst_capable)? port->id: -1;
+
+	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, port_id,
 				&port->eld.monitor_present, port->eld.eld_buffer,
 				ELD_MAX_SIZE);
 
@@ -1154,6 +1158,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 		return -ENOMEM;
 
 	pin->nid = nid;
+	pin->is_mst_capable = false;
 	pin->edev = edev;
 	ret = hdac_hdmi_add_ports(hdmi, pin);
 	if (ret < 0)
@@ -1352,6 +1357,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int dport, int pipe)
 	struct hdac_hdmi_pin *pin = NULL;
 	struct hdac_hdmi_port *port = NULL;
 	struct snd_soc_codec *codec = edev->scodec;
+	int i;
 
 	/* Don't know how this mapping is derived */
 	hda_nid_t pin_nid = dport + 0x04;
@@ -1377,13 +1383,23 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int dport, int pipe)
 			continue;
 
 		if (pipe == -1) {
+			pin->is_mst_capable = false;
 			/* if not MST, default is port[0] */
 			port = &pin->ports[0];
-			break;
+			goto out;
+		} else {
+			for (i=0; i < pin->num_ports; i++) {
+				pin->is_mst_capable = true;
+				if (pin->ports[i].id == pipe) {
+					port = &pin->ports[i];
+					goto out;
+				}
+			}
 		}
 	}
 
-	if (port)
+out:
+	if (pin && port)
 		hdac_hdmi_present_sense(pin, port);
 }
 
-- 
2.5.0
