From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: hdac_hdmi: Fix potential NULL dereference
Date: Tue, 31 May 2016 19:09:55 +0530
Message-ID: <1464701995-23452-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 553D026058E
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 15:33:37 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Static checker warns:
Pointer 'hlink' returned from call to function 'snd_hdac_ext_bus_get_link'
at line may be NULL and will be dereferenced"

So we should always check the return of snd_hdac_ext_bus_get_link() before
referencing the link pointer

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 13002f33384e..cc7bb77a28f1 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1388,6 +1388,11 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	 * exit, we call pm_runtime_suspend() so that will do for us
 	 */
 	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	if (!hlink) {
+		dev_err(&edev->hdac.dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
 
 	ret = create_fill_widget_route_map(dapm);
@@ -1494,6 +1499,11 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	if (!hlink) {
+		dev_err(&edev->hdac.dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
 
 	hdmi_priv = devm_kzalloc(&codec->dev, sizeof(*hdmi_priv), GFP_KERNEL);
@@ -1600,6 +1610,11 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	}
 
 	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_put(ebus, hlink);
 
 	return 0;
@@ -1621,6 +1636,11 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 		return 0;
 
 	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(ebus, hlink);
 
 	err = snd_hdac_display_power(bus, true);
-- 
1.9.1
