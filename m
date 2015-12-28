From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 2/4] ALSA: hdac: drop unused dev_to_hdac macro
Date: Mon, 28 Dec 2015 22:47:11 +0800
Message-ID: <b86ede48c70d4f57bb72d52045e4f2afe12a88ae.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

dev_to_hdac is not used anymore so drop it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/hda/ext/hdac_ext_bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 2433f7c..58f6b98 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -197,8 +197,6 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
-#define dev_to_hdac(dev) (container_of((dev), \
-			struct hdac_device, dev))
 
 static inline struct hdac_ext_driver *get_edrv(struct device *dev)
 {
-- 
2.5.0
