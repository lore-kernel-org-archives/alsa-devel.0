From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 09/11] ASoC: hdac_hda: add runtime PM support
Date: Fri, 15 Dec 2017 17:00:46 +0530
Message-ID: <1513337448-31685-10-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 972EB267BAA
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:37 +0100 (CET)
In-Reply-To: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add power management support.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/codecs/hdac_hda.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 4b4d80c..22cabd4 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -546,8 +546,57 @@ static int hdac_hda_dev_remove(struct hdac_device *hdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int hdac_hda_runtime_suspend(struct device *dev)
+{
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
+	struct hdac_bus *bus = hdac->bus;
+	struct hdac_ext_link *hlink = NULL;
+
+	dev_dbg(dev, "%s: entry\n", __func__);
+
+	dev_dbg(dev, "calling legacy codec suspend\n");
+	hda_codec_runtime_suspend(dev);
+	dev_dbg(dev, "legacy codec suspended\n");
+
+	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+	snd_hdac_ext_bus_link_put(bus, hlink);
+	return 0;
+}
+
+static int hdac_hda_runtime_resume(struct device *dev)
+{
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
+	struct hdac_bus *bus = hdac->bus;
+	struct hdac_ext_link *hlink = NULL;
+
+	dev_dbg(dev, "%s: entry\n", __func__);
+
+	/* controller may not have been initialized for the first time */
+	if (!bus)
+		return 0;
+
+	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+	snd_hdac_ext_bus_link_get(bus, hlink);
+
+	dev_dbg(dev, "calling legacy codec resume\n");
+	hda_codec_runtime_resume(dev);
+	dev_dbg(dev, "%s: exit\n", __func__);
+
+	return 0;
+}
+#else
 #define hdac_hda_runtime_suspend NULL
 #define hdac_hda_runtime_resume NULL
+#endif
 
 static const struct dev_pm_ops hdac_hda_pm = {
 	SET_RUNTIME_PM_OPS(hdac_hda_runtime_suspend,
-- 
2.7.4
