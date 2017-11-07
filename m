From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 10/11] ASoC: hdac_hdmi: Fix possible NULL
	pointer dereference
Date: Tue,  7 Nov 2017 16:16:25 +0530
Message-ID: <20171107104626.25800-11-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 95DB4267398
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:42 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Pointers hdac_hdmi_pcm and hda_device_id can be NULL, so add check for
valid pointer to avoid NULL pointer dereference.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 6f3ff15c0962..0c0aa6182502 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1895,6 +1895,9 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_port *port;
 
+	if (!pcm)
+		return;
+
 	if (list_empty(&pcm->port_list))
 		return;
 
@@ -1913,6 +1916,9 @@ static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 
+	if (!pcm)
+		return false;
+
 	if (list_empty(&pcm->port_list))
 		return false;
 
@@ -1926,6 +1932,9 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_port *port;
 
+	if (!pcm)
+		return 0;
+
 	if (list_empty(&pcm->port_list))
 		return 0;
 
@@ -1979,6 +1988,9 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
 	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
 
+	if (!hdac_id)
+		return -ENODEV;
+
 	if (hdac_id->driver_data)
 		hdmi_priv->drv_data =
 			(struct hdac_hdmi_drv_data *)hdac_id->driver_data;
-- 
2.14.2
