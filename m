From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 11/11] ASoC: hdac_hdmi: Fix possible memory
	leak on parse and map nid failure
Date: Tue,  7 Nov 2017 16:16:26 +0530
Message-ID: <20171107104626.25800-12-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 574B226736D
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:47 +0100 (CET)
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

During failure, widgets in cvt_list and pin_list are not freed. So fix
the possible memory leak by freeing them when failure occurs.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0c0aa6182502..f3b4f4dfae6a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1453,6 +1453,8 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 	int i, num_nodes;
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_cvt *temp_cvt, *cvt_next;
+	struct hdac_hdmi_pin *temp_pin, *pin_next;
 	int ret;
 
 	hdac_hdmi_skl_enable_all_pins(hdac);
@@ -1482,32 +1484,54 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		case AC_WID_AUD_OUT:
 			ret = hdac_hdmi_add_cvt(edev, nid);
 			if (ret < 0)
-				return ret;
+				goto free_widgets;
 			break;
 
 		case AC_WID_PIN:
 			ret = hdac_hdmi_add_pin(edev, nid);
 			if (ret < 0)
-				return ret;
+				goto free_widgets;
 			break;
 		}
 	}
 
 	hdac->end_nid = nid;
 
-	if (!hdmi->num_pin || !hdmi->num_cvt)
-		return -EIO;
+	if (!hdmi->num_pin || !hdmi->num_cvt) {
+		ret = -EIO;
+		goto free_widgets;
+	}
 
 	ret = hdac_hdmi_create_dais(hdac, dais, hdmi, hdmi->num_cvt);
 	if (ret) {
 		dev_err(&hdac->dev, "Failed to create dais with err: %d\n",
 							ret);
-		return ret;
+		goto free_widgets;
 	}
 
 	*num_dais = hdmi->num_cvt;
+	ret = hdac_hdmi_init_dai_map(edev);
+	if (ret < 0)
+		goto free_widgets;
 
-	return hdac_hdmi_init_dai_map(edev);
+	return ret;
+
+free_widgets:
+	list_for_each_entry_safe(temp_cvt, cvt_next, &hdmi->cvt_list, head) {
+		list_del(&temp_cvt->head);
+		kfree(temp_cvt->name);
+		kfree(temp_cvt);
+	}
+
+	list_for_each_entry_safe(temp_pin, pin_next, &hdmi->pin_list, head) {
+		for (i = 0; i < temp_pin->num_ports; i++)
+			temp_pin->ports[i].pin = NULL;
+		kfree(temp_pin->ports);
+		list_del(&temp_pin->head);
+		kfree(temp_pin);
+	}
+
+	return ret;
 }
 
 static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
-- 
2.14.2
