From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: line6: Remove superfluous NULL
	checks in each driver
Date: Tue, 20 Jan 2015 10:04:18 +0100
Message-ID: <1421744662-6497-4-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B69FA260487
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 10:04:36 +0100 (CET)
In-Reply-To: <1421744662-6497-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The interface and driver objects are always set when callbacks are
called.  Drop such superfluous NULL checks in init and disconnect
calls of each driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pod.c      | 28 ++++++++--------------------
 sound/usb/line6/podhd.c    |  4 ----
 sound/usb/line6/toneport.c |  6 ------
 sound/usb/line6/variax.c   |  8 --------
 4 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index bf027fc70cba..26ecf26a33ec 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -401,25 +401,16 @@ static struct snd_kcontrol_new pod_control_monitor = {
 */
 static void line6_pod_disconnect(struct usb_interface *interface)
 {
-	struct usb_line6_pod *pod;
-
-	if (interface == NULL)
-		return;
-	pod = usb_get_intfdata(interface);
-
-	if (pod != NULL) {
-		struct device *dev = &interface->dev;
+	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct device *dev = &interface->dev;
 
-		if (dev != NULL) {
-			/* remove sysfs entries: */
-			device_remove_file(dev, &dev_attr_device_id);
-			device_remove_file(dev, &dev_attr_firmware_version);
-			device_remove_file(dev, &dev_attr_serial_number);
-		}
+	/* remove sysfs entries: */
+	device_remove_file(dev, &dev_attr_device_id);
+	device_remove_file(dev, &dev_attr_firmware_version);
+	device_remove_file(dev, &dev_attr_serial_number);
 
-		del_timer_sync(&pod->startup_timer);
-		cancel_work_sync(&pod->startup_work);
-	}
+	del_timer_sync(&pod->startup_timer);
+	cancel_work_sync(&pod->startup_work);
 }
 
 /*
@@ -456,9 +447,6 @@ static int pod_init(struct usb_interface *interface,
 	init_timer(&pod->startup_timer);
 	INIT_WORK(&pod->startup_work, pod_startup4);
 
-	if ((interface == NULL) || (pod == NULL))
-		return -ENODEV;
-
 	/* create sysfs entries: */
 	err = pod_create_files2(&interface->dev);
 	if (err < 0)
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 7217fa7e5db1..59abbd92624e 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -90,12 +90,8 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 static int podhd_init(struct usb_interface *interface,
 		      struct usb_line6 *line6)
 {
-	struct usb_line6_podhd *podhd = (struct usb_line6_podhd *) line6;
 	int err;
 
-	if ((interface == NULL) || (podhd == NULL))
-		return -ENODEV;
-
 	/* initialize MIDI subsystem: */
 	err = line6_init_midi(line6);
 	if (err < 0)
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index c1f61cde52ab..e5669bd3233a 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -370,9 +370,6 @@ static void line6_toneport_disconnect(struct usb_interface *interface)
 	struct usb_line6_toneport *toneport;
 	u16 idProduct;
 
-	if (interface == NULL)
-		return;
-
 	toneport = usb_get_intfdata(interface);
 	del_timer_sync(&toneport->timer);
 	idProduct = le16_to_cpu(toneport->line6.usbdev->descriptor.idProduct);
@@ -393,9 +390,6 @@ static int toneport_init(struct usb_interface *interface,
 	int err;
 	struct usb_line6_toneport *toneport =  (struct usb_line6_toneport *) line6;
 
-	if ((interface == NULL) || (toneport == NULL))
-		return -ENODEV;
-
 	line6->disconnect = line6_toneport_disconnect;
 
 	/* initialize PCM subsystem: */
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 99a58cbfd2da..cd3adeffde02 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -214,12 +214,7 @@ static void line6_variax_disconnect(struct usb_interface *interface)
 {
 	struct usb_line6_variax *variax;
 
-	if (!interface)
-		return;
-
 	variax = usb_get_intfdata(interface);
-	if (!variax)
-		return;
 
 	del_timer(&variax->startup_timer1);
 	del_timer(&variax->startup_timer2);
@@ -244,9 +239,6 @@ static int variax_init(struct usb_interface *interface,
 	init_timer(&variax->startup_timer2);
 	INIT_WORK(&variax->startup_work, variax_startup6);
 
-	if ((interface == NULL) || (variax == NULL))
-		return -ENODEV;
-
 	/* initialize USB buffers: */
 	variax->buffer_activate = kmemdup(variax_activate,
 					  sizeof(variax_activate), GFP_KERNEL);
-- 
2.2.1
