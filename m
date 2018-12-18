From: shuah@kernel.org
Subject: [PATCH v9 2/4] media: change au0828 to use Media
	Device Allocator API
Date: Tue, 18 Dec 2018 10:59:37 -0700
Message-ID: <cb64bdd0a90c7084b23857160b6471118cd80c94.1545154778.git.shuah@kernel.org>
References: <cover.1545154777.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CDE0267946
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 18:59:45 +0100 (CET)
In-Reply-To: <cover.1545154777.git.shuah@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com, hverkuil@xs4all.nl
Cc: alsa-devel@alsa-project.org, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Shuah Khan <shuah@kernel.org>

Media Device Allocator API to allows multiple drivers share a media device.
This API solves a very common use-case for media devices where one physical
device (an USB stick) provides both audio and video. When such media device
exposes a standard USB Audio class, a proprietary Video class, two or more
independent drivers will share a single physical USB bridge. In such cases,
it is necessary to coordinate access to the shared resource.

Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

Change au0828 to use Media Device Allocator API to allocate media device
with the parent usb struct device as the key, so it can be shared with the
snd_usb_audio driver.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/media/usb/au0828/au0828-core.c | 12 ++++--------
 drivers/media/usb/au0828/au0828.h      |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 1fdb1601dc65..4b0a395d59aa 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -155,9 +155,7 @@ static void au0828_unregister_media_device(struct au0828_dev *dev)
 	dev->media_dev->disable_source = NULL;
 	mutex_unlock(&mdev->graph_mutex);
 
-	media_device_unregister(dev->media_dev);
-	media_device_cleanup(dev->media_dev);
-	kfree(dev->media_dev);
+	media_device_delete(dev->media_dev, KBUILD_MODNAME);
 	dev->media_dev = NULL;
 #endif
 }
@@ -210,14 +208,10 @@ static int au0828_media_device_init(struct au0828_dev *dev,
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_device *mdev;
 
-	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	mdev = media_device_usb_allocate(udev, KBUILD_MODNAME);
 	if (!mdev)
 		return -ENOMEM;
 
-	/* check if media device is already initialized */
-	if (!mdev->dev)
-		media_device_usb_init(mdev, udev, udev->product);
-
 	dev->media_dev = mdev;
 #endif
 	return 0;
@@ -480,6 +474,8 @@ static int au0828_media_device_register(struct au0828_dev *dev,
 		/* register media device */
 		ret = media_device_register(dev->media_dev);
 		if (ret) {
+			media_device_delete(dev->media_dev, KBUILD_MODNAME);
+			dev->media_dev = NULL;
 			dev_err(&udev->dev,
 				"Media Device Register Error: %d\n", ret);
 			return ret;
diff --git a/drivers/media/usb/au0828/au0828.h b/drivers/media/usb/au0828/au0828.h
index 004eadef55c7..7dbe3db15ebe 100644
--- a/drivers/media/usb/au0828/au0828.h
+++ b/drivers/media/usb/au0828/au0828.h
@@ -31,6 +31,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fh.h>
 #include <media/media-device.h>
+#include <media/media-dev-allocator.h>
 
 /* DVB */
 #include <media/demux.h>
-- 
2.17.1
