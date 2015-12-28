From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 3/4] ALSA: hdac: use dev_to_hdac_dev
Date: Mon, 28 Dec 2015 22:47:12 +0800
Message-ID: <792658f052baf3b7d110964c1caaa49541cbed30.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-138.163.com (m50-138.163.com [123.125.50.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 72D4C2652B0
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2015 15:47:31 +0100 (CET)
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
In-Reply-To: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use dev_to_hdac_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/hda/ext/hdac_ext_bus.c | 2 +-
 sound/hda/hdac_device.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 58f6b98..2522943 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -122,7 +122,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_exit);
 
 static void default_release(struct device *dev)
 {
-	snd_hdac_ext_bus_device_exit(container_of(dev, struct hdac_device, dev));
+	snd_hdac_ext_bus_device_exit(dev_to_hdac_dev(dev));
 }
 
 /**
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index e361024..959f7d9 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -18,7 +18,7 @@ static int get_codec_vendor_name(struct hdac_device *codec);
 
 static void default_release(struct device *dev)
 {
-	snd_hdac_device_exit(container_of(dev, struct hdac_device, dev));
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
 }
 
 /**
-- 
2.5.0
