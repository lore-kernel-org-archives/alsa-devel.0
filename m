From: Vincent Abriou <vincent.abriou@st.com>
Subject: [PATCH v2] ASoc: hdmi-codec: remove HDMI device
	unregister
Date: Wed, 8 Feb 2017 10:47:01 +0100
Message-ID: <1486547221-32593-1-git-send-email-vincent.abriou@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A63E82669E6
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 10:47:09 +0100 (CET)
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Vincent Abriou <vincent.abriou@st.com>
List-Id: alsa-devel@alsa-project.org

While unregistering the hdmi-codec, the hdmi device list must be
cleaned up. It avoid kernel page fault when registering again the
hdmi-codec.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
---
v2:
 - add mutex to protect hdmi_device_list from concurrent accesses
 - use of internal dev variable in the hdmi_codec_remove function

 sound/soc/codecs/hdmi-codec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index dc6715a..8c5ae1f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -32,6 +32,7 @@ struct hdmi_device {
 };
 #define pos_to_hdmi_device(pos)	container_of((pos), struct hdmi_device, list)
 LIST_HEAD(hdmi_device_list);
+static DEFINE_MUTEX(hdmi_mutex);
 
 #define DAI_NAME_SIZE 16
 
@@ -794,6 +795,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hd = NULL;
+	mutex_lock(&hdmi_mutex);
 	list_for_each(pos, &hdmi_device_list) {
 		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
 
@@ -805,13 +807,16 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 	if (!hd) {
 		hd = devm_kzalloc(dev, sizeof(*hd), GFP_KERNEL);
-		if (!hd)
+		if (!hd) {
+			mutex_unlock(&hdmi_mutex);
 			return -ENOMEM;
+		}
 
 		hd->dev = dev->parent;
 
 		list_add_tail(&hd->list, &hdmi_device_list);
 	}
+	mutex_unlock(&hdmi_mutex);
 
 	if (hd->cnt >= ARRAY_SIZE(hdmi_dai_name)) {
 		dev_err(dev, "too many hdmi codec are deteced\n");
@@ -853,11 +858,25 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct list_head *pos;
 	struct hdmi_codec_priv *hcp;
 
-	hcp = dev_get_drvdata(&pdev->dev);
+	mutex_lock(&hdmi_mutex);
+	list_for_each(pos, &hdmi_device_list) {
+		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
+
+		if (tmp->dev == dev->parent) {
+			list_del(pos);
+			break;
+		}
+	}
+	mutex_unlock(&hdmi_mutex);
+
+	hcp = dev_get_drvdata(dev);
 	kfree(hcp->chmap_info);
-	snd_soc_unregister_codec(&pdev->dev);
+	snd_soc_unregister_codec(dev);
+
 	return 0;
 }
 
-- 
2.7.4
