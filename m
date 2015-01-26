From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: line6: Let snd_card_new() allocate
	private data
Date: Mon, 26 Jan 2015 13:48:42 +0100
Message-ID: <1422276523-14336-3-git-send-email-tiwai@suse.de>
References: <1422276523-14336-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EA382260574
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:48:44 +0100 (CET)
In-Reply-To: <1422276523-14336-1-git-send-email-tiwai@suse.de>
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

Instead of allocating the private data individually in each driver's
probe at first, let snd_card_new() allocate the data that is called in
line6_probe().  This simplifies the primary probe functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   | 25 ++++++++++---------------
 sound/usb/line6/driver.h   |  4 ++--
 sound/usb/line6/pod.c      |  9 ++-------
 sound/usb/line6/podhd.c    |  9 ++-------
 sound/usb/line6/toneport.c |  9 ++-------
 sound/usb/line6/variax.c   |  9 ++-------
 6 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index e2fbff05c1b1..c696f9773cbb 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -418,11 +418,7 @@ EXPORT_SYMBOL_GPL(line6_read_serial_number);
 static void line6_destruct(struct snd_card *card)
 {
 	struct usb_line6 *line6 = card->private_data;
-	struct usb_device *usbdev;
-
-	if (!line6)
-		return;
-	usbdev = line6->usbdev;
+	struct usb_device *usbdev = line6->usbdev;
 
 	/* free buffer memory first: */
 	kfree(line6->buffer_message);
@@ -431,9 +427,6 @@ static void line6_destruct(struct snd_card *card)
 	/* then free URBs: */
 	usb_free_urb(line6->urb_listen);
 
-	/* free interface data: */
-	kfree(line6);
-
 	/* decrement reference counters: */
 	usb_put_dev(usbdev);
 }
@@ -489,24 +482,27 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 */
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
-		struct usb_line6 *line6,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id))
+		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
+		size_t data_size)
 {
 	struct usb_device *usbdev = interface_to_usbdev(interface);
 	struct snd_card *card;
+	struct usb_line6 *line6;
 	int interface_number;
 	int ret;
 
+	if (WARN_ON(data_size < sizeof(*line6)))
+		return -EINVAL;
+
 	ret = snd_card_new(&interface->dev,
 			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			   THIS_MODULE, 0, &card);
-	if (ret < 0) {
-		kfree(line6);
+			   THIS_MODULE, data_size, &card);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* store basic data: */
+	line6 = card->private_data;
 	line6->card = card;
 	line6->properties = properties;
 	line6->usbdev = usbdev;
@@ -517,7 +513,6 @@ int line6_probe(struct usb_interface *interface,
 	strcpy(card->shortname, line6->properties->name);
 	sprintf(card->longname, "Line 6 %s at USB %s", line6->properties->name,
 		dev_name(line6->ifcdev));
-	card->private_data = line6;
 	card->private_free = line6_destruct;
 
 	usb_set_intfdata(interface, line6);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 4dc6c28e8224..fce10f12f0d3 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -181,9 +181,9 @@ extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
-		struct usb_line6 *line6,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id));
+		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
+		size_t data_size);
 
 void line6_disconnect(struct usb_interface *interface);
 
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index d1e952fbcae7..6f7cd585f2d8 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -591,14 +591,9 @@ static const struct line6_properties pod_properties_table[] = {
 static int pod_probe(struct usb_interface *interface,
 		     const struct usb_device_id *id)
 {
-	struct usb_line6_pod *pod;
-
-	pod = kzalloc(sizeof(*pod), GFP_KERNEL);
-	if (!pod)
-		return -ENODEV;
-	return line6_probe(interface, id, &pod->line6,
+	return line6_probe(interface, id,
 			   &pod_properties_table[id->driver_info],
-			   pod_init);
+			   pod_init, sizeof(struct usb_line6_pod));
 }
 
 static struct usb_driver pod_driver = {
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 21d7edcfa272..43c39886597e 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -177,14 +177,9 @@ static const struct line6_properties podhd_properties_table[] = {
 static int podhd_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
-	struct usb_line6_podhd *podhd;
-
-	podhd = kzalloc(sizeof(*podhd), GFP_KERNEL);
-	if (!podhd)
-		return -ENODEV;
-	return line6_probe(interface, id, &podhd->line6,
+	return line6_probe(interface, id,
 			   &podhd_properties_table[id->driver_info],
-			   podhd_init);
+			   podhd_init, sizeof(struct usb_line6_podhd));
 }
 
 static struct usb_driver podhd_driver = {
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 8e7020df0d10..33d16ecf18a0 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -558,14 +558,9 @@ static const struct line6_properties toneport_properties_table[] = {
 static int toneport_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
-	struct usb_line6_toneport *toneport;
-
-	toneport = kzalloc(sizeof(*toneport), GFP_KERNEL);
-	if (!toneport)
-		return -ENODEV;
-	return line6_probe(interface, id, &toneport->line6,
+	return line6_probe(interface, id,
 			   &toneport_properties_table[id->driver_info],
-			   toneport_init);
+			   toneport_init, sizeof(struct usb_line6_toneport));
 }
 
 static struct usb_driver toneport_driver = {
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index ba6e85eed2ba..9701ffa61365 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -296,14 +296,9 @@ static const struct line6_properties variax_properties_table[] = {
 static int variax_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
-	struct usb_line6_variax *variax;
-
-	variax = kzalloc(sizeof(*variax), GFP_KERNEL);
-	if (!variax)
-		return -ENODEV;
-	return line6_probe(interface, id, &variax->line6,
+	return line6_probe(interface, id,
 			   &variax_properties_table[id->driver_info],
-			   variax_init);
+			   variax_init, sizeof(struct usb_line6_variax));
 }
 
 static struct usb_driver variax_driver = {
-- 
2.2.2
