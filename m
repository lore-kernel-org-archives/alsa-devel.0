From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [RESEND][PATCH] ASoC: hdac_hdmi: Program pin-port-mux
	during jack report event
Date: Wed, 20 Jun 2018 16:38:21 +0530
Message-ID: <1529492902-6600-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 80EFE266E0E
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 13:19:53 +0200 (CEST)
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
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a36e4b..7eb5a7138483 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -32,6 +32,7 @@
 #include <sound/hda_chmap.h>
 #include "../../hda/local.h"
 #include "hdac_hdmi.h"
+#include <sound/hda_regmap.h>
 
 #define NAME_SIZE	32
 
@@ -83,6 +84,7 @@ struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
 	bool mst_capable;
+	int conn_index;
 	struct hdac_hdmi_port *ports;
 	int num_ports;
 	struct hdac_ext_device *edev;
@@ -141,6 +143,9 @@ struct hdac_hdmi_priv {
 
 #define hdev_to_hdmi_priv(_hdev) ((to_ehdac_device(_hdev))->private_data)
 
+static int hdac_hdmi_port_select_set(struct hdac_ext_device *edev,
+					struct hdac_hdmi_port *port);
+
 static struct hdac_hdmi_pcm *
 hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 			   struct hdac_hdmi_cvt *cvt)
@@ -159,6 +164,7 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		struct hdac_hdmi_port *port, bool is_connect)
 {
 	struct hdac_ext_device *edev = port->pin->edev;
+	int cmd, err;
 
 	if (is_connect)
 		snd_soc_dapm_enable_pin(port->dapm, port->jack_pin);
@@ -166,6 +172,29 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		snd_soc_dapm_disable_pin(port->dapm, port->jack_pin);
 
 	if (is_connect) {
+		/* set the device if pin is mst_capable */
+		if (hdac_hdmi_port_select_set(edev, port) < 0) {
+			dev_err(&edev->hdev.dev,
+				"port %d device select fail\n", port->id);
+			return;
+		}
+		/*
+		 * Restore the connection selection index of the
+		 * respective pin.
+		 */
+		if (port->pin->conn_index > 0) {
+			cmd = snd_hdac_regmap_encode_verb(port->pin->nid,
+						AC_VERB_SET_CONNECT_SEL);
+			err = snd_hdac_regmap_write_raw(&edev->hdev, cmd,
+						port->pin->conn_index - 1);
+			if (err < 0) {
+				dev_err(&edev->hdev.dev,
+					"pin %d conn select index fail %d\n",
+					port->pin->nid, err);
+				return;
+			}
+		}
+
 		/*
 		 * Report Jack connect event when a device is connected
 		 * for the first time where same PCM is attached to multiple
@@ -903,6 +932,9 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
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
