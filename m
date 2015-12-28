From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 4/4] ASoC: hdac_hdmi: use dev_to_hdac_dev and to_ehdac_device
Date: Mon, 28 Dec 2015 22:47:13 +0800
Message-ID: <a740643997f286e5ec60d523ddcb9d42f78f514a.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use dev_to_hdac_dev() and to_ehdac_device() instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1a2f33b..b999fb2 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -67,9 +67,9 @@ struct hdac_hdmi_priv {
 
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 {
-	struct hdac_device *hdac = container_of(dev, struct hdac_device, dev);
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
 
-	return container_of(hdac, struct hdac_ext_device, hdac);
+	return to_ehdac_device(hdac);
 }
 
 static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
-- 
2.5.0
