From: jeeja.kp@intel.com
Subject: [RFC 09/16] ASoC: hdac_hdmi: Add MST verb support
Date: Tue, 20 Sep 2016 19:16:13 +0530
Message-ID: <1474379180-7132-10-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0892666F1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:08 +0200 (CEST)
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

To support DP MST audio, new pin verbs/params are added. This patch
adds helper functions to do following:
1. To set a specific port
2. To get the currently selected port
3. To get the length of port.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c9f4d4a..d99eb9c 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -125,6 +125,75 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
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
+	if (!port->pin->is_mst_capable)
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
+	if (num_ports +1  <port->id)
+		return 0;
+
+	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
+			AC_VERB_SET_DEVICE_SEL, port->id);
+
+	if (port->id != hdac_hdmi_port_select_get(hdac, port))
+		return -EIO;
+
+	dev_dbg(&hdac->hdac.dev, "Selected the port=%d\n", port->id);
+	return 0;
+}
+
 static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
 		                struct hdac_hdmi_dai_port_map *dai_map);
 
-- 
2.5.0
