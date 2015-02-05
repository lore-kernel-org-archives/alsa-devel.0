From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: line6: Create sysfs via
	snd_card_add_dev_attr()
Date: Thu,  5 Feb 2015 14:48:22 +0100
Message-ID: <1423144102-24801-2-git-send-email-tiwai@suse.de>
References: <1423144102-24801-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FFE9264F10
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 14:48:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 33F8EACF8
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 13:48:26 +0000 (UTC)
In-Reply-To: <1423144102-24801-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Use the new helper function to create sysfs entries in the card more
gracefully without races.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pod.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 61aadd7d4b7f..eb5a23ceac1c 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -330,6 +330,18 @@ static DEVICE_ATTR_RO(device_id);
 static DEVICE_ATTR_RO(firmware_version);
 static DEVICE_ATTR_RO(serial_number);
 
+static struct attribute *pod_dev_attrs[] = {
+	&dev_attr_device_id.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_serial_number.attr,
+	NULL
+};
+
+static const struct attribute_group pod_dev_attr_group = {
+	.name = "pod",
+	.attrs = pod_dev_attrs,
+};
+
 /* control info callback */
 static int snd_pod_control_monitor_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
@@ -387,35 +399,11 @@ static void line6_pod_disconnect(struct usb_line6 *line6)
 	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6;
 	struct device *dev = line6->ifcdev;
 
-	/* remove sysfs entries: */
-	device_remove_file(dev, &dev_attr_device_id);
-	device_remove_file(dev, &dev_attr_firmware_version);
-	device_remove_file(dev, &dev_attr_serial_number);
-
 	del_timer_sync(&pod->startup_timer);
 	cancel_work_sync(&pod->startup_work);
 }
 
 /*
-	Create sysfs entries.
-*/
-static int pod_create_files2(struct device *dev)
-{
-	int err;
-
-	err = device_create_file(dev, &dev_attr_device_id);
-	if (err < 0)
-		return err;
-	err = device_create_file(dev, &dev_attr_firmware_version);
-	if (err < 0)
-		return err;
-	err = device_create_file(dev, &dev_attr_serial_number);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
-/*
 	 Try to init POD device.
 */
 static int pod_init(struct usb_line6 *line6,
@@ -431,7 +419,7 @@ static int pod_init(struct usb_line6 *line6,
 	INIT_WORK(&pod->startup_work, pod_startup4);
 
 	/* create sysfs entries: */
-	err = pod_create_files2(line6->ifcdev);
+	err = snd_card_add_dev_attr(line6->card, pod_dev_attrs);
 	if (err < 0)
 		return err;
 
-- 
2.2.2
