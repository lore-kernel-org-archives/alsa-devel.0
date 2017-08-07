From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH RESEND1 03/12] ALSA: vsnd: Implement Xen bus
	state handling
Date: Mon,  7 Aug 2017 15:22:48 +0300
Message-ID: <1502108577-8099-4-git-send-email-andr2000@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 70297267205
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 14:23:07 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id t128so214146lff.3
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 05:23:07 -0700 (PDT)
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

Initial handling for Xen bus states: implement
Xen bus state machine for the front driver according to
the state diagram and recovery flow from sound para-virtualized
protocol: xen/interface/io/sndif.h.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 sound/drivers/xen-front.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/sound/drivers/xen-front.c b/sound/drivers/xen-front.c
index 8c5de7b0e7b5..c4fd21cac3a7 100644
--- a/sound/drivers/xen-front.c
+++ b/sound/drivers/xen-front.c
@@ -36,9 +36,99 @@ static void xdrv_remove_internal(struct xdrv_info *drv_info)
 {
 }
 
+static int xdrv_be_on_initwait(struct xdrv_info *drv_info)
+{
+	return 0;
+}
+
+static inline int xdrv_be_on_connected(struct xdrv_info *drv_info)
+{
+	return 0;
+}
+
+static inline void xdrv_be_on_disconnected(struct xdrv_info *drv_info)
+{
+	xdrv_remove_internal(drv_info);
+}
+
 static void xdrv_be_on_changed(struct xenbus_device *xb_dev,
 	enum xenbus_state backend_state)
 {
+	struct xdrv_info *drv_info = dev_get_drvdata(&xb_dev->dev);
+	int ret;
+
+	switch (backend_state) {
+	case XenbusStateReconfiguring:
+		/* fall through */
+	case XenbusStateReconfigured:
+		/* fall through */
+	case XenbusStateInitialised:
+		/* fall through */
+		break;
+
+	case XenbusStateInitialising:
+		if (xb_dev->state == XenbusStateInitialising)
+			break;
+
+		/* recovering after backend unexpected closure */
+		mutex_lock(&drv_info->mutex);
+		xdrv_be_on_disconnected(drv_info);
+		mutex_unlock(&drv_info->mutex);
+		xenbus_switch_state(xb_dev, XenbusStateInitialising);
+		break;
+
+	case XenbusStateInitWait:
+		if (xb_dev->state != XenbusStateInitialising)
+			break;
+
+		mutex_lock(&drv_info->mutex);
+		ret = xdrv_be_on_initwait(drv_info);
+		mutex_unlock(&drv_info->mutex);
+		if (ret < 0) {
+			xenbus_dev_fatal(xb_dev, ret,
+				"initializing " XENSND_DRIVER_NAME);
+			break;
+		}
+
+		xenbus_switch_state(xb_dev, XenbusStateInitialised);
+		break;
+
+	case XenbusStateConnected:
+		if (xb_dev->state != XenbusStateInitialised)
+			break;
+
+		mutex_lock(&drv_info->mutex);
+		ret = xdrv_be_on_connected(drv_info);
+		mutex_unlock(&drv_info->mutex);
+		if (ret < 0) {
+			xenbus_dev_fatal(xb_dev, ret,
+				"connecting " XENSND_DRIVER_NAME);
+			break;
+		}
+
+		xenbus_switch_state(xb_dev, XenbusStateConnected);
+		break;
+
+	case XenbusStateClosing:
+		/*
+		 * in this state backend starts freeing resources,
+		 * so let it go into closed state first, so we can also
+		 * remove ours
+		 */
+		break;
+
+	case XenbusStateUnknown:
+		/* fall through */
+	case XenbusStateClosed:
+		if (xb_dev->state == XenbusStateClosed)
+			break;
+
+		mutex_lock(&drv_info->mutex);
+		xdrv_be_on_disconnected(drv_info);
+		mutex_unlock(&drv_info->mutex);
+		xenbus_switch_state(xb_dev, XenbusStateInitialising);
+		break;
+	}
 }
 
 static int xdrv_probe(struct xenbus_device *xb_dev,
@@ -56,6 +146,7 @@ static int xdrv_probe(struct xenbus_device *xb_dev,
 	spin_lock_init(&drv_info->io_lock);
 	mutex_init(&drv_info->mutex);
 	dev_set_drvdata(&xb_dev->dev, drv_info);
+	xenbus_switch_state(xb_dev, XenbusStateInitialising);
 	return 0;
 }
 
@@ -63,6 +154,7 @@ static int xdrv_remove(struct xenbus_device *dev)
 {
 	struct xdrv_info *drv_info = dev_get_drvdata(&dev->dev);
 
+	xenbus_switch_state(dev, XenbusStateClosed);
 	mutex_lock(&drv_info->mutex);
 	xdrv_remove_internal(drv_info);
 	mutex_unlock(&drv_info->mutex);
-- 
2.7.4
