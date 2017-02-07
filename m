From: jeeja.kp@intel.com
Subject: [PATCH 01/16] ASoC: hdac_hdmi: Add MST verb support
Date: Tue,  7 Feb 2017 19:09:45 +0530
Message-ID: <1486474800-11426-2-git-send-email-jeeja.kp@intel.com>
References: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F7A266DF2
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:28:39 +0100 (CET)
In-Reply-To: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
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

To support DP MST audio, new pin verbs/params are added. This patch
adds helper functions to do following:
o To set a specific port
o To get the currently selected port
o To get the length of port.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 17a1ad3..84b7d6c 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -142,6 +142,76 @@ hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 	return pcm;
 }
 
+/* MST supported verbs */
+/*
+ * Get the no devices that can be connected to a port on the Pin widget.
+ */
+static int hdac_hdmi_get_port_len(struct hdac_ext_device *hdac, hda_nid_t nid)
+{
+	unsigned int caps;
+	unsigned int type, param;
+
+	caps = get_wcaps(&hdac->hdac, nid);
+	type = get_wcaps_type(caps);
+
+	if (!(caps & AC_WCAP_DIGITAL) || (type != AC_WID_PIN))
+		return 0;
+
+	param = snd_hdac_read_parm_uncached(&hdac->hdac, nid,
+					AC_PAR_DEVLIST_LEN);
+	if (param == -1)
+		return param;
+
+	return param & AC_DEV_LIST_LEN_MASK;
+}
+
+/*
+ * Get the port entry select on the pin. Return the port entry
+ * id selected on the pin. Return 0 means the first port entry
+ * is selected or MST is not supported.
+ */
+static int hdac_hdmi_port_select_get(struct hdac_ext_device *hdac,
+					struct hdac_hdmi_port *port)
+{
+	return snd_hdac_codec_read(&hdac->hdac, port->pin->nid,
+				0, AC_VERB_GET_DEVICE_SEL, 0);
+}
+
+/*
+ * Sets the selected port entry for the configuring Pin widget verb.
+ * returns error if port set is not equal to port get otherwise success
+ */
+static int hdac_hdmi_port_select_set(struct hdac_ext_device *hdac,
+					struct hdac_hdmi_port *port)
+{
+	int num_ports;
+
+	if (!port->pin->mst_capable)
+		return 0;
+
+	/* AC_PAR_DEVLIST_LEN is 0 based. */
+	num_ports = hdac_hdmi_get_port_len(hdac, port->pin->nid);
+
+	if (num_ports < 0)
+		return -EIO;
+	/*
+	 * Device List Length is a 0 based integer value indicating the
+	 * number of sink device that a MST Pin Widget can support.
+	 */
+	if (num_ports + 1  < port->id)
+		return 0;
+
+	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
+			AC_VERB_SET_DEVICE_SEL, port->id);
+
+	if (port->id != hdac_hdmi_port_select_get(hdac, port))
+		return -EIO;
+
+	dev_dbg(&hdac->hdac.dev, "Selected the port=%d\n", port->id);
+
+	return 0;
+}
+
 static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 						int pcm_idx)
 {
-- 
2.5.0
