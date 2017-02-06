From: jeeja.kp@intel.com
Subject: [PATCH v4 5/5] ASoC: hdac_hdmi: Add support to handle
	MST capable pin
Date: Mon,  6 Feb 2017 12:09:18 +0530
Message-ID: <1486363158-16496-6-git-send-email-jeeja.kp@intel.com>
References: <1486363158-16496-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 558192668D1
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 07:28:03 +0100 (CET)
In-Reply-To: <1486363158-16496-1-git-send-email-jeeja.kp@intel.com>
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

To handle jack event and configuration of the pin widget for MST
capable pin, this patch adds:
o Flag to identify the pin is MST capable.
o In notify callback(), based on the pipe and port information marks if
the port is mst_capable. In case of non MST, port is defaulted to zero.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d3858b5..17a1ad3 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -82,6 +82,7 @@ struct hdac_hdmi_eld {
 struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
+	bool mst_capable;
 	struct hdac_hdmi_port *ports;
 	int num_ports;
 	struct hdac_ext_device *edev;
@@ -1065,14 +1066,22 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
 	int size = 0;
+	int port_id = -1;
 
 	if (!hdmi)
 		return;
 
+	/*
+	 * In case of non MST pin, get_eld info API expectes port
+	 * to be -1.
+	 */
 	mutex_lock(&hdmi->pin_mutex);
 	port->eld.monitor_present = false;
 
-	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, -1,
+	if (pin->mst_capable)
+		port_id = port->id;
+
+	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, port_id,
 				&port->eld.monitor_present,
 				port->eld.eld_buffer,
 				ELD_MAX_SIZE);
@@ -1167,6 +1176,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 		return -ENOMEM;
 
 	pin->nid = nid;
+	pin->mst_capable = false;
 	pin->edev = edev;
 	ret = hdac_hdmi_add_ports(hdmi, pin);
 	if (ret < 0)
@@ -1363,6 +1373,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 	struct hdac_hdmi_pin *pin = NULL;
 	struct hdac_hdmi_port *hport = NULL;
 	struct snd_soc_codec *codec = edev->scodec;
+	int i;
 
 	/* Don't know how this mapping is derived */
 	hda_nid_t pin_nid = port + 0x04;
@@ -1389,13 +1400,23 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 
 		/* In case of non MST pin, pipe is -1 */
 		if (pipe == -1) {
+			pin->mst_capable = false;
 			/* if not MST, default is port[0] */
 			hport = &pin->ports[0];
-			break;
+			goto out;
+		} else {
+			for (i = 0; i < pin->num_ports; i++) {
+				pin->mst_capable = true;
+				if (pin->ports[i].id == pipe) {
+					hport = &pin->ports[i];
+					goto out;
+				}
+			}
 		}
 	}
 
-	if (hport)
+out:
+	if (pin && hport)
 		hdac_hdmi_present_sense(pin, hport);
 }
 
-- 
2.5.0
