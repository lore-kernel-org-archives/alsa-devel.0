From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH RESEND1 02/12] ALSA: vsnd: Implement driver's
	probe/remove
Date: Mon,  7 Aug 2017 15:22:47 +0300
Message-ID: <1502108577-8099-3-git-send-email-andr2000@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 95C2D2669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 14:23:06 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id o85so222238lff.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 05:23:06 -0700 (PDT)
In-Reply-To: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add essential driver private info structure, initialize
locks and implement probe/remove of the Xen frontend
driver.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 sound/drivers/xen-front.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/drivers/xen-front.c b/sound/drivers/xen-front.c
index 61779c36cae3..8c5de7b0e7b5 100644
--- a/sound/drivers/xen-front.c
+++ b/sound/drivers/xen-front.c
@@ -26,6 +26,16 @@
 
 #include <xen/interface/io/sndif.h>
 
+struct xdrv_info {
+	struct xenbus_device *xb_dev;
+	spinlock_t io_lock;
+	struct mutex mutex;
+};
+
+static void xdrv_remove_internal(struct xdrv_info *drv_info)
+{
+}
+
 static void xdrv_be_on_changed(struct xenbus_device *xb_dev,
 	enum xenbus_state backend_state)
 {
@@ -34,11 +44,28 @@ static void xdrv_be_on_changed(struct xenbus_device *xb_dev,
 static int xdrv_probe(struct xenbus_device *xb_dev,
 	const struct xenbus_device_id *id)
 {
+	struct xdrv_info *drv_info;
+
+	drv_info = devm_kzalloc(&xb_dev->dev, sizeof(*drv_info), GFP_KERNEL);
+	if (!drv_info) {
+		xenbus_dev_fatal(xb_dev, -ENOMEM, "allocating device memory");
+		return -ENOMEM;
+	}
+
+	drv_info->xb_dev = xb_dev;
+	spin_lock_init(&drv_info->io_lock);
+	mutex_init(&drv_info->mutex);
+	dev_set_drvdata(&xb_dev->dev, drv_info);
 	return 0;
 }
 
 static int xdrv_remove(struct xenbus_device *dev)
 {
+	struct xdrv_info *drv_info = dev_get_drvdata(&dev->dev);
+
+	mutex_lock(&drv_info->mutex);
+	xdrv_remove_internal(drv_info);
+	mutex_unlock(&drv_info->mutex);
 	return 0;
 }
 
-- 
2.7.4
