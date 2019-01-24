From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ALSA: hda: runtime PM is always active
Date: Thu, 24 Jan 2019 21:27:11 +0530
Message-ID: <1548345432-11449-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, abhijeet.kumar@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The runtime PM count is incremented and set to active during hda codec
device init, but it is decremented and set to suspend during exit only.
Hence the runtime PM status is always active and hda device cannot be
put to runtime suspend. Keeping device usage active for entire period,
though nothing really happening on the device, seems unnecessary.

This patch avoides incrementing runtime PM usage count of the device.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/hda/hdac_device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 95b073e..72aa342 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -31,9 +31,6 @@ static void default_release(struct device *dev)
  *
  * Returns zero for success or a negative error code.
  *
- * This function increments the runtime PM counter and marks it active.
- * The caller needs to turn it off appropriately later.
- *
  * The caller needs to set the device's release op properly by itself.
  */
 int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
@@ -55,8 +52,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	codec->bus = bus;
 	codec->addr = addr;
 	codec->type = HDA_DEV_CORE;
-	pm_runtime_set_active(&codec->dev);
-	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
 
 	err = snd_hdac_bus_add_device(bus, codec);
@@ -123,7 +118,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
  */
 void snd_hdac_device_exit(struct hdac_device *codec)
 {
-	pm_runtime_put_noidle(&codec->dev);
 	snd_hdac_bus_remove_device(codec->bus, codec);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
-- 
2.7.4
