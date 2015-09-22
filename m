From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH v3 08/21] media: v4l-core add v4l_enable/disable_media_tuner() helper functions
Date: Tue, 22 Sep 2015 11:19:27 -0600
Message-ID: <c1664f811e8e0fe10aed69fe2d2d24efbe9353fb.1442937669.git.shuahkh@osg.samsung.com>
References: <cover.1442937669.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1442937669.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1442937669.git.shuahkh@osg.samsung.com>
References: <cover.1442937669.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, tiwai@suse.de, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, stefanr@s5r6.in-berlin.de, crope@iki.fi, dan.carpenter@oracle.com, tskd08@gmail.com, ruchandani.tina@gmail.com, arnd@arndb.de, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, Julia.Lawall@lip6.fr, elfring@users.sourceforge.net, ricardo.ribalda@gmail.com, chris.j.arges@canonical.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, misterpib@gmail.com, takamichiho@gmail.com, pmatilai@laiskiainen.org, damien@zamaudio.com, daniel@zonque.org, vladcatoi@gmail.com, normalperson@yhbt.net, joe@oampo.co.uk, bugzilla.frnkcg@spamgourmet.com, jussi@sonarnerd.net
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a new interfaces to be used by v4l-core to invoke enable
source and disable_source handlers in the media_device. The
enable_source helper function invokes the enable_source handler
to find tuner entity connected to the decoder and check is it
is available or busy. If tuner is available, link is activated
and pipeline is started. The disable_source helper function
invokes the disable_source handler to deactivate and stop the
pipeline.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/v4l2-core/v4l2-dev.c | 27 +++++++++++++++++++++++++++
 include/media/v4l2-dev.h           |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 71a1b93..8e93c99 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -230,6 +230,33 @@ struct video_device *video_devdata(struct file *file)
 }
 EXPORT_SYMBOL(video_devdata);
 
+int v4l_enable_media_tuner(struct video_device *vdev)
+{
+#ifdef CONFIG_MEDIA_CONTROLLER
+	struct media_device *mdev = vdev->entity.parent;
+	int ret;
+
+	if (!mdev || !mdev->enable_source)
+			return 0;
+	ret = mdev->enable_source(&vdev->entity, &vdev->pipe);
+	if (ret)
+		return -EBUSY;
+	return 0;
+#endif /* CONFIG_MEDIA_CONTROLLER */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l_enable_media_tuner);
+
+void v4l_disable_media_tuner(struct video_device *vdev)
+{
+#ifdef CONFIG_MEDIA_CONTROLLER
+	struct media_device *mdev = vdev->entity.parent;
+
+	if (mdev && mdev->disable_source)
+		mdev->disable_source(&vdev->entity);
+#endif /* CONFIG_MEDIA_CONTROLLER */
+}
+EXPORT_SYMBOL_GPL(v4l_disable_media_tuner);
 
 /* Priority handling */
 
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index acbcd2f..8f1884f 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -86,6 +86,7 @@ struct video_device
 {
 #if defined(CONFIG_MEDIA_CONTROLLER)
 	struct media_entity entity;
+	struct media_pipeline pipe;
 #endif
 	/* device ops */
 	const struct v4l2_file_operations *fops;
@@ -178,6 +179,9 @@ struct video_device * __must_check video_device_alloc(void);
 /* this release function frees the vdev pointer */
 void video_device_release(struct video_device *vdev);
 
+int v4l_enable_media_tuner(struct video_device *vdev);
+void v4l_disable_media_tuner(struct video_device *vdev);
+
 /* this release function does nothing, use when the video_device is a
    static global struct. Note that having a static video_device is
    a dubious construction at best. */
-- 
2.1.4
