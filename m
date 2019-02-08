From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: hdac_hdmi: use devm_kzalloc for all
	structures
Date: Fri,  8 Feb 2019 17:26:53 -0600
Message-ID: <20190208232653.6696-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A7C132674C9
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:26:57 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Loading/unloading modules exposes issues with memory allocation, which
is a mix of devm_kzalloc and manual kzalloc. Move to devm_k routines
everywhere to simplify all this.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 87 ++++++++----------------------------
 1 file changed, 18 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index b19d7a3e7a2c..5eeb0fe836a9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1176,13 +1176,15 @@ static int hdac_hdmi_add_cvt(struct hdac_device *hdev, hda_nid_t nid)
 	struct hdac_hdmi_cvt *cvt;
 	char name[NAME_SIZE];
 
-	cvt = kzalloc(sizeof(*cvt), GFP_KERNEL);
+	cvt = devm_kzalloc(&hdev->dev, sizeof(*cvt), GFP_KERNEL);
 	if (!cvt)
 		return -ENOMEM;
 
 	cvt->nid = nid;
 	sprintf(name, "cvt %d", cvt->nid);
-	cvt->name = kstrdup(name, GFP_KERNEL);
+	cvt->name = devm_kstrdup(&hdev->dev, name, GFP_KERNEL);
+	if (!cvt->name)
+		return -ENOMEM;
 
 	list_add_tail(&cvt->head, &hdmi->cvt_list);
 	hdmi->num_cvt++;
@@ -1287,8 +1289,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	mutex_unlock(&hdmi->pin_mutex);
 }
 
-static int hdac_hdmi_add_ports(struct hdac_hdmi_priv *hdmi,
-				struct hdac_hdmi_pin *pin)
+static int hdac_hdmi_add_ports(struct hdac_device *hdev,
+			       struct hdac_hdmi_pin *pin)
 {
 	struct hdac_hdmi_port *ports;
 	int max_ports = HDA_MAX_PORTS;
@@ -1300,7 +1302,7 @@ static int hdac_hdmi_add_ports(struct hdac_hdmi_priv *hdmi,
 	 * implemented.
 	 */
 
-	ports = kcalloc(max_ports, sizeof(*ports), GFP_KERNEL);
+	ports = devm_kcalloc(&hdev->dev, max_ports, sizeof(*ports), GFP_KERNEL);
 	if (!ports)
 		return -ENOMEM;
 
@@ -1319,14 +1321,14 @@ static int hdac_hdmi_add_pin(struct hdac_device *hdev, hda_nid_t nid)
 	struct hdac_hdmi_pin *pin;
 	int ret;
 
-	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
+	pin = devm_kzalloc(&hdev->dev, sizeof(*pin), GFP_KERNEL);
 	if (!pin)
 		return -ENOMEM;
 
 	pin->nid = nid;
 	pin->mst_capable = false;
 	pin->hdev = hdev;
-	ret = hdac_hdmi_add_ports(hdmi, pin);
+	ret = hdac_hdmi_add_ports(hdev, pin);
 	if (ret < 0)
 		return ret;
 
@@ -1468,8 +1470,6 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
 {
 	hda_nid_t nid;
 	int i, num_nodes;
-	struct hdac_hdmi_cvt *temp_cvt, *cvt_next;
-	struct hdac_hdmi_pin *temp_pin, *pin_next;
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	int ret;
 
@@ -1497,51 +1497,35 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
 		case AC_WID_AUD_OUT:
 			ret = hdac_hdmi_add_cvt(hdev, nid);
 			if (ret < 0)
-				goto free_widgets;
+				return ret;
 			break;
 
 		case AC_WID_PIN:
 			ret = hdac_hdmi_add_pin(hdev, nid);
 			if (ret < 0)
-				goto free_widgets;
+				return ret;
 			break;
 		}
 	}
 
 	if (!hdmi->num_pin || !hdmi->num_cvt) {
 		ret = -EIO;
-		goto free_widgets;
+		dev_err(&hdev->dev, "Bad pin/cvt setup in %s\n", __func__);
+		return ret;
 	}
 
 	ret = hdac_hdmi_create_dais(hdev, dais, hdmi, hdmi->num_cvt);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create dais with err: %d\n",
-							ret);
-		goto free_widgets;
+			ret);
+		return ret;
 	}
 
 	*num_dais = hdmi->num_cvt;
 	ret = hdac_hdmi_init_dai_map(hdev);
 	if (ret < 0)
-		goto free_widgets;
-
-	return ret;
-
-free_widgets:
-	list_for_each_entry_safe(temp_cvt, cvt_next, &hdmi->cvt_list, head) {
-		list_del(&temp_cvt->head);
-		kfree(temp_cvt->name);
-		kfree(temp_cvt);
-	}
-
-	list_for_each_entry_safe(temp_pin, pin_next, &hdmi->pin_list, head) {
-		for (i = 0; i < temp_pin->num_ports; i++)
-			temp_pin->ports[i].pin = NULL;
-		kfree(temp_pin->ports);
-		list_del(&temp_pin->head);
-		kfree(temp_pin);
-	}
-
+		dev_err(&hdev->dev, "Failed to init DAI map with err: %d\n",
+			ret);
 	return ret;
 }
 
@@ -1782,7 +1766,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 	 * this is a new PCM device, create new pcm and
 	 * add to the pcm list
 	 */
-	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	pcm = devm_kzalloc(&hdev->dev, sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
 		return -ENOMEM;
 	pcm->pcm_id = device;
@@ -1798,7 +1782,6 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 			dev_err(&hdev->dev,
 				"chmap control add failed with err: %d for pcm: %d\n",
 				err, device);
-			kfree(pcm);
 			return err;
 		}
 	}
@@ -2075,42 +2058,8 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 
 static int hdac_hdmi_dev_remove(struct hdac_device *hdev)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	struct hdac_hdmi_pin *pin, *pin_next;
-	struct hdac_hdmi_cvt *cvt, *cvt_next;
-	struct hdac_hdmi_pcm *pcm, *pcm_next;
-	struct hdac_hdmi_port *port, *port_next;
-	int i;
-
 	snd_hdac_display_power(hdev->bus, hdev->addr, false);
 
-	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
-		pcm->cvt = NULL;
-		if (list_empty(&pcm->port_list))
-			continue;
-
-		list_for_each_entry_safe(port, port_next,
-					&pcm->port_list, head)
-			list_del(&port->head);
-
-		list_del(&pcm->head);
-		kfree(pcm);
-	}
-
-	list_for_each_entry_safe(cvt, cvt_next, &hdmi->cvt_list, head) {
-		list_del(&cvt->head);
-		kfree(cvt->name);
-		kfree(cvt);
-	}
-
-	list_for_each_entry_safe(pin, pin_next, &hdmi->pin_list, head) {
-		for (i = 0; i < pin->num_ports; i++)
-			pin->ports[i].pin = NULL;
-		kfree(pin->ports);
-		list_del(&pin->head);
-		kfree(pin);
-	}
-
 	return 0;
 }
 
-- 
2.17.1
