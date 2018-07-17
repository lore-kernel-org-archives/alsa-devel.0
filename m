From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH v3] ASoC: hdac_hdmi: Program pin-port-mux
	during jack report event
Date: Tue, 17 Jul 2018 16:40:42 +0530
Message-ID: <1531825842-26513-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 5938226770A
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 13:15:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

During d3/d0 cycle, the connection selection index of all pins points
to the default value. This needs to be restored to ensure audio is
restored after d3/d0 cycle.

So store the connection selection index and program it during jack
report event which gets invoked in cases like d3/d0 cycle, hot plug
detection when multiple displays are connected.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---

v2 -> v3:
	- Balance PM usage count in error path

	- Add more explanation to the patch

v1 -> v2:
	- Runtime resume the device explicitly in order to use
	  snd_hdac_codec_write()

 sound/soc/codecs/hdac_hdmi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a36e4b..39224f01e59b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -83,6 +83,7 @@ struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
 	bool mst_capable;
+	int conn_index;
 	struct hdac_hdmi_port *ports;
 	int num_ports;
 	struct hdac_ext_device *edev;
@@ -141,6 +142,9 @@ struct hdac_hdmi_priv {
 
 #define hdev_to_hdmi_priv(_hdev) ((to_ehdac_device(_hdev))->private_data)
 
+static int hdac_hdmi_port_select_set(struct hdac_ext_device *edev,
+					struct hdac_hdmi_port *port);
+
 static struct hdac_hdmi_pcm *
 hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 			   struct hdac_hdmi_cvt *cvt)
@@ -167,6 +171,38 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 
 	if (is_connect) {
 		/*
+		 * Restore the connection selection index in
+		 * hdac_hdmi_jack_report() which will restore all ports
+		 * irrespective of their usage in all use cases like D0/D3
+		 * cycles, Hot plug detection.
+		 *
+		 * Increment the usage count to ensure that the device
+		 * is runtime active to send verb across.
+		 */
+		pm_runtime_get_sync(&edev->hdev.dev);
+
+		/* set the device if pin is mst_capable */
+		if (hdac_hdmi_port_select_set(edev, port) < 0) {
+			dev_err(&edev->hdev.dev,
+				"port %d device select fail\n", port->id);
+			pm_runtime_put_sync(&edev->hdev.dev);
+			return;
+		}
+
+		/*
+		 * Ensure that valid connection selection index of the
+		 * respective pin is updated since writing invalid will
+		 * lead to undefined HW behaviour in such cases like if
+		 * mux is not set for ports from userland.
+		 */
+		if (port->pin->conn_index > 0)
+			snd_hdac_codec_write(&edev->hdev, port->pin->nid,
+						0, AC_VERB_SET_CONNECT_SEL,
+						port->pin->conn_index - 1);
+
+		pm_runtime_put_sync(&edev->hdev.dev);
+
+		/*
 		 * Report Jack connect event when a device is connected
 		 * for the first time where same PCM is attached to multiple
 		 * ports.
@@ -903,6 +939,9 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 		}
 	}
 
+	if (ucontrol->value.enumerated.item[0] > 0)
+		port->pin->conn_index =	ucontrol->value.enumerated.item[0];
+
 	/*
 	 * Jack status is not reported during device probe as the
 	 * PCMs are not registered by then. So report it here.
-- 
2.7.4
