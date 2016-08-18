From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 3/3] ALSA: line6: Fix POD sysfs attributes
	segfault
Date: Thu, 18 Aug 2016 23:52:12 +0200
Message-ID: <1471557132-10206-4-git-send-email-dev@andree.sk>
References: <1471557132-10206-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 091EA26645B
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 23:52:52 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id q128so1220925wma.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 14:52:52 -0700 (PDT)
In-Reply-To: <1471557132-10206-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

The commit 02fc76f6a changed base of the sysfs attributes from device to card.
The "show" callbacks dereferenced wrong objects because of this.
---
 sound/usb/line6/pod.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index daf81d1..45dd348 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -244,8 +244,8 @@ static int pod_set_system_param_int(struct usb_line6_pod *pod, int value,
 static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct snd_card *card = dev_to_snd_card(dev);
+	struct usb_line6_pod *pod = card->private_data;
 
 	return sprintf(buf, "%u\n", pod->serial_number);
 }
@@ -256,8 +256,8 @@ static ssize_t serial_number_show(struct device *dev,
 static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct snd_card *card = dev_to_snd_card(dev);
+	struct usb_line6_pod *pod = card->private_data;
 
 	return sprintf(buf, "%d.%02d\n", pod->firmware_version / 100,
 		       pod->firmware_version % 100);
@@ -269,8 +269,8 @@ static ssize_t firmware_version_show(struct device *dev,
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct snd_card *card = dev_to_snd_card(dev);
+	struct usb_line6_pod *pod = card->private_data;
 
 	return sprintf(buf, "%d\n", pod->device_id);
 }
-- 
1.9.1
