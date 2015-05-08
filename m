From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 1/2] media: new media controller API for device
	resource support
Date: Fri,  8 May 2015 13:31:30 -0600
Message-ID: <c7f3e48e130dd397046f59383921960a43f6eed8.1431110739.git.shuahkh@osg.samsung.com>
References: <cover.1431110739.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-06v.sys.comcast.net (resqmta-po-06v.sys.comcast.net
 [96.114.154.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ED6926058E
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 21:31:38 +0200 (CEST)
In-Reply-To: <cover.1431110739.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1431110739.git.shuahkh@osg.samsung.com>
References: <cover.1431110739.git.shuahkh@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, tiwai@suse.de, perex@perex.cz, agoode@google.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, vladcatoi@gmail.com, damien@zamaudio.com, chris.j.arges@canonical.com, takamichiho@gmail.com, misterpib@gmail.com, daniel@zonque.org, pmatilai@laiskiainen.org, jussi@sonarnerd.net, normalperson@yhbt.net, fisch602@gmail.com, joe@oampo.co.uk
Cc: alsa-devel@alsa-project.org, Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add new media controller API to allocate media device as a
device resource. When a media device is created on the main
struct device which is the parent device for the interface
device, it will be available to all drivers associated with
that interface. For example, if a usb media device driver
creates the media device on the main struct device which is
common for all the drivers that control the media device,
including the non-media ALSA driver, media controller API
can be used to share access to the resources on the media
device. This new interface provides the above described
feature. A second interface that finds and returns the media
device is added to allow drivers to find the media device
created by any of the drivers associated with the device.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/media-device.c | 33 +++++++++++++++++++++++++++++++++
 include/media/media-device.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
index 7b39440..1c32752 100644
--- a/drivers/media/media-device.c
+++ b/drivers/media/media-device.c
@@ -462,3 +462,36 @@ void media_device_unregister_entity(struct media_entity *entity)
 	entity->parent = NULL;
 }
 EXPORT_SYMBOL_GPL(media_device_unregister_entity);
+
+static void media_device_release_dr(struct device *dev, void *res)
+{
+}
+
+/*
+ * media_device_get_dr() - get media device as device resource
+ *			creates if one doesn't exist
+*/
+struct media_device *media_device_get_dr(struct device *dev)
+{
+	struct media_device *mdev;
+
+	mdev = devres_find(dev, media_device_release_dr, NULL, NULL);
+	if (mdev)
+		return mdev;
+
+	mdev = devres_alloc(media_device_release_dr,
+				sizeof(struct media_device), GFP_KERNEL);
+	if (!mdev)
+		return NULL;
+	return devres_get(dev, mdev, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(media_device_get_dr);
+
+/*
+ * media_device_find_dr() - find media device as device resource
+*/
+struct media_device *media_device_find_dr(struct device *dev)
+{
+	return devres_find(dev, media_device_release_dr, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(media_device_find_dr);
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 6e6db78..53d0fc3 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -95,6 +95,8 @@ void media_device_unregister(struct media_device *mdev);
 int __must_check media_device_register_entity(struct media_device *mdev,
 					      struct media_entity *entity);
 void media_device_unregister_entity(struct media_entity *entity);
+struct media_device *media_device_get_dr(struct device *dev);
+struct media_device *media_device_find_dr(struct device *dev);
 
 /* Iterate over all entities. */
 #define media_device_for_each_entity(entity, mdev)			\
-- 
2.1.4
