From: jeeja.kp@intel.com
Subject: [PATCH 16/30] ASoc: hdac_hdmi: Configure pin verbs for
	MST
Date: Mon, 16 Jan 2017 23:27:43 +0530
Message-ID: <1484589477-7630-17-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CC35267232
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:57 +0100 (CET)
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

To enable stream on a specific port of a MST capable pin, the port
needs to be selected before we configure the pin widget verb.

When port is selected, all the pin widget verb controlling the sink
device operation will be directed to selected port. So add port
selection before configuring the pin widget verb.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index fda2c6c..e9bf4ac 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -448,6 +448,9 @@ static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *hdac,
 		return -EINVAL;
 	}
 
+	if (hdac_hdmi_port_select_set(hdac, port) < 0)
+		return -EIO;
+
 	port->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
 			port->mux_nids, HDA_MAX_CONNECTIONS);
 	if (port->num_mux_nids == 0)
@@ -687,6 +690,10 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 	if (!pcm)
 		return -EIO;
 
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(edev, port) < 0)
+		return -EIO;
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		hdac_hdmi_set_power_state(edev, port->pin->nid, AC_PWRST_D0);
@@ -775,6 +782,11 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 		kc  = w->kcontrols[0];
 
 	mux_idx = dapm_kcontrol_get_value(kc);
+
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(edev, port) < 0)
+		return -EIO;
+
 	if (mux_idx > 0) {
 		snd_hdac_codec_write(&edev->hdac, port->pin->nid, 0,
 			AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
-- 
2.5.0
